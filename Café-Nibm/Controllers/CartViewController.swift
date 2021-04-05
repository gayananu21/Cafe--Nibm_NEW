//
//  CartViewController.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 3/2/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Lottie

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    @IBOutlet weak var eView: UIView!
    
    
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var emptyCartView: UIView!
    @IBOutlet weak var cartTableView: UITableView!
    
    var total:Int = 0
    
   
     let lottieView = AnimationView()
    
  
    

    var fID = ""
    
     var refCarts: DatabaseReference!
     var refOrders: DatabaseReference!
     var refOrder: DatabaseReference!
     let user = Auth.auth().currentUser
   



    
    //list to store all the artist
     var cartList = [CartModel]()
    
    

    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return cartList.count
    }
    
  
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         print("you tap on \(indexPath.row)")
         
         
        
         
         
     }
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        print("Deleted")
        
        
        
        

          //creating a cell using the custom class
          let cell = tableView.dequeueReusableCell(withIdentifier: "CART_CELL", for: indexPath) as! CartTableViewCell
          
        
          
          //the artist object
          let cart: CartModel
          
          //getting the artist of selected position
          cart = cartList[indexPath.row]
          fID = cart.cID!
        
        
      

        
        tableView.beginUpdates()
        Database.database().reference().child("addCart/\(self.user?.uid ?? "")").child(fID).removeValue()
        tableView.endUpdates()
        
      }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        if(indexPath.row == indexPath.row){
            
            
            
        }
      
        
      
        //creating a cell using the custom class
        let cell = tableView.dequeueReusableCell(withIdentifier: "CART_CELL", for: indexPath) as! CartTableViewCell
        
        
      
        
        //the artist object
        let cart: CartModel
        
        //getting the artist of selected position
        cart = cartList[indexPath.row]
       
        cell.foodCount = Int(cart.noItems ?? "") ?? 1
                       
        cell.unitPrice = Int(cart.itemPrice ?? "") ?? 1
     
        
        self.total += Int(cart.amount ?? "") ?? 0
        self.totalAmount.text = String(self.total)
        
        //adding values to labels
        cell.itemPrice.text = cart.itemPrice
        cell.noItems.text = cart.noItems
        cell.amount.text = cart.amount
        cell.foodName.text = cart.foodName
        fID = cart.cID!
        
        
        
        //returning cell
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        cartTableView.delegate = self
               cartTableView.dataSource = self
               
               //getting a reference to the node artists
               refCarts = Database.database().reference().child("addCart/\(self.user?.uid ?? "")");
                 
                 //observing the data changes
                      refCarts.observe(DataEventType.value, with: { (snapshot) in
                          
                          //if the reference have some values
                          if snapshot.childrenCount > 0 {
                            
                           
                            
                        
                            
                            self.tabBarController?.tabBar.items![1].image =  UIImage(systemName: "cart.fill")
                            // items![0] index of your tab bar item.items![0] means tabbar first item

                             self.tabBarController?.tabBar.items![1].selectedImage = UIImage(systemName: "cart.fill")
                              
                              //clearing the list
                              self.cartList.removeAll()
                               self.emptyCartView.alpha = 0
                            self.lottieView.alpha = 0
                            // self.animationView.alpha = 0
                              //iterating through all the values
                              for carts in snapshot.children.allObjects as! [DataSnapshot] {
                                  //getting values
                                  let cartObject = carts.value as? [String: AnyObject]
                                  let cartItemPrice  = cartObject?["foodPrice"]
                                  let cartNoUnits  = cartObject?["noFoods"]
                                  let cartAmount = cartObject?["amount"]
                                  let cartFoodName = cartObject?["foodName"]
                                  let cartID = cartObject?["id"]
                                
                                //self.total += cartAmount as! Int
                              
                               
                                  
                               
                               
                                  //creating artist object with model and fetched values
                                let cart = CartModel(itemPrice: cartItemPrice as! String?, noItems: cartNoUnits as! String?, amount: cartAmount as! String?, foodName: cartFoodName as! String?, cID: cartID as! String? )
                                  
                               
                                  //appending it to list
                                  self.cartList.append(cart)
                                
                                
                                
                              }
                              
                              //reloading the tableview
                              self.cartTableView.reloadData()
                          }
                        
                          else{
                         
                           self.lottieView.alpha = 1
                            self.lottieView.animation = Animation.named("emprtCart")
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
                            
                            
                            self.emptyCartView.alpha = 1
                            self.cartTableView.reloadData()
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
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    
    @IBAction func addOrderClick(_ sender: Any) {
        
        
             let notificationType = "We will let you know quickly when the order ready. Check order detials for more info."
             let alertTitle = "We received your order"
                    
                    let alert = UIAlertController(title: "Success",
                                                  message:"Your order placed successfully",
                                                  preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        
                      self.appDelegate?.scheduleNotification(notificationType: notificationType, alertTitle: alertTitle)
                    }
                    
                    alert.addAction(okAction)
                    present(alert, animated: true, completion: nil)
        
        refOrders = Database.database().reference()
        refOrder = Database.database().reference().child("myOrder/\(self.user?.uid ?? "")")

        let key = refOrder.childByAutoId().key
        
            let ref = Database.database().reference()
        ref.child("addCart/\(self.user?.uid ?? "")").observeSingleEvent(of: .value)  { (snapshot) in
            ref.child("myOrder/\(self.user?.uid ?? "")/\(key ?? "")").setValue(snapshot.value)
          
                   }
                ref.child("addCart/\(self.user?.uid ?? "")").setValue(nil)
        

       
        
        
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
