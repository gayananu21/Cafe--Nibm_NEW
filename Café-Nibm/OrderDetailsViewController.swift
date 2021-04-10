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

class OrderDetailsViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var orderIdLabel: UILabel!
    
    var orderId = ""
    var userImage = UIImage()
    var userName = ""
    var userId = ""
    
    
    @IBOutlet weak var cartTableView: UITableView!
    
     var refCarts: DatabaseReference!
    
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
           
           
           
           
           //returning cell
           return cell
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
          self.orderIdLabel.text = orderId

        // Do any additional setup after loading the view.
        
        cartTableView.delegate = self
                      cartTableView.dataSource = self
                      
                      //getting a reference to the node artists
        refCarts = Database.database().reference().child("myOrder/\(self.userId)/\(self.orderId)");
                        
                        //observing the data changes
                             refCarts.observe(DataEventType.value, with: { (snapshot) in
                                 
                                 //if the reference have some values
                                 if snapshot.childrenCount > 0 {
                                   
                                  
                                   
                               
                                   
                                   self.tabBarController?.tabBar.items![1].image =  UIImage(systemName: "cart.fill")
                                   // items![0] index of your tab bar item.items![0] means tabbar first item

                                    self.tabBarController?.tabBar.items![1].selectedImage = UIImage(systemName: "cart.fill")
                                     
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
                                         let cartImage = cartObject?["url"]
                                       
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
