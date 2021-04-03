//
//  Order_History_Detail_ViewController.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 3/20/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class Order_History_Detail_ViewController1:UIViewController, UITableViewDelegate , UITableViewDataSource  {
   
    @IBOutlet weak var nameLabel: UILabel!
    
   
    
    var recentOrderNoRef = ""
    
      var orderNumber = ""
    
    var order_histrory_No=""
  

  
    
    @IBOutlet weak var doneEditButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var topTableView: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    var topData : [String] = []
    var downData = [String]()
    
    
     var refProfileRecent: DatabaseReference!
    var refProfileRecent1: DatabaseReference!
    let user = Auth.auth().currentUser
    
    //list to store all the artist
     var recentOrderList = [ProfileRecentModel]()
    //list to store all the artist
      var recentOrderList1 = [ProfileRecentModel1]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

            
        //Looks for single or multiple taps.
                          let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

                                //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
                                //tap.cancelsTouchesInView = false

                          view.addGestureRecognizer(tap)
        
        
       
        
        
        topTableView.delegate = self
        
        topTableView.dataSource = self
        
       //getting a reference to the node artists
       refProfileRecent = Database.database().reference().child("myOrder/\(self.user?.uid ?? "")");
      
         
         //observing the data changes
              refProfileRecent.observe(DataEventType.value, with: { (snapshot) in
                  
                  //if the reference have some values
                  if snapshot.childrenCount > 0 {
                    
                   
                      
                      //iterating through all the values
                      for recentOrders in snapshot.children.allObjects as! [DataSnapshot] {
                          //getting values
                          let recentOrderObject = recentOrders.value as? [String: AnyObject]
                          let totalAmount  = recentOrderObject?["total"]
                          let date = recentOrderObject?["date"]
                        let recentOrderNo =  String(recentOrders.key)
                     
                                                     
                                                        
                        print("key::::::\(recentOrderNo)");
                        
                        self.refProfileRecent1 = Database.database().reference().child("myOrder/\(self.user?.uid ?? "")/\(self.order_histrory_No)");
                                                       
                                                        
                       
                          //creating artist object with model and fetched values
                        let recentOrder = ProfileRecentModel(date: date as! String?, totalAmount: totalAmount as! String?, recentOrderNo: recentOrderNo as! String?)
                          
                          //appending it to list
                          self.recentOrderList.append(recentOrder)
                       
                       
                       //observing the data changes
                       self.refProfileRecent1.observe(DataEventType.value, with: { (snapshot1) in
                           
                           //if the reference have some values
                           if snapshot1.childrenCount > 0 {
                               
                                self.recentOrderList1.removeAll()
                               
                               //iterating through all the values
                               for recentOrders1 in snapshot1.children.allObjects as! [DataSnapshot] {
                               
                                   let recentOrderObject1 = recentOrders1.value as? [String: AnyObject]
                               let foodName  = recentOrderObject1?["foodName"]
                                let noItems = recentOrderObject1?["noFoods"]
                                
                               
                                let itemPrice  = recentOrderObject1?["foodPrice"]
                                
                                   
                                   
                                   let recentOrder1 = ProfileRecentModel1(foodName: foodName as! String?, noItems: noItems as! String?, itemPrice: itemPrice as! String?)
                                                          
                                                          //appending it to list
                                                          self.recentOrderList1.append(recentOrder1)
                                   
                                   
                               }
                               //reloading the tableview
                               self.topTableView.reloadData()
                           }
                           
                       })
               
                      
                      }
                      
                      //reloading the tableview
                      self.topTableView.reloadData()
                  }
              })
        
        
        
        
       
        
        for index in 0...20 {
            topData.append("Top Table Row \(index)")
        }
        
        for index in 10...45 {
            downData.append("Down Table Row \(index)")
        }

        
      
    }
    
    @IBAction func editProfile(_ sender: Any) {
        
          self.nameTextField.text = self.nameLabel.text
          self.phoneTextField.text = self.phoneLabel.text
        
        
        self.nameLabel.alpha = 0
        self.phoneLabel.alpha = 0
        
        self.nameTextField.alpha = 1
        self.phoneTextField.alpha = 1
        
        self.editButton.alpha = 0
        self.doneEditButton.alpha = 1
    }
    
    @IBAction func doneEditProfile(_ sender: Any) {
        
    
        
        self.nameLabel.text = self.nameTextField.text
        self.phoneLabel.text = self.phoneTextField.text
        
        
        self.nameLabel.alpha = 1
        self.phoneLabel.alpha = 1
        
        self.nameTextField.alpha = 0
        self.phoneTextField.alpha = 0
        
        self.doneEditButton.alpha = 0
        self.editButton.alpha = 1
        
    }
    
    @objc func dismissKeyboard() {
                  //Causes the view (or one of its embedded text fields) to resign the first responder status.
                  view.endEditing(true)
              }
    
    override func viewWillAppear(_ animated: Bool) {
              super.viewWillAppear(animated)
              navigationController?.setNavigationBarHidden(false, animated: animated)
              
              
          }

          override func viewWillDisappear(_ animated: Bool) {
              super.viewWillDisappear(animated)
              navigationController?.setNavigationBarHidden(true, animated: animated)
          }
        
      public func numberOfSections(in tableView: UITableView) -> Int {
            
            
        
                return 1

        }
        
       public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("you tap on \(indexPath.row)")
            
            
            
            
        }
        
        

        
        
       public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            var numberOfRow = 1
             
                   
                           if(tableView.tag == 10){
                               
                              numberOfRow = recentOrderList.count
                            return numberOfRow
                            
                           }
                           
                           
                           if(tableView.tag == 20){
                                         
                                          numberOfRow = recentOrderList1.count
                                                                  return numberOfRow
                                     }
                           
                           return numberOfRow
        }
        
     public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         
        var heightCell = 1
        
        if(tableView.tag == 10){
            heightCell = 100
            return CGFloat(heightCell)
        }
        
        if(tableView.tag == 20){
            heightCell = 145
            return CGFloat(heightCell)
        }
        return CGFloat(heightCell)

     }
        
       public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var cell = UITableViewCell()
         
            
           
        
            if (tableView.tag == 20){
                
                //creating a cell using the custom class
                 let cell = tableView.dequeueReusableCell(withIdentifier: "ORDER_HISTORY_CELL", for: indexPath) as! Profile_1_TableViewCell
                 
                 //the artist object
                 let order: ProfileRecentModel1
                 
                 //getting the artist of selected position
                 order = recentOrderList1[indexPath.row]
                 
                 //adding values to labels
                 cell.foodName.text = order.foodName
                cell.noItems.text = order.noItems
                 cell.itemPrice.text = order.itemPrice
                 
                 //returning cell
                 return cell

            }
            
            return cell

        

    }

}
