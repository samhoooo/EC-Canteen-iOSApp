//
//  MealTableViewCell.swift
//  EC Canteen
//
//  Created by John on 22/1/2018.
//  Copyright © 2018年 MHW1701. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MealTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var mealPhotoImageView: UIImageView!
    @IBOutlet weak var mealPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

//
//  mealTableViewController.swift
//  tonightEatWhat
//
//  Created by Sam on 30/11/2017.
//  Copyright © 2017年 jaar.ga. All rights reserved.
//



class mealTableViewController: UITableViewController {
    
    //MARK: Properties
    var menu:Menu = Menu()
    var restaurantId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ResuaurantId: \(restaurantId)")
           //load the sample meals to tableView
        loadSampleMeals()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.menu.columns.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menu.columns[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.menu.columns[section].column_name
    }
    
    //MARK: Private Methods
    
    private func loadSampleMeals() {
        
        //let photo1 = UIImage(named: "coffeecon_meal1")
        //let photo2 = UIImage(named: "coffeecon_meal2")
        //let photo3 = UIImage(named: "coffeecon_meal3")
        //let photo4 = UIImage(named: "coffeecon_meal4")
        
        Alamofire.request("\(Constants.API_BASE)/restaurants/"+String(restaurantId)+"/menus/current",method:.get).responseJSON{ response in
            
            if let status = response.response?.statusCode{
                switch(status){
                case 200:
                    print("successful getting menu data")
                default:
                    print("error to get menu data with response status: \(status)")
                }
            }
            
            if response.result.value != nil {
                if response.result.isSuccess {
                    do {
                        let json: JSON = try JSON(data: response.data!)
                        self.menu = Menu(menu: json["menu"])
                        self.tableView.reloadData()
                        print(self.menu)
                    } catch {
                        print(error)
                    }
                }
            }
        }
        
        
        /*guard let meal1 = Meal(name:"Caprese Salad",photo: photo1,price: 14.5) else{
         fatalError("Unable to instantiate meal1")
         }
         
         guard let meal2 = Meal(name:"Chicken and Potatoes",photo: photo2,price: 24.5) else{
         fatalError("Unable to instantiate meal2")
         }
         
         guard let meal3 = Meal(name:"Pasta with Meatballs",photo: photo3,price: 22) else{
         fatalError("Unable to instantiate meal3")
         }
         
         guard let meal4 = Meal(name:"Pasta with Meatballs",photo: photo4,price: 30) else{
         fatalError("Unable to instantiate meal3")
         }
         
         meals += [meal1,meal2,meal3,meal4]*/
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MealTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else{
            fatalError("the dequeued cell is not an instance of menuTableViewCell")
        }
        
        let item = menu.columns[indexPath.section].items[indexPath.row]
        
        cell.mealNameLabel.text = item.name
        cell.mealPriceLabel.text = "$ "+String(format:"%.1f",Double(item.price)/100)
        cell.mealPhotoImageView.image = item.photo
        
        return cell
    }
    
    var selectedItem:Item?
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let shoppingCartInstance = shoppingCart.sharedShoppingCart
        
        selectedItem = menu.columns[indexPath.section].items[indexPath.row]
        
        if (self.restaurantId != shoppingCartInstance.restaurantId && shoppingCartInstance.restaurantId != 0){
            let alert = UIAlertController(title: "已有訂單", message: "你已有其他餐廳的訂單！", preferredStyle: UIAlertControllerStyle.actionSheet)
            alert.addAction(UIAlertAction(title: "是", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return nil
        }
        shoppingCartInstance.restaurantId = self.restaurantId
        
        return indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMealOption" {
            if let destinationVC = segue.destination as? MealOptionViewController {
                if let selectedItemForSegue = selectedItem {
                    destinationVC.item = selectedItemForSegue
                    print("Assignment OK")
                } else {
                    print("ERROR")
                }
            }
        }
    }

    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if let savedPageViewController = segue.destination as? savedPageViewController
     {
     var mealItem = meals[indexPath.row]
     savedPageViewController.shoppingCart.append(mealItem)
     }
     }*/
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
