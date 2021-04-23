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
import CoreLocation
import AVFoundation
import CoreData
import Kingfisher


class AdminOrdersViewController:  UIViewController , UITableViewDelegate , UITableViewDataSource, AVAudioPlayerDelegate  {
  
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    @IBOutlet weak var eViewReady: UIView!
    @IBOutlet weak var emptyReadyOrders: UIView!
    @IBOutlet weak var noReadyOrders: UILabel!
    @IBOutlet weak var noProcessOrders: UILabel!
    
    @IBOutlet weak var noOrders: UILabel!
    
    @IBOutlet weak var processingOrdersTableView: UITableView!
    @IBOutlet weak var readyOrdersTableView: UITableView!
    @IBOutlet weak var newOrdersTableView: UITableView!
    
    
    var customerDistance = Int()
  
     let lottieView = AnimationView()
    
    
     var audioPlayer = AVAudioPlayer()
    
    var customerName = ""

    
    var cartList = [NewOrderModel]()
    var processingList = [ProcessingOrderModel]()
    var readyList = [ReadyOrderModel]()
    
    
    
    var refGetNewOrders: DatabaseReference!
    var refGetProcessingOrders: DatabaseReference!
    var refGetReadyOrders: DatabaseReference!
     var refGetOrderInfo: DatabaseReference!
      var refGetName: DatabaseReference!
     var refGetUserImage: DatabaseReference!
    
    var ref : DatabaseReference!
    let user = Auth.auth().currentUser
    
    
    
    var fID = ""
    
    var coreOrderId = ""
    var coreCustomerName = ""
    var coreDistance = ""


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
                    VC1.status = "ready"
                    

