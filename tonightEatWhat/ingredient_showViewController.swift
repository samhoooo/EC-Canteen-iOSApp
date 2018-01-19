//
//  ingredient_showViewController.swift
//  tonightEatWhat
//
//  Created by SYH on 26/7/2017.
//  Copyright © 2017 jaar.ga. All rights reserved.
//

import UIKit

class ingredient_showViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var ingredient_page: UIView!
    
    @IBOutlet weak var ingredient_collection_view: UICollectionView!
    
    @IBOutlet weak var recipe_name: UILabel!
    
    var image = ["shrimps1", "shrimps2", "shrimps3", "shrimps4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.ingredient_collection_view.delegate = self
        self.ingredient_collection_view.dataSource = self
        self.ingredient_page.layer.cornerRadius = self.ingredient_page.frame.size.width / 10
        
        self.recipe_name.text = "Coffee Corner"
        
        show_animation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close_ingredient_page(_ sender: Any) {
        close_animation()
//        self.view.removeFromSuperview()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ingredient_cell", for: indexPath) as! ingredient_showCollectionViewCell
        
        cell.ingredient_image.layer.cornerRadius = cell.ingredient_image.frame.size.width / 2
        cell.ingredient_image.layer.borderWidth = cell.ingredient_image.frame.size.width / 20
        cell.ingredient_image.layer.borderColor = UIColor.orange.cgColor
        cell.ingredient_image.image = UIImage(named: image[indexPath.row])
        
        cell.ingredient_name.text = "蝦"
        
        return cell
    }
    
    func show_animation() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        self.ingredient_page.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        self.ingredient_page.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
            self.ingredient_page.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.ingredient_page.alpha = 1.0
        })
    }
    
    func close_animation() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
            self.ingredient_page.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            self.ingredient_page.alpha = 0.0
        }, completion: {(finished: Bool) in
            if(finished) {
                self.view.removeFromSuperview()
            }
        })
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
