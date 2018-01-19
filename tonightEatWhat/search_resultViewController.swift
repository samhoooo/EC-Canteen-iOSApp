//
//  search_resultViewController.swift
//  tonightEatWhat
//
//  Created by SYH on 17/7/2017.
//  Copyright © 2017 jaar.ga. All rights reserved.
//

import UIKit

class search_resultViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var result_collection_view: UICollectionView!

    var images = ["coffeecon1", "coffeecon1", "coffeecon1", "coffeecon1", "coffeecon1", "coffeecon1", "coffeecon1", "coffeecon1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.result_collection_view.delegate = self
        self.result_collection_view.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // this function is used to calculate how many result data. Comment by Sunny
        
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // this function is used to set the result cell parameter. Comment by Sunny
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "result_cell", for: indexPath) as! search_resultCollectionViewCell
        
        cell.result_name.text = "Coffee Corner"
        cell.result_image.image = UIImage(named: images[indexPath.row])
        
        cell.like_border.layer.cornerRadius = cell.like_border.frame.size.height / 2
        cell.like_number.text = "99k"
        
        /*cell.ingredient_1.layer.cornerRadius = cell.ingredient_1.frame.size.width / 2
        cell.ingredient_1.layer.borderWidth = cell.ingredient_1.frame.size.width / 20
        cell.ingredient_1.layer.borderColor = UIColor.orange.cgColor
        cell.ingredient_1.image = UIImage(named: images[indexPath.row])
        
        cell.ingredient_2.layer.cornerRadius = cell.ingredient_1.frame.size.width / 2
        cell.ingredient_2.layer.borderWidth = cell.ingredient_2.frame.size.width / 20
        cell.ingredient_2.layer.borderColor = UIColor.orange.cgColor
        cell.ingredient_2.image = UIImage(named: images[indexPath.row])
        
        cell.ingredient_3.layer.cornerRadius = cell.ingredient_1.frame.size.width / 2
        cell.ingredient_3.layer.borderWidth = cell.ingredient_3.frame.size.width / 20
        cell.ingredient_3.layer.borderColor = UIColor.orange.cgColor
        cell.ingredient_3.image = UIImage(named: images[indexPath.row])
        
        cell.ingredient_other.text = "... +1"
        
        let tap_ingredient: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(show_ingredient(sender:)))
        tap_ingredient.numberOfTapsRequired = 1
        cell.ingredient_show.isUserInteractionEnabled = true
        cell.ingredient_show.tag = indexPath.row
        cell.ingredient_show.addGestureRecognizer(tap_ingredient)*/
        
        let tap_recipe: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(show_recipe(sender:)))
        tap_recipe.numberOfTapsRequired = 1
        cell.recipe_show.isUserInteractionEnabled = true
        cell.recipe_show.tag = indexPath.row
        cell.recipe_show.addGestureRecognizer(tap_recipe)
        
        return cell
    }
    
    func show_recipe(sender: UITapGestureRecognizer) {
        print("recipe", sender.view?.tag ?? "tapped")
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let view_controller = storyboard.instantiateViewController(withIdentifier:"asd")
        self.show(view_controller, sender: self)
    }
    
    func show_ingredient(sender: UITapGestureRecognizer) {
        print("ingredient", sender.view?.tag ?? "tapped")
        let ingredient_page = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ingredient_page") as! ingredient_showViewController
        self.addChildViewController(ingredient_page)
        ingredient_page.view.frame = self.view.frame
        self.view.addSubview(ingredient_page.view)
        ingredient_page.didMove(toParentViewController: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
