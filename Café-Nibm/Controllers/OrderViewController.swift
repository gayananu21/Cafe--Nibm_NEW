//
//  OrderViewController.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 2/25/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Lottie

class OrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
     
    
    
    @IBOutlet weak var noOrderView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var eView: UIView!
    
         let lottieView = AnimationView()
    

    var refOrders: DatabaseReference!
    var ref: DatabaseReference!
    let user = Auth.auth().currentUser
       
       //list to store all the artist
        var orderList = [OrdersModel]()
       
       
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tap on \(indexPath.row)")
        
        
       
          
    
           
               if(indexPath.row == indexPath.row){
                
       
                
              
                var storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                                  let VC1 = storyBoard.instantiateViewController(withIdentifier: "ORDER_SCREEN") as! OrderScreenViewController
                             //the artist object
                var order: OrdersModel
                                          
                                          //getting the artist of selected position
                                          order = orderList[indexPath.row]
                             
                VC1.orderNoREF = order.orderNumber ?? ""
                                             

                       self.navigationController?.pushViewController(VC1, animated: true)
                
             storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                                                    let VC2 = storyBoard.instantiateViewController(withIdentifier: "RECENT_ORDERS") as! ProfileViewController
                                               //the artist object
                                                            
                                                            
                                                            //getting the artist of selected position
                                                            order = orderList[indexPath.row]
                                               
                VC2.recentOrderNoRef = order.orderNumber ?? ""
                       
        }
        
        
    }
       
       public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
           return orderList.count
       }
       
       
       public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
           //creating a cell using the custom class
           let cell = tableView.dequeueReusableCell(withIdentifier: "ORDER_CELL", for: indexPath) as! OrderTableViewCell
           
           //the artist object
           let order: OrdersModel
           
           //getting the artist of selected position
           order = orderList[indexPath.row]
           
           //adding values to labels
           cell.orderNumber.text = order.orderNumber
           cell.totalAmount.text = order.totalAmount
        
        if(order.orderStatus == "sent to kitchen"){
            
                                
          
            
            cell.kStatus.textColor = .black
            cell.kImage.image = UIImage(named: "orderRight")
            
            cell.pStatus.textColor = .lightGray
            cell.pImage.image = UIImage(named: "2gray")
            
            cell.rStatus.textColor = .lightGray
            cell.rImage.image = UIImage(named: "orderGray")
        }
        if(order.orderStatus == "preparing food"){
            cell.pStatus.textColor = .black
            cell.pImage.image = UIImage(named: "orderBlue")
            
            cell.kStatus.textColor = .black
            cell.kImage.image = UIImage(named: "orderRight")
            
            cell.rStatus.textColor = .lightGray
            cell.rImage.image = UIImage(named: "orderGray")
            
        }
        if(order.orderStatus == "ready"){
            
                   cell.rStatus.textColor = .black
                   cell.rImage.image = UIImage(named: "orderRight")
            
                   cell.pStatus.textColor = .black
                   cell.pImage.image = UIImage(named: "orderRight")
            
                   cell.kStatus.textColor = .black
                   cell.kImage.image = UIImage(named: "orderRight")
                   
               }
        
                   
           //returning cell
           return cell
       }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
              return 250
          }
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.delegate = self
            tableView.dataSource = self
            
            
            
             UIApplication.shared.applicationIconBadgeNumber = 0
            
            
            
            //getting a reference to the node artists
            refOrders = Database.database().reference().child("myOrder/\(self.user?.uid ?? "")");
                     
                     //observing the data changes
                          refOrders.observe(DataEventType.value, with: { (snapshot) in
                              
                              //if the reference have some values
                              if snapshot.childrenCount > 0 {
                                
                                   self.noOrderView.alpha = 0
                                self.lottieView.alpha = 0
                                  //clearing the list
                                  self.orderList.removeAll()
                                  
                                  //iterating through all the values
                                  for orders in snapshot.children.allObjects as! [DataSnapshot] {
                                      //getting values
                                    
                                   
                                    var myKey = String(orders.key)
                                    print("Key is:::::\(myKey)")
                                    
                                    
                                    let orderObject = orders.value as? [String: AnyObject]
                                    let orderNumber  = String(orders.key)
                                    let orderAmount  = orderObject?["amount"]
                                    let orderStatus = orderObject?["status"]
                                    
                                      
                                      //creating artist object with model and fetched values
                                    let order = OrdersModel( orderNumber: orderNumber as! String?, totalAmount: orderAmount as! String?, orderStatus: orderStatus as! String?)
                                      
                                      //appending it to list
                                      self.orderList.append(order)
                                  }
                                  
                                  //reloading the tableview
                                  self.tableView.reloadData()
                              }
                            
                              else{
                                
                                self.lottieView.alpha = 1
                                                           self.lottieView.animation = Animation.named("Food")
                                                           //let lottieView = AnimationView(animation: loadingAnimation)
                                                               // 2. SECOND STEP (Adding and setup):
                                                           self.eView.addSubview(self.lottieView)
                                                           self.lottieView.contentMode = .scaleAspectFit
                                                           self.lottieView.loopMode = .autoReverse
                                                           self.lottieView.play(toFrame: .infinity)
                                                               // 3. THIRD STEP (LAYOUT PREFERENCES):
                                                           self.lottieView.translatesAutoresizingMaskIntoConstraints = false
                                                               NSLayoutConstraint.activate([
                                                                   self.lottieView.leftAnchor.constraint(equalTo: self.eView.leftAnchor),
                                                                   self.lottieView.rightAnchor.constraint(equalTo: self.eView.rightAnchor),
                                                                   self.lottieView.topAnchor.constraint(equalTo: self.eView.topAnchor),
                                                                   self.lottieView.bottomAnchor.constraint(equalTo: self.eView.bottomAnchor)
                                                               ])
                                
                                self.noOrderView.alpha = 1
                                self.tableView.reloadData()
                            }
                            
                          })
            
            
        }
    override func viewWillAppear(_ animated: Bool) {
        if self.lottieView.isAnimationPlaying == false {
                          self.lottieView.play()
                      }
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    

    }

    
