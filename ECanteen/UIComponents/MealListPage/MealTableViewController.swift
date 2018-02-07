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
    var meals = [Meal]()
    var canteen_id:Int = 0
    var canteen_name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(canteen_id)
        loadSampleMeals()   //load the sample meals to tableView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    //MARK: Private Methods
    
    private func loadSampleMeals() {
        
        //let photo1 = UIImage(named: "coffeecon_meal1")
        //let photo2 = UIImage(named: "coffeecon_meal2")
        //let photo3 = UIImage(named: "coffeecon_meal3")
        //let photo4 = UIImage(named: "coffeecon_meal4")
        
        Alamofire.request("http://projgw.cse.cuhk.edu.hk:2887/api/restaurants/"+String(canteen_id)+"/menus/1",method:.get).responseJSON{ response in
            
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
                    do{
                        let json: JSON = try JSON(data: response.data!)
                        
                        if let result = json["columns"].array {
                            for data in result {
                                if let items = data["items"].array{
                                    for item in items{
                                        if item["name"] != JSON.null{
                                            let price = item["price"].doubleValue
                                            guard let mealX = Meal(name:"\(item["name"])",photo: UIImage(named: "coffeecon_meal"+String(self.meals.count % 4 + 1)),price: price,itemId:item["itemid"].intValue) else{
                                                fatalError("Unable to instantiate meal")
                                            }
                                            self.meals += [mealX]
                                        }
                                    }
                                }
                            }
                        }
                        self.tableView.reloadData()
                        print(self.meals)
                    }catch{
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
        
        let meal = meals[indexPath.row]
        
        cell.mealNameLabel.text = meal.name
        cell.mealPriceLabel.text = "$ "+String(format:"%.1f",meal.price)
        cell.mealPhotoImageView.image = meal.photo
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let shoppingCartInstance = shoppingCart.sharedShoppingCart
        if (self.canteen_id != shoppingCartInstance.canteenId && shoppingCartInstance.canteenName.isEmpty==false){
            print(self.canteen_name+" "+shoppingCartInstance.canteenName)
            let alert = UIAlertController(title: "已有訂單", message: "你已有其他餐廳的訂單！", preferredStyle: UIAlertControllerStyle.actionSheet)
            alert.addAction(UIAlertAction(title: "是", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        let alert = UIAlertController(title: "加到購物籃", message: "你確定要加 "+meals[indexPath.row].name+" 到購物籃嗎？", preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(UIAlertAction(title: "是", style: UIAlertActionStyle.default, handler: {_ in
            let mealItem = self.meals[indexPath.row]
            shoppingCartInstance.shoppingCartArray.append(mealItem)
            shoppingCartInstance.canteenName = self.canteen_name
            shoppingCartInstance.canteenId = self.canteen_id
            print(shoppingCartInstance.canteenName)
            print("Shopping cart called.")
            //print(shoppingCartInstance.shoppingCartArray)
            let successAlert = UIAlertController(title: "已加到購物籃", message: self.meals[indexPath.row].name+"已成功加到購物籃，謝謝！\n 你有"+String(shoppingCartInstance.shoppingCartArray.count)+"項食品未結賬，請到「你的訂單」結賬", preferredStyle: UIAlertControllerStyle.alert)
            successAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:nil))
            self.present(successAlert, animated: true, completion:nil)
        }
        ))
        alert.addAction(UIAlertAction(title: "否", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
