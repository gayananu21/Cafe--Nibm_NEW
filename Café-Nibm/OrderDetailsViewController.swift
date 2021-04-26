//
//  OrderDetailsViewController.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 4/9/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import UIKit
import Firebase
import Lottie
import Kingfisher

class OrderDetailsViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var orderIdLabel: UILabel!
    
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var customerStatus: UILabel!
    var orderId = ""
    var userImage = UIImage()
    var userName = ""
    var userId = ""
    var status = ""
    
    var customerNumber = ""
    
    
    @IBOutlet weak var cartTableView: UITableView!
    
     var refCarts: DatabaseReference!
     var refGetProcessingOrders: DatabaseReference!
    var refGetFoodImage: DatabaseReference!
    var refGetUserPhoneNumber: DatabaseReference!
    
     var cartList = [OrderDetailMenu]()
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
           return cartList.count
       }
       
     
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
    
        return 100
        
    }
 
     
       
       public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
           
         
         
           
         
           //creating a cell using the custom class
           let cell = tableView.dequeueReusableCell(withIdentifier: "ORDER_DETAIL_CELL", for: indexPath) as! OrderDetailTableViewCell
           
           
         
           
           //the artist object
           let cart: OrderDetailMenu
        //getting the artist of selected position
               cart = cartList[indexPath.row]
           
          
           //adding values to labels
       cell.foodImage.kf.indicatorType = .activity
        cell.foodImage.kf.setImage(with: URL(string:String(cart.foodImage ?? "")), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
           cell.noItems.text = cart.noItems
        cell.foodPrice.text = cart.price
        cell.foodName.text = cart.name
        
        cell.foodImage.kf.indicatorType = .activity
                    cell.foodImage.kf.setImage(with: URL(string:String(cart.foodImage ?? "")), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
                    
                   cell.foodImage.heightAnchor.constraint(equalToConstant: 127).isActive = true
           
           
           
           
           //returning cell
           return cell
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
           self.customerStatus.layer.borderWidth = 0.5
           self.customerStatus.layer.masksToBounds = false
           self.customerStatus.layer.borderColor = UIColor.black.cgColor
           self.customerStatus.layer.cornerRadius =    self.customerStatus.frame.height/2
           self.customerStatus.clipsToBounds = true
           self.customerStatus.alpha = 1
        
        
        
          self.orderIdLabel.text = orderId

        // Do any additional setup after loading the view.
        
        cartTableView.delegate = self
                      cartTableView.dataSource = self
        
        
        refGetUserPhoneNumber = Database.database().reference().child("users");
                           
                          
                           
        let query_process_Phone = refGetUserPhoneNumber.queryOrdered(byChild: "userId").queryEqual(toValue: "\(userId)")
                           query_process_Phone.observe(DataEventType.value, with: { (snapshot) in
                                                                 
                                                                 
                            if snapshot.childrenCount > 0 {
                                
                                for newOrders in snapshot.children.allObjects as! [DataSnapshot] {
                                
                                    
                                    let cartObject = newOrders.value as? [String: AnyObject]
                                    let phoneNumber  = cartObject?["phoneNumber"]
                                                                                        
                                    
                                    self.customerNumber = phoneNumber as! String
                                                                   
                        
                                                                  
                                                                 }
                           }
                                                               
        
                           }
                                                               
                                                             )
        
        
        
        
        
                      
                      //getting a reference to the node artists
        refCarts = Database.database().reference().child("myOrder/\(self.userId)/\(self.orderId)");
         refGetFoodImage = Database.database().reference().child("Foods");
                        
                        //observing the data changes
                             refCarts.observe(DataEventType.value, with: { (snapshot) in
                                 
                                 //if the reference have some values
                                 if snapshot.childrenCount > 0 {
                                   
                                  
                                   
                               
                                   
                                  
                                     
                                     //clearing the list
                                     self.cartList.removeAll()
                                    
                                   // self.animationView.alpha = 0
                                     //iterating through all the values
                                     for carts in snapshot.children.allObjects as! [DataSnapshot] {
                                         //getting values
                                         let cartObject = carts.value as? [String: AnyObject]
                                         let cartItemPrice  = cartObject?["foodPrice"]
                                         let cartNoUnits  = cartObject?["noFoods"]
                                         let cartAmount = cartObject?["amount"]
                                         let cartFoodName = cartObject?["foodName"]
                                         let cartImage = cartObject?["foodImage"]
                                       
                                       //self.total += cartAmount as! Int
                                     
                                      
                                        if(cartFoodName != nil){
                                            
                                            //creating artist object with model and fetched values
                                            let cart = OrderDetailMenu(name: cartFoodName as! String?, price: cartAmount as! String?,foodImage: cartImage as! String?, noItems: cartNoUnits as! String? )
                                               
                                            
                                               //appending it to list
                                               self.cartList.append(cart)
                                            
                                             self.cartTableView.reloadData()
                                            
                                        }
                                         
                                      
                                      
                                         
                                       
                                       
                                       
                                     }
                                     
                                     //reloading the tableview
                                     self.cartTableView.reloadData()
                                 }
                               
                                
                               
                              
                               
                             })
        
        
        //getting a reference to the node artists
                   refGetProcessingOrders = Database.database().reference().child("order status");
               
               
               //observing the data changes
        let query_process = refGetProcessingOrders.queryOrdered(byChild: "userId").queryEqual(toValue: "\(self.userId)")
         // query_process = refGetProcessingOrders.queryOrdered(byChild: "status").queryEqual(toValue: "ready")
                                                               query_process.observe(DataEventType.value, with: { (snapshot) in
                                                     
                                                     //if the reference have some values
                                                     if snapshot.childrenCount > 0 {
                                                       
                                                      
                                                       
                                                   
                                                       
                                                      
                                                         
                                                       // self.animationView.alpha = 0
                                                         //iterating through all the values
                                                         for newOrders in snapshot.children.allObjects as! [DataSnapshot] {
                                                             //getting values
                                                            
                                                            
                                                          
                                                            let cartObject = newOrders.value as? [String: AnyObject]
                                                            
                                                           
                                                           let distance = cartObject?["distance"]
                                                             let name = cartObject?["name"]
                                                            
                                                            var cusname = ""
                                                            cusname = name as! String
                                                            
                                                            self.customerName.text = cusname

                                                        var intCusDistance = Double()
                                                          var cusDistance = ""
                                                            cusDistance = distance as! String
                                                            
                                                            intCusDistance = Double(cusDistance)!
                                                            if(intCusDistance<20 && self.status == "ready"){
                                                                
                                                                
                                                                
                                                                self.customerStatus.text = "Arriving"
                                                                self.customerStatus.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
                                                                self.customerStatus.textColor = .white
                                                                
                                                            }
                                                    
                                                           
                                                         }
                                                         
                                                        
                                                     }
                                                   
                                                   
                                                  
                                                   
                                                 })
        
        
        
        
        
        if (self.status == "pending"){
            
            self.customerStatus.text = "Pending"
            self.customerStatus.backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
            self.customerStatus.textColor = .black
                              
            
        }

        
        
        
        if (self.status == "processing"){
            
            self.customerStatus.text = "Processing"
            self.customerStatus.backgroundColor = #colorLiteral(red: 0.5808190107, green: 0.0884276256, blue: 0.3186392188, alpha: 1)
            self.customerStatus.textColor = .white
                              
                   
                   
               }
        
        
        
        
        if (self.status == "ready"){
                   
            self.customerStatus.text = "Ready"
            self.customerStatus.backgroundColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
            self.customerStatus.textColor = .white
                   
               }

        
        
        //observing the data changes
        let query_get_image = refGetFoodImage.queryOrdered(byChild: "name").queryEqual(toValue: "\(self.userId)")
         // query_process = refGetProcessingOrders.queryOrdered(byChild: "status").queryEqual(toValue: "ready")
                                                               query_get_image.observe(DataEventType.value, with: { (snapshot) in
                                                     
                                                     //if the reference have some values
                                                     if snapshot.childrenCount > 0 {
                                                       
                                                      
                                                       
                                                   
                                                       
                                                      
                                                         
                                                       // self.animationView.alpha = 0
                                                         //iterating through all the values
                                                         for newOrders in snapshot.children.allObjects as! [DataSnapshot] {
                                                             //getting values
                                                            
                                                            
                                                          
                                                            let cartObject = newOrders.value as? [String: AnyObject]
                                                            
                                                           
                                                           let distance = cartObject?["distance"]
                                                             let name = cartObject?["name"]
                                                            
                                                            var cusname = ""
                                                            cusname = name as! String
                                                            
                                                            self.customerName.text = cusname

                                                        var intCusDistance = Double()
                                                          var cusDistance = ""
                                                            cusDistance = distance as! String
                                                            
                                                            intCusDistance = Double(cusDistance)!
                                                            if(intCusDistance<20 && self.status == "ready"){
                                                                
                                                                
                                                                
                                                                self.customerStatus.text = "Arriving"
                                                                self.customerStatus.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
                                                                self.customerStatus.textColor = .white
                                                                
                                                            }
                                                    
                                                           
                                                         }
                                                         
                                                        
                                                     }
                                                   
                                                   
                                                  
                                                   
                                                 })


    }
    

    @IBAction func onCallButton(_ sender: Any) {
        
        let numberString = self.customerNumber
        let url = URL(string: "telprompt://\(numberString)")
        
        UIApplication.shared.open(url!)
        
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
