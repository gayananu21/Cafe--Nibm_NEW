//
//  AdminOrdersViewController.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 4/8/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Lottie

class AdminOrdersViewController:  UIViewController , UITableViewDelegate , UITableViewDataSource  {
  
    @IBOutlet weak var noReadyOrders: UILabel!
    @IBOutlet weak var noProcessOrders: UILabel!
    
    @IBOutlet weak var noOrders: UILabel!
    
    @IBOutlet weak var processingOrdersTableView: UITableView!
    @IBOutlet weak var readyOrdersTableView: UITableView!
    @IBOutlet weak var newOrdersTableView: UITableView!
    
    
   
    
    
    
    var cartList = [NewOrderModel]()
    var processingList = [ProcessingOrderModel]()
    var readyList = [ReadyOrderModel]()
    
    
    
    var refGetNewOrders: DatabaseReference!
    var refGetProcessingOrders: DatabaseReference!
    var refGetReadyOrders: DatabaseReference!
     var refGetOrderInfo: DatabaseReference!
    let user = Auth.auth().currentUser
    
    
    var fID = ""


    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           print("you tap on \(indexPath.row)")
           
           switch tableView {
          
    
           case readyOrdersTableView:
              
                  if(indexPath.row == indexPath.row){
                 
                   let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                   let VC1 = storyBoard.instantiateViewController(withIdentifier: "ORDER_DETAIL") as! OrderDetailsViewController
                                // the artist object
                                             //the artist obj
                    
                    
                             //the artist object
                             let cart: ReadyOrderModel
                             
                             //getting the artist of selected position
                             cart = readyList[indexPath.row]
                             
                             //adding values to labels
                             
                             //.orderId.text = cart.orderId
                    
                    
                    VC1.orderId = cart.orderId ?? ""
                    VC1.userId = cart.userId ?? ""

                    self.navigationController?.pushViewController(VC1, animated: true)
                   
                  
                          
                         
                      }
               default:
               print("Some things Wrong!!")
               
           }
           
           
       }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
        switch tableView{
        case newOrdersTableView:
            return 100
        case processingOrdersTableView:
            return 180
            
        case readyOrdersTableView:
            return 200
            
            default:
            print("default height")
        }
        return 100
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        switch tableView {
               case newOrdersTableView:
          return cartList.count
            
        case processingOrdersTableView:
            return processingList.count
            
        case readyOrdersTableView:
            return readyList.count
            
             default:
            print("Some things Wrong!!")
        }
         return cartList.count
      }
      
    
   
      public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
          return true
      }
      
 
      
      public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
          
          if(indexPath.row == indexPath.row){
              
              
              
          }
         var cell = UITableViewCell()
         switch tableView {
         case newOrdersTableView:
          
        
          //creating a cell using the custom class
          let cell = tableView.dequeueReusableCell(withIdentifier: "NEW_ORDERS", for: indexPath) as! NewOrderTableViewCell
          
          cell.delegate = self
          cell.Index = indexPath
        
          
          //the artist object
          let cart: NewOrderModel
          
          //getting the artist of selected position
          cart = cartList[indexPath.row]
          
          //adding values to labels
          
          cell.orderId.text = cart.orderId
          
          
          
          
          //returning cell
          return cell
            
         case processingOrdersTableView:
            
            //creating a cell using the custom class
                    let cell = tableView.dequeueReusableCell(withIdentifier: "PROCESSING_ORDERS", for: indexPath) as! ProcessingOrderTableViewCell
                    
                    cell.delegate = self
                    cell.Index = indexPath
                  
                    
                    //the artist object
                    let cart: ProcessingOrderModel
                    
                    //getting the artist of selected position
                    cart = processingList[indexPath.row]
                    
                    //adding values to labels
                    
                    cell.orderId.text = cart.orderId
            
            
         case readyOrdersTableView:
            
            //creating a cell using the custom class
                           let cell = tableView.dequeueReusableCell(withIdentifier: "READY_ORDERS", for: indexPath) as! ReadyOrderTableViewCell
                           
                           cell.delegateReady = self
                           cell.Index = indexPath
                         
                           
                           //the artist object
                           let cart: ReadyOrderModel
                           
                           //getting the artist of selected position
                           cart = readyList[indexPath.row]
                           
                           //adding values to labels
                           
                           cell.orderId.text = cart.orderId
            
         default:
            print("Some things Wrong!!")
            
        }
    return cell
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        newOrdersTableView.delegate = self
                      newOrdersTableView.dataSource = self
        
        processingOrdersTableView.delegate = self
                             processingOrdersTableView.dataSource = self
        
        readyOrdersTableView.delegate = self
                             readyOrdersTableView.dataSource = self
                      
                      //getting a reference to the node artists
                      refGetOrderInfo = Database.database().reference().child("order status");
        
            //getting a reference to the node artists
            refGetProcessingOrders = Database.database().reference().child("order status");
        
        //getting a reference to the node artists
                   refGetReadyOrders = Database.database().reference().child("order status");
                        
                        //observing the data changes
                             let query = refGetOrderInfo.queryOrdered(byChild: "status").queryEqual(toValue: "pending")
                                           query.observe(DataEventType.value, with: { (snapshot) in
                                 
                                 //if the reference have some values
                                 if snapshot.childrenCount > 0 {
                                   
                                  
                                   
                               
                                   
                                  
                                     //clearing the list
                                     self.cartList.removeAll()
                                    
                                   // self.animationView.alpha = 0
                                     //iterating through all the values
                                     for newOrders in snapshot.children.allObjects as! [DataSnapshot] {
                                         //getting values
                                        
                                        self.noOrders.text = String(snapshot.childrenCount)
                                      
                                        let cartObject = newOrders.value as? [String: AnyObject]
                                        let userId  = cartObject?["userId"]
                                        let orderId  = cartObject?["orderId"]
                                        let dataKey = cartObject?["key"]

                                        
                                       //creating artist object with model and fetched values
                                        let food = NewOrderModel(userId: userId as! String?, orderId: orderId as! String?, dataKey: dataKey as! String?)
                                                                      
                                        
                                                                      //appending it to list
                                                self.cartList.append(food)
                                
                                       
                                     }
                                     
                                     //reloading the tableview
                                     self.newOrdersTableView.reloadData()
                                 }
                               
                               
                              
                               
                             })
        
        
        //observing the data changes
        let query_process = refGetOrderInfo.queryOrdered(byChild: "status").queryEqual(toValue: "preparing")
                                                 query_process.observe(DataEventType.value, with: { (snapshot) in
                                       
                                       //if the reference have some values
                                       if snapshot.childrenCount > 0 {
                                         
                                        
                                         
                                     
                                         
                                        
                                           //clearing the list
                                           self.processingList.removeAll()
                                          
                                         // self.animationView.alpha = 0
                                           //iterating through all the values
                                           for newOrders in snapshot.children.allObjects as! [DataSnapshot] {
                                               //getting values
                                              
                                              self.noProcessOrders.text = String(snapshot.childrenCount)
                                            
                                              let cartObject = newOrders.value as? [String: AnyObject]
                                              let userId  = cartObject?["userId"]
                                              let orderId  = cartObject?["orderId"]
                                              let dataKey = cartObject?["key"]

                                              
                                             //creating artist object with model and fetched values
                                              let food = ProcessingOrderModel(userId: userId as! String?, orderId: orderId as! String?,dataKey: dataKey as! String?)
                                                                            
                                              
                                                                            //appending it to list
                                                      self.processingList.append(food)
                                      
                                             
                                           }
                                           
                                           //reloading the tableview
                                           self.processingOrdersTableView.reloadData()
                                       }
                                     
                                     
                                    
                                     
                                   })
        
        
        
        
        //observing the data changes
        let query_ready = refGetReadyOrders.queryOrdered(byChild: "status").queryEqual(toValue: "ready")
                                                 query_ready.observe(DataEventType.value, with: { (snapshot) in
                                       
                                       //if the reference have some values
                                       if snapshot.childrenCount > 0 {
                                         
                                        
                                         
                                     
                                         
                                        
                                           //clearing the list
                                           self.readyList.removeAll()
                                          
                                         // self.animationView.alpha = 0
                                           //iterating through all the values
                                           for newOrders in snapshot.children.allObjects as! [DataSnapshot] {
                                               //getting values
                                              
                                              self.noReadyOrders.text = String(snapshot.childrenCount)
                                            
                                              let cartObject = newOrders.value as? [String: AnyObject]
                                              let userId  = cartObject?["userId"]
                                              let orderId  = cartObject?["orderId"]
                                              let dataKey = cartObject?["key"]

                                              
                                             //creating artist object with model and fetched values
                                              let food = ReadyOrderModel(userId: userId as! String?, orderId: orderId as! String?,dataKey: dataKey as! String?)
                                                                            
                                              
                                                                            //appending it to list
                                                      self.readyList.append(food)
                                      
                                             
                                           }
                                           
                                           //reloading the tableview
                                           self.readyOrdersTableView.reloadData()
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

extension AdminOrdersViewController: newOrderDelegate {
    func onAcceptOrder(Index: Int) {
        
       //the artist object
                   let cart: NewOrderModel
                   
                   //getting the artist of selected position
                   cart = cartList[Index]
        let userId = cart.userId
        let orderId = cart.orderId
        let key = cart.dataKey
        
        
        
        
        let refUp = Database.database().reference()
        
        
        let updateStatus = refUp.child("order status/\(key ?? "")")
        updateStatus.updateChildValues(["status": "preparing"])
        //reloading the tableview
        
        
        cartList.remove(at: Index)
        self.newOrdersTableView.reloadData()
        
        self.noOrders.text = String( cartList.count )

      
        
               let alert = UIAlertController(title: "SUCCESS", message: "Order accepted successfully.", preferredStyle: UIAlertController.Style.alert)
               alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
               self.present(alert, animated: true, completion: nil)
        
        
        
    }
    
    func onRejectOrder(Index: Int) {
        
        let alert = UIAlertController(title: "Reject Order", message: "Do you want to reject order?", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "cancel", style: .default, handler: { action in
                                                                   
                                                                     
                                                                    }))
                   alert.addAction(UIAlertAction(title: "Reject ", style: .destructive, handler: { action in

                                              
                    let alert = UIAlertController(title: "Inform Customer", message: "Please inform customer why you reject the order.", preferredStyle: .alert)
                               alert.addAction(UIAlertAction(title: "cancel", style: .destructive, handler: { action in
                                                                               
                                                                                 
                                                                                }))
                               alert.addAction(UIAlertAction(title: "Send message ", style: .default, handler: { action in

                                                          

                                                            }))
                    
                    
                    
                            self.present(alert, animated: true, completion: nil)

                                                }))
        
        
        
                self.present(alert, animated: true, completion: nil)
                                                
        
    }
}

extension AdminOrdersViewController: processingOrderDelegate {
    func onStatusTapped(title: String, Index: Int) {
        
        
        //the artist object
                          let cart: ProcessingOrderModel
                          
                          //getting the artist of selected position
                          cart = processingList[Index]

                     let key = cart.dataKey
        
        
        
        if(title == "Preparing"){
            
            let refUp = Database.database().reference()
            
            
            let updateStatus = refUp.child("order status/\(key ?? "")")
            updateStatus.updateChildValues(["status": "preparing"])
            //reloading the tableview
            
            
           
            
        }
        
        
        if(title == "Ready"){
            
            let alert = UIAlertController(title: "Ready", message: "Please confirm food is ready?", preferredStyle: .alert)
                       alert.addAction(UIAlertAction(title: "cancel", style: .destructive, handler: { action in
                                                                       
                                                                         
                                                                        }))
                       alert.addAction(UIAlertAction(title: "Confirm ", style: .default, handler: { action in

                                                  
                        
                                                let refUp = Database.database().reference()
                                                
                                                
                                                let updateStatus = refUp.child("order status/\(key ?? "")")
                                                updateStatus.updateChildValues(["status": "ready"])
                                                //reloading the tableview
                                                
                                                
                        self.processingList.remove(at: Index)
                        self.processingOrdersTableView.reloadData()
                                                
                        self.noProcessOrders.text = String( self.processingList.count )
                                                

                                                    }))
            
            
            
                    self.present(alert, animated: true, completion: nil)
                        
                      }
        
        
        
    }
    
    func onhandleSelection() {
        
         self.view.layoutIfNeeded()
        
    }
}


extension AdminOrdersViewController: ReadyOrderDelegate {
    func onStatusTapped_Ready(title: String, Index: Int) {
        
        
        
             //the artist object
                               let cart: ReadyOrderModel
                               
                               //getting the artist of selected position
                               cart = readyList[Index]

                          let key = cart.dataKey
             
        
             
             
             if(title == "Finish"){
                 
                 let alert = UIAlertController(title: "Complete Order", message: "Please confirm if order is delivered?", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "cancel", style: .destructive, handler: { action in
                                                                            
                                                                              
                                                                             }))
                            alert.addAction(UIAlertAction(title: "Confirm ", style: .default, handler: { action in

                                                       
                             
                                                     let refUp = Database.database().reference()
                                                     
                                                     
                                                     let updateStatus = refUp.child("order status/\(key ?? "")")
                                                     updateStatus.updateChildValues(["status": "finish"])
                                                     //reloading the tableview
                                                     
                                                     
                             self.readyList.remove(at: Index)
                             self.readyOrdersTableView.reloadData()
                                                     
                             self.noReadyOrders.text = String( self.readyList.count )
                                                     

                                                         }))
                 
                 
                 
                         self.present(alert, animated: true, completion: nil)
                             
                           }
        
    }
    
    func onhandleSelection_Ready() {
        
          self.view.layoutIfNeeded()
    }
}
