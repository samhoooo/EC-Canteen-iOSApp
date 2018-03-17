//
//  MealOptionViewController.swift
//  ECanteen
//
//  Created by John on 27/2/2018.
//  Copyright © 2018年 jaar.ga. All rights reserved.
//

import UIKit
import SwiftyJSON

class MealOptionAttributeCell: UITableViewCell {
    @IBOutlet weak var Title: UILabel!
}

class MealOptionQuantityCell: UITableViewCell {
    weak var parentViewController: MealOptionViewController!
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var QuantityLabel: UILabel!
    
    func loadView() {
        displayQuantity()
    }
    
    func displayQuantity() {
        self.QuantityLabel.text = String(self.parentViewController.item.quantity)
    }
    
    @IBAction func ChangeQuantity(_ sender: Any) {
        self.parentViewController.item.quantity = Int(self.stepper.value)
        displayQuantity()
    }
}

class MealOptionViewController: UITableViewController {
    var item = Item()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.item.attributes.count + 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section < self.item.attributes.count) {
            return self.item.attributes[section].options.count
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section < self.item.attributes.count) {
            return "\(self.item.attributes[section].name) (最多可選：\(self.item.attributes[section].multi_select))"
        } else {
            return "Others"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section < self.item.attributes.count) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AttributeCell", for: indexPath) as! MealOptionAttributeCell
            cell.Title.text = self.item.attributes[indexPath.section].options[indexPath.row].name
            cell.accessoryType = self.item.attributes[indexPath.section].options[indexPath.row].selected ? .checkmark : .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuantityCell", for: indexPath) as! MealOptionQuantityCell
            cell.parentViewController = self
            cell.loadView()
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if (indexPath.section < self.item.attributes.count) {
            var count = 0
            for option in self.item.attributes[indexPath.section].options {
                if option.selected {
                    count += 1
                }
            }
            if count < self.item.attributes[indexPath.section].multi_select {
                self.item.attributes[indexPath.section].options[indexPath.row].selected = true
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            } else {
                if (self.item.attributes[indexPath.section].multi_select == 1) {
                    for option in self.item.attributes[indexPath.section].options {
                        option.selected = false
                    }
                    self.item.attributes[indexPath.section].options[indexPath.row].selected = true
                    tableView.reloadData()
                }
                
            }
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.item.attributes[indexPath.section].options[indexPath.row].selected = false
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(self.item)
        
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action: #selector(saveOption(sender:))
        )

        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    func saveOption(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "加到購物籃", message: "你確定要加 \(self.item.name) 到購物籃嗎？", preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(UIAlertAction(title: "是", style: UIAlertActionStyle.default, handler: {_ in
            shoppingCart.sharedShoppingCart.shoppingCartArray.append(self.item)

            print("Shopping cart called.")
            //print(shoppingCartInstance.shoppingCartArray)
            let successAlert = UIAlertController(title: "已加到購物籃", message: "\(self.item.name)已成功加到購物籃，謝謝！\n 你有\(String(shoppingCart.sharedShoppingCart.shoppingCartArray.count))項食品未結賬，請到「你的訂單」結賬", preferredStyle: UIAlertControllerStyle.alert)
            successAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:nil))
            self.present(successAlert, animated: true, completion:nil)
        }
        ))
        alert.addAction(UIAlertAction(title: "否", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
