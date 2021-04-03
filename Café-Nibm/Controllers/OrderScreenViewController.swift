//
//  OrderScreenViewController.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 3/4/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class OrderScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var orderNoREF = ""
    
    var refOrderScreen: DatabaseReference!
    let user = Auth.auth().currentUser
      

       //list to store all the artist
        var orderScreenList = [OrderScreenModel]()
       
    
    @IBOutlet weak var orderScreenTableView: UITableView!
    @IBOutlet weak var orderNo: UILabel!
    
    @IBOutlet weak var totalAmount: UILabel!
    
    var allTotal = Int()
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
           
        return 200
        
    }
    
    

      public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
          return orderScreenList.count
      }
      
    
   
      
      public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        
          //creating a cell using the custom class
          let cell = tableView.dequeueReusableCell(withIdentifier: "ORDER_SCREEN_CELL", for: indexPath) as! OrderScreenTableViewCell
          
        
          
          //the artist object
          let order: OrderScreenModel
          
          //getting the artist of selected position
          order = orderScreenList[indexPath.row]
         
       
          
          //adding values to labels
        cell.unitPrice.text = order.itemPrice
        cell.noUnits.text = order.noUnits
          cell.amount.text = order.amount
        cell.foodName.text = order.foodName
          
        
        self.allTotal += Int(order.amount ?? "") ?? 0
       self.totalAmount.text = String( self.allTotal )
          
          
          
          //returning cell
          return cell
      }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        orderNo.text = orderNoREF
        
        
        
               orderScreenTableView.delegate = self
                      orderScreenTableView.dataSource = self
                      
                      //getting a reference to the node artists
                      refOrderScreen = Database.database().reference().child("myOrder/\(self.user?.uid ?? "")/\(orderNoREF)");
                        
     
                        //observing the data changes
        //let query = refOrderScreen.queryOrdered(byChild: "foodName").queryEqual(toValue: [nil!] )
                             //query.observe(DataEventType.value, with: { (snapshot) in
                                 
        refOrderScreen.observe(DataEventType.value, with: { (snapshot) in
        
                                 //if the reference have some values
                                 if snapshot.childrenCount > 0 {
                                   
                          
                                     //clearing the list
                                     self.orderScreenList.removeAll()
                                      
                                     //iterating through all the values
                                     for carts in snapshot.children.allObjects as! [DataSnapshot] {
                                         //getting values
                                         let orderObject = carts.value as? [String: AnyObject]
                                         let unitPrice  = orderObject?["foodPrice"]
                                         let noUnits  = orderObject?["noFoods"]
                                         let amount = orderObject?["amount"]
                                         let foodName = orderObject?["foodName"]
                                         
                                         
                                      
                                      
                                         //creating artist object with model and fetched values
                                        let myOrder  = OrderScreenModel (foodName: foodName as! String?, itemPrice: unitPrice as! String?, noUnits: noUnits as! String?, amount: amount as! String? )
                                        
                                      

                                         //appending it to list
                                         self.orderScreenList.append(myOrder)
                                       
                                       
                                     }
                                     
                                     //reloading the tableview
                                     self.orderScreenTableView.reloadData()
                                 }
            
            
                                 
                                 
                               
                              
                               
                             })
        

      
    }
    
    override func viewWillAppear(_ animated: Bool) {
              super.viewWillAppear(animated)
              navigationController?.setNavigationBarHidden(false, animated: animated)
              
              
          }

          override func viewWillDisappear(_ animated: Bool) {
              super.viewWillDisappear(animated)
              navigationController?.setNavigationBarHidden(true, animated: animated)
          }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
