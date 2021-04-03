//
//  RestaurantViewController.swift
//  NIBMCafateria
//
//  Created by thusitha on 2/7/21.
//  Copyright © 2021 nibm. All rights reserved.
//

import UIKit


class RestaurantViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var food_bars = [
         FoodBar(dictionary: ["bar1":"ALL", "bar2": "RICE_CURRY", "bar3":"STREET_FOODS", "bar4": "BEVERAGES", "bar5": "BAKERY", "bar6":"APPETIZERS"])
         
         ] {
         didSet {
             tableView.reloadData()
         }
     }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           navigationController?.setNavigationBarHidden(true, animated: animated)
           
           
       }

       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           navigationController?.setNavigationBarHidden(false, animated: animated)
       }
    
    
    

}

extension RestaurantViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tap on \(indexPath.row)")
        
   
    }
}

extension RestaurantViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
       
             return 3
        
    }
    
    
  
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let foodBarCell = tableView.dequeueReusableCell(withIdentifier: "FOOD_BAR", for: indexPath) as! FoodItemScrollTableViewCell
        foodBarCell.bar1.setTitle(String (food_bars[indexPath.row].bar1), for: .normal)
        
       
        return foodBarCell
        
        
        
        
    }
}