                    self.navigationController?.pushViewController(VC1, animated: true)
                   
                  
                          
                         
                      }
            
            case processingOrdersTableView:
            
            if(indexPath.row == indexPath.row){
                            
                              let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                              let VC1 = storyBoard.instantiateViewController(withIdentifier: "ORDER_DETAIL") as! OrderDetailsViewController
                                           // the artist object
                                                        //the artist obj
                               
                               
                                        //the artist object
                                        let cart: ProcessingOrderModel
                                        
                                        //getting the artist of selected position
                                        cart = processingList[indexPath.row]
                                        
                                        //adding values to labels
                                        
                                        //.orderId.text = cart.orderId
                               
                               
                               VC1.orderId = cart.orderId ?? ""
                               VC1.userId = cart.userId ?? ""
                    VC1.status = "processing"
                               

                               self.navigationController?.pushViewController(VC1, animated: true)
                              
                             
                                     
                                    
                                 }
                          
            
            case newOrdersTableView:
            
            if(indexPath.row == indexPath.row){
                            
                              let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                              let VC1 = storyBoard.instantiateViewController(withIdentifier: "ORDER_DETAIL") as! OrderDetailsViewController
                                           // the artist object
                                                        //the artist obj
                               
                               
                                        //the artist object
                                        let cart: NewOrderModel
                                        
                                        //getting the artist of selected position
                                        cart = cartList[indexPath.row]
                                        
                                        //adding values to labels
                                        
                                        //.orderId.text = cart.orderId
                               
                               
                               VC1.orderId = cart.orderId ?? ""
                               VC1.userId = cart.userId ?? ""
                 VC1.status = "pending"
                               

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
         return 0
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
          cell.userName.text = cart.customerName
          
          
          let soundURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: "New Order", ofType: "mp3")!)

                                                        do{
                                                            audioPlayer = try AVAudioPlayer(contentsOf: soundURL as URL)

                                                        }catch {
                                                            print("there was some error. The error was \(error)")
                                                        }
                                                        audioPlayer.play()
          
          
          
          
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
                    cell.userName.text = cart.customerName
                    
                    
                    refGetUserImage = Database.database().reference().child("users");
                           //observing the data changes
                           
                                                                                                                
                                                                 //observing the data changes
                                                                                          refGetUserImage.observe(DataEventType.value, with: { (snapshot) in
                               
                                    
                                    //if the reference have some values
                                    if snapshot.childrenCount > 0 {
                            
                                     
                                        //iterating through all the values
                                        for carts in snapshot.children.allObjects as! [DataSnapshot] {
                                            //getting values
                                            let cartObject = carts.value as? [String: AnyObject]
                                           
                                            let userImage = cartObject?["imageUrl"]
                                            let uId = cartObject?["userId"]
                                            
                                            var userID = ""
                                            userID = uId as! String
                                            
                                            if(userID == cart.userId){
                                                
                                                var userImageUrl = ""
                                                                                         userImageUrl = userImage as! String
                                                                                           
                                                                                           
                                                                                           cell.userImage.kf.indicatorType = .activity
                                                                                           cell.userImage.kf.setImage(with: URL(string:String(userImageUrl)), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
                                                                                                       
                                                                                                      cell.userImage.heightAnchor.constraint(equalToConstant: 127).isActive = true
                                                                                           
                                            }
                                           
                                          
                                           
                                           
                                        
                                          
                                        }
                                        
                                        
                                    }
                                  
                                   
                                  
                                 
                                  
                                })
                    
            
            //returning cell
            return cell
            
            
            
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
                           cell.userName.text = cart.customerName
                           
                           
                         
                           
                                  
                          
                           
                           self.customerDistance = Int(cart.distance ?? "") ?? 25
                                    if(customerDistance < 20){
                                        
                                        let notificationType = "Customer \(cart.customerName ?? "") is arriving. Make sure order \(cart.orderId ?? "") is ready"
                                                    let alertTitle = "Customer Arriving"
                                                           
                                                          
                                                               
                                                             self.appDelegate?.scheduleNotification(notificationType: notificationType, alertTitle: alertTitle)

                                        
                                        
                                        let soundURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: "Shop Bell", ofType: "mp3")!)

                                               do{
                                                   audioPlayer = try AVAudioPlayer(contentsOf: soundURL as URL)

                                               }catch {
                                                   print("there was some error. The error was \(error)")
                                               }
                                               audioPlayer.play()
                                        
                                        
                                     
                                        
                                        
                                         cell.eView.alpha = 1
                                                            
                                        cell.selectedButton.setTitle("Arriving", for: .normal)
                                        cell.selectedButton.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
                                        cell.selectedButton.layer.borderColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
                                        

                                        self.lottieView.alpha = 1
                                         self.lottieView.animation = Animation.named("Bell1")
                                         //let lottieView = AnimationView(animation: loadingAnimation)
                                             // 2. SECOND STEP (Adding and setup):
                                        cell.eView.addSubview(self.lottieView)
                                         self.lottieView.contentMode = .scaleAspectFit
                                         self.lottieView.loopMode = .autoReverse
                                         self.lottieView.play(toFrame: .infinity)
                                         
                                         
                                         
                                             // 3. THIRD STEP (LAYOUT PREFERENCES):
                                         self.lottieView.translatesAutoresizingMaskIntoConstraints = false
                                             NSLayoutConstraint.activate([
                                                 self.lottieView.leftAnchor.constraint(equalTo: cell.eView.leftAnchor),
                                                 self.lottieView.rightAnchor.constraint(equalTo: cell.eView.rightAnchor),
                                                 self.lottieView.topAnchor.constraint(equalTo: cell.eView.topAnchor),
                                                 self.lottieView.bottomAnchor.constraint(equalTo: cell.eView.bottomAnchor)
                                             ])
                                                            
                                        }
                           
                                    else{
                                        cell.selectedButton.setTitle("Waiting", for: .normal)
                                         cell.selectedButton.backgroundColor = #colorLiteral(red: 0.1574917387, green: 0.1002987968, blue: 0.2773635787, alpha: 1)
                                         cell.selectedButton.layer.borderColor = #colorLiteral(red: 0.1574917387, green: 0.1002987968, blue: 0.2773635787, alpha: 1)
                                        
                                        cell.eView.alpha = 0
                           }
                               
                           
                           
                           refGetUserImage = Database.database().reference().child("users");
                                                    //observing the data changes
                                                    
                                                                                                                                         
                                                                                          //observing the data changes
                                                                                                                   refGetUserImage.observe(DataEventType.value, with: { (snapshot) in
                                                        
                                                             
                                                             //if the reference have some values
                                                             if snapshot.childrenCount > 0 {
                                                     
                                                              
                                                                 //iterating through all the values
                                                                 for carts in snapshot.children.allObjects as! [DataSnapshot] {
                                                                     //getting values
                                                                     let cartObject = carts.value as? [String: AnyObject]
                                                                    
                                                                     let userImage = cartObject?["imageUrl"]
                                                                     let uId = cartObject?["userId"]
                                                                     
                                                                     var userID = ""
                                                                     userID = uId as! String
                                                                     
                                                                     if(userID == cart.userId){
                                                                         
                                                                         var userImageUrl = ""
                                                                                                                  userImageUrl = userImage as! String
                                                                                                                    
                                                                                                                    
                                                                                                                    cell.userImage.kf.indicatorType = .activity
                                                                                                                    cell.userImage.kf.setImage(with: URL(string:String(userImageUrl)), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
                                                                                                                                
                                                                                                                               cell.userImage.heightAnchor.constraint(equalToConstant: 127).isActive = true
                                                                                                                    
                                                                     }
                                                                    
                                                                   
                                                                    
                                                                    
                                                                 
                                                                   
                                                                 }
                                                                 
                                                                 
                                                             }
                                                           
                                                            
                                                           
                                                          
                                                           
                                                         })
                           
                          
            
            //returning cell
            return cell
            
         default:
            print("Some things Wrong!!")
            
        }
    return cell
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        UIApplication.shared.applicationIconBadgeNumber = 0
        
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
        let query_process = refGetProcessingOrders.queryOrdered(byChild: "status").queryEqual(toValue: "preparing")
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
                                                     let customerName = cartObject?["name"]
                                                    let distance = cartObject?["distance"]

                                                     
                                                    //creating artist object with model and fetched values
                                                    let food = ProcessingOrderModel(userId: userId as! String?, orderId: orderId as! String?,dataKey: dataKey as! String?, customerName: customerName as! String?, distance: distance as! String?)
                                                                                   
                                                     
                                                                                   //appending it to list
                                                             self.processingList.append(food)
                                             
                                                    
                                                  }
                                                  
                                                  //reloading the tableview
                                                  self.processingOrdersTableView.reloadData()
                                              }
                                            
                                            
                                           
                                            
                                          })
               
        
        

        
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
                                                                 let customerName = cartObject?["name"]
                                                                  let distance = cartObject?["distance"]
                                                                

                                                               
                                                              //creating artist object with model and fetched values
                                                                let food = NewOrderModel(userId: userId as! String?, orderId: orderId as! String?, dataKey: dataKey as! String?, customerName: customerName as! String?, distance: distance as! String?)
                                                                                             
                                                               
                                                                                             //appending it to list
                                                                       self.cartList.append(food)
                                                       
                                                              
                                                            }
                                                            
                                                            //reloading the tableview
                                                            self.newOrdersTableView.reloadData()
                                                        }
                                                      
                                                      
                                                     
                                                      
                                                    })
                        
        
        
       
        
     
                         
        
        
        //observing the data changes
        let query_ready = refGetReadyOrders.queryOrdered(byChild: "status").queryEqual(toValue: "ready")
                                                 query_ready.observe(DataEventType.value, with: { (snapshot) in
                                       
                                       //if the reference have some values
                                       if snapshot.childrenCount > 0 {
                                         
                                        
                                        self.eViewReady.alpha = 0
                                        self.emptyReadyOrders.alpha = 0
                                        self.readyOrdersTableView.alpha = 1
                                        
                                     
                                         
                                        
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
                                            let customerName = cartObject?["name"]
                                            let distance = cartObject?["distance"]
                                            
                                            self.coreOrderId = orderId as! String
                                            self.coreCustomerName = customerName as! String
                                            self.coreDistance = distance as! String

                                              
                                             //creating artist object with model and fetched values
                                            let food = ReadyOrderModel(userId: userId as! String?, orderId: orderId as! String?,dataKey: dataKey as! String?, customerName: customerName as! String?, distance: distance as! String?)
                                                                            
                                              
                                                                            //appending it to list
                                                      self.readyList.append(food)
                                            
                                            
                                            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                                                  
                                                  //We need to create a context from this container
                                                  let managedContext = appDelegate.persistentContainer.viewContext
                                                  
                                                  //Now let’s create an entity and new user records.
                                                  let userEntity = NSEntityDescription.entity(forEntityName: "OrderStatus", in: managedContext)!
                                                  
                                                  //final, we need to add some data to our newly created record for each keys using
                                                  //here adding 5 data with loop
                                                  
                                                  
                                                      
                                                      let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
                                            user.setValue("\(self.coreCustomerName)", forKeyPath: "userName")
                                            user.setValue("\(self.coreOrderId)", forKey:"orderId")
                                            user.setValue("\( self.coreDistance)", forKey: "distance")
                                                  

                                                  //Now we have set all the values. The next step is to save them inside the Core Data
                                                  
                                                  do {
                                                      try managedContext.save()
                                                     
                                                  } catch let error as NSError {
                                                      print("Could not save. \(error), \(error.userInfo)")
                                                  }
                                            
                                            }
                                        
                                        
                                      
                                             
                                           
                                        
                                        
                                        
                                           
                                           //reloading the tableview
                                           self.readyOrdersTableView.reloadData()
                                      
                                       }
                                                    
                                       else{
                                        
                                        self.readyOrdersTableView.alpha = 0
                                        self.eViewReady.alpha = 1
                                        self.emptyReadyOrders.alpha = 1
                                        self.lottieView.alpha = 1
                                         self.lottieView.animation = Animation.named("No Ready")
                                         //let lottieView = AnimationView(animation: loadingAnimation)
                                             // 2. SECOND STEP (Adding and setup):
                                        self.eViewReady.addSubview(self.lottieView)
                                         self.lottieView.contentMode = .scaleAspectFit
                                         self.lottieView.loopMode = .autoReverse
                                         self.lottieView.play(toFrame: .infinity)
                                         
                                         
                                         
                                             // 3. THIRD STEP (LAYOUT PREFERENCES):
                                         self.lottieView.translatesAutoresizingMaskIntoConstraints = false
                                             NSLayoutConstraint.activate([
                                                 self.lottieView.leftAnchor.constraint(equalTo: self.eViewReady.leftAnchor),
                                                 self.lottieView.rightAnchor.constraint(equalTo: self.eViewReady.rightAnchor),
                                                 self.lottieView.topAnchor.constraint(equalTo: self.eViewReady.topAnchor),
                                                 self.lottieView.bottomAnchor.constraint(equalTo: self.eViewReady.bottomAnchor)
                                             ])
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
        
        self.noOrders.text = String(cartList.count )

      
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        if self.lottieView.isAnimationPlaying == false {
                   self.lottieView.play()
               }
        
        super.viewWillAppear(animated)
        
        
        
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
                                
                                
                                //observing the data changes
                                let query_finish = self.refGetOrderInfo.queryOrdered(byChild: "status").queryEqual(toValue: "finish")
                                                                                      
                                       query_finish.observe(DataEventType.value, with: { (snapshot) in
                                                                                             
                                                                                             //if the reference have some values
                                                                                             if snapshot.childrenCount > 0 {
                                                                                               
                                                                                              
                                                                                               
                                                                                           
                                                                                               
                                                                                              
                                                                                                
                                                                                               // self.animationView.alpha = 0
                                                                                                 //iterating through all the values
                                                                                                 for newOrders in snapshot.children.allObjects as! [DataSnapshot] {
                                                                                                     //getting values
                                                                                                    
                                                                                                   
                                                                                                  
                                                                                                    let cartObject = newOrders.value as? [String: AnyObject]
                                                                                                    let userId  = cartObject?["userId"]
                                                                                                    let orderId  = cartObject?["orderId"]
                                                                                                    let dataKey = cartObject?["key"]
                                                                                                      let customerName = cartObject?["name"]
                                                                                                       let distance = cartObject?["distance"]
                                                                                                     
                                                                       var orderkey = ""
                                                                      
                                                                      orderkey = orderId as! String
                                                                    var cusKey = ""
                                                                    cusKey = userId as! String
                                                                                                    
                                                                    var cusDatakey = ""
                                                                    cusDatakey = dataKey as! String
                                                                                                    
 
                                                                                                    
                                                                                                   
                                                    let ref = Database.database().reference()
                                                                                                  ref.child("myOrder/\(cusKey)/\(orderkey)").observeSingleEvent(of: .value)  { (snapshotOrder) in
                                                            ref.child("History/\(orderkey)").setValue(snapshotOrder.value)
                                                                                                    
                                                                                     
                                                                             ref.child("myOrder/\(cusKey)/\(orderkey)").setValue(nil)
                                                                                                    
                                                                                                    ref.child("order status/\(cusDatakey)").setValue(nil)
                                                                             
                                                                                                             }
                                                                                                          
                                                                                                  
                                                                                                  

                                                                                                   
                                                                                                 }
                                                                                                
                                                                                                
                                                                                                 
                                                                                                
                                                                                             }
                                                                                           
                                                                                           
                                                                                          
                                                                                           
                                                                                         })

                                                     

                                                         }))
                 
                 
                 
                         self.present(alert, animated: true, completion: nil)
                             
                           }
        
    }
    
    func onhandleSelection_Ready() {
        
          self.view.layoutIfNeeded()
    }
}
