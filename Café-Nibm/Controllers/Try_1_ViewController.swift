//
//  ViewController.swift
//  IOS-Swift-MultipleTableView
//
//  Created by Pooya on 2018-11-12.
//  Copyright © 2018 Pooya. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher
import FirebaseAuth


class Try_1_ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var emptyCartImage: UIImageView!
    
    // Initialize Database, Auth, Storage
              var database = Database.database()
              var storage = Storage.storage()
      
       
    var count = Int()
    
    
    
    //@IBOutlet weak var topTableView: UITableView!
    @IBOutlet weak var downTableview: UITableView!
    var topData : [String] = []
    var downData = [String]()
    
    
    var refFoods: DatabaseReference!
    var refCarts: DatabaseReference!
    let user = Auth.auth().currentUser
    
    var updateCart: DatabaseReference!
    
    
    
    //list to store all the artist
     var foodList = [FoodModel]()
      var cartList = [CartModel]()
    
   public func numberOfSections(in tableView: UITableView) -> Int {
        switch tableView {
        case downTableview:
            return 1
        default:
            return 1
        }
    }
    
   public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tap on \(indexPath.row)")
        
        
        switch tableView {
       
            
        case downTableview:
           
               if(indexPath.row == indexPath.row){
              
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                                  let VC1 = storyBoard.instantiateViewController(withIdentifier: "FOOD_ITEM") as! FoodItemViewController
                             //the artist object
                                          let food: FoodModel
                                          
                                          //getting the artist of selected position
                                          food = foodList[indexPath.row]
                             
                                             VC1.fName = food.name ?? ""
                                             VC1.fDescription = food.description ?? ""
                                             VC1.fPrice = String(food.price!)
                
                
                
                
                

                                                    
                       
                       self.navigationController?.pushViewController(VC1, animated: true)
                
               
                       
                      
                   }
            default:
            print("Some things Wrong!!")
            
        }
        
        
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
         
          var numberOfRow = 1
               switch tableView {
               
               case downTableview:
                   numberOfRow =  foodList.count
               default:
                   print("Some things Wrong!!")
               }
               return numberOfRow
           }
       
       
       public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        var cell = UITableViewCell()
         switch tableView {
        
        

         case downTableview:
            
            
           
            
             //creating a cell using the custom class
             let cell = tableView.dequeueReusableCell(withIdentifier: "downCell1", for: indexPath) as! RestaurantTableViewCell
              
              //the artist object
              let food: FoodModel
              
              //getting the artist of selected position
              food = foodList[indexPath.row]
              
              //adding values to labels
              cell.foodName.text = food.name
              cell.foodDescription.text = food.description
              cell.foodPrice.text = String(food.price!)
             cell.foodImage.kf.indicatorType = .activity
             cell.foodImage.kf.setImage(with: URL(string:String(food.foodImage ?? "")), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
             
            cell.foodImage.heightAnchor.constraint(equalToConstant: 127).isActive = true
             
             
        
              //returning cell
              return cell
              
         default:
             print("Some things Wrong!!")
         }
         return cell
           
       }
       
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        
       
        
       
        downTableview.delegate = self
        
        downTableview.dataSource = self
        
        for index in 0...20 {
            topData.append("Top Table Row \(index)")
        }
        
        for index in 10...45 {
            downData.append("Down Table Row \(index)")
        }
        
        //getting a reference to the node artists
               refFoods = Database.database().reference().child("Foods");
                 
                 //observing the data changes
                      refFoods.observe(DataEventType.value, with: { (snapshot) in
                          
                          //if the reference have some values
                          if snapshot.childrenCount > 0 {
                              
                              //clearing the list
                              self.foodList.removeAll()
                              
                              //iterating through all the values
                              for Foods in snapshot.children.allObjects as! [DataSnapshot] {
                                  //getting values
                                  let foodObject = Foods.value as? [String: AnyObject]
                                  let foodName  = foodObject?["name"]
                                  let foodDescription  = foodObject?["description"]
                                  let foodPrice = foodObject?["price"]
                                let foodImage = foodObject?["foodImage"]
                                  
                                  //creating artist object with model and fetched values
                                let food = FoodModel(description: foodDescription as! String?, name: foodName as! String?, price: foodPrice as! String?, foodImage: foodImage as! String?)
                                  
                                  //appending it to list
                                  self.foodList.append(food)
                                
                                
                               
                                
                                
                                
                              }
                              
                              //reloading the tableview
                              self.downTableview.reloadData()
                          }
                      })
        
        //getting a reference to the node artists
        refCarts = Database.database().reference().child("addCart/\(self.user?.uid ?? "")");
          
          //observing the data changes
               refCarts.observe(DataEventType.value, with: { (snapshot) in
                   
                   //if the reference have some values
                   if snapshot.childrenCount > 0 {
                     
                  self.emptyCartImage.alpha = 0
                       
                       //clearing the list
                       self.cartList.removeAll()
                        
                       //iterating through all the values
                       for carts in snapshot.children.allObjects as! [DataSnapshot] {
                           //getting values
                           let cartObject = carts.value as? [String: AnyObject]
                           let cartItemPrice  = cartObject?["foodPrice"]
                           let cartNoUnits  = cartObject?["noFoods"]
                           let cartAmount = cartObject?["amount"]
                           let cartFoodName = cartObject?["foodName"]
                           let cartID = cartObject?["id"]
                            
                           
                        
                        
                           //creating artist object with model and fetched values
                         let cart = CartModel(itemPrice: cartItemPrice as! String?, noItems: cartNoUnits as! String?, amount: cartAmount as! String?, foodName: cartFoodName as! String?, cID: cartID as! String? )
                           
                           //appending it to list
                           self.cartList.append(cart)
                         
                         
                       }
                       
                       //reloading the tableview
                     
                   }
                
                   else {
                    
                }
                 
                
                 
                
                 
               })

    }
    
    
    @IBAction func riceClicked(_ sender: Any) {
        
        
        //getting a reference to the node artists
        refFoods = Database.database().reference().child("Foods");
          
          //observing the data changes
        let query = refFoods.queryOrdered(byChild: "type").queryEqual(toValue: "RICE")
               query.observe(DataEventType.value, with: { (snapshot) in
                   
                   //if the reference have some values
                   if snapshot.childrenCount > 0 {
                       
                       //clearing the list
                       self.foodList.removeAll()
                       
                       //iterating through all the values
                       for Foods in snapshot.children.allObjects as! [DataSnapshot] {
                           //getting values
                           let foodObject = Foods.value as? [String: AnyObject]
                           let foodName  = foodObject?["name"]
                           let foodDescription  = foodObject?["description"]
                           let foodPrice = foodObject?["price"]
                        let foodImage = foodObject?["foodImage"]

                           
                           //creating artist object with model and fetched values
                        let food = FoodModel(description: foodDescription as! String?, name: foodName as! String?, price: foodPrice as! String?, foodImage: foodImage as! String?)
                           
                           //appending it to list
                           self.foodList.append(food)
                         
                         
                      
                         
                       }
                       
                       //reloading the tableview
                       self.downTableview.reloadData()
                   }
               })
         
    }
    
    @IBAction func allClicked(_ sender: Any) {
        
        //getting a reference to the node artists
        refFoods = Database.database().reference().child("Foods");
          
          //observing the data changes
               refFoods.observe(DataEventType.value, with: { (snapshot) in
                   
                   //if the reference have some values
                   if snapshot.childrenCount > 0 {
                       
                       //clearing the list
                       self.foodList.removeAll()
                       
                       //iterating through all the values
                       for Foods in snapshot.children.allObjects as! [DataSnapshot] {
                           //getting values
                           let foodObject = Foods.value as? [String: AnyObject]
                           let foodName  = foodObject?["name"]
                           let foodDescription  = foodObject?["description"]
                           let foodPrice = foodObject?["price"]
                         let foodImage = foodObject?["foodImage"]
                           
                           //creating artist object with model and fetched values
                        let food = FoodModel(description: foodDescription as! String?, name: foodName as! String?, price: foodPrice as! String?, foodImage: foodImage as! String?)
                           
                           //appending it to list
                           self.foodList.append(food)
                        
                         
                       }
                       
                       //reloading the tableview
                       self.downTableview.reloadData()
                   }
               })
        
    }
    
    
    @IBAction func streetFoodClicked(_ sender: Any) {
        
        
        //getting a reference to the node artists
        refFoods = Database.database().reference().child("Foods");
          
          //observing the data changes
        let query = refFoods.queryOrdered(byChild: "type").queryEqual(toValue: "STREET FOOD")
               query.observe(DataEventType.value, with: { (snapshot) in
                   
                   //if the reference have some values
                   if snapshot.childrenCount > 0 {
                       
                       //clearing the list
                       self.foodList.removeAll()
                       
                       //iterating through all the values
                       for Foods in snapshot.children.allObjects as! [DataSnapshot] {
                           //getting values
                           let foodObject = Foods.value as? [String: AnyObject]
                           let foodName  = foodObject?["name"]
                           let foodDescription  = foodObject?["description"]
                           let foodPrice = foodObject?["price"]
                          let foodImage = foodObject?["foodImage"]
                           
                           //creating artist object with model and fetched values
                        let food = FoodModel(description: foodDescription as! String?, name: foodName as! String?, price: foodPrice as! String?, foodImage: foodImage as! String?)
                           
                           //appending it to list
                           self.foodList.append(food)
                         
                         
                      
                         
                       }
                       
                       //reloading the tableview
                       self.downTableview.reloadData()
                   }
               })
    }
    
    @IBAction func beverageClicked(_ sender: Any) {
        
        
        //getting a reference to the node artists
        refFoods = Database.database().reference().child("Foods");
          
          //observing the data changes
        let query = refFoods.queryOrdered(byChild: "type").queryEqual(toValue: "BEVERAGE")
               query.observe(DataEventType.value, with: { (snapshot) in
                   
                   //if the reference have some values
                   if snapshot.childrenCount > 0 {
                       
                       //clearing the list
                       self.foodList.removeAll()
                       
                       //iterating through all the values
                       for Foods in snapshot.children.allObjects as! [DataSnapshot] {
                           //getting values
                           let foodObject = Foods.value as? [String: AnyObject]
                           let foodName  = foodObject?["name"]
                           let foodDescription  = foodObject?["description"]
                           let foodPrice = foodObject?["price"]
                         let foodImage = foodObject?["foodImage"]
                           
                           //creating artist object with model and fetched values
                        let food = FoodModel(description: foodDescription as! String?, name: foodName as! String?, price: foodPrice as! String?, foodImage: foodImage as! String?)
                           
                           //appending it to list
                           self.foodList.append(food)
                         
                         
                      
                         
                       }
                       
                       //reloading the tableview
                       self.downTableview.reloadData()
                   }
               })
    }
    
    @IBAction func bakeryClicked(_ sender: Any) {
        
        
        //getting a reference to the node artists
        refFoods = Database.database().reference().child("Foods");
          
          //observing the data changes
        let query = refFoods.queryOrdered(byChild: "type").queryEqual(toValue: "BAKERY")
               query.observe(DataEventType.value, with: { (snapshot) in
                   
                   //if the reference have some values
                   if snapshot.childrenCount > 0 {
                       
                       //clearing the list
                       self.foodList.removeAll()
                       
                       //iterating through all the values
                       for Foods in snapshot.children.allObjects as! [DataSnapshot] {
                           //getting values
                           let foodObject = Foods.value as? [String: AnyObject]
                           let foodName  = foodObject?["name"]
                           let foodDescription  = foodObject?["description"]
                           let foodPrice = foodObject?["price"]
                        let foodImage = foodObject?["foodImage"]

                           
                           //creating artist object with model and fetched values
                        let food = FoodModel(description: foodDescription as! String?, name: foodName as! String?, price: foodPrice as! String?, foodImage: foodImage as! String?)
                           
                           //appending it to list
                           self.foodList.append(food)
                         
                         
                      
                         
                       }
                       
                       //reloading the tableview
                       self.downTableview.reloadData()
                   }
               })
    }
    
    @IBAction func appertizerClicked(_ sender: Any) {
        
        
        //getting a reference to the node artists
        refFoods = Database.database().reference().child("Foods");
          
          //observing the data changes
        let query = refFoods.queryOrdered(byChild: "type").queryEqual(toValue: "APPERTIZER")
               query.observe(DataEventType.value, with: { (snapshot) in
                   
                   //if the reference have some values
                   if snapshot.childrenCount > 0 {
                       
                       //clearing the list
                       self.foodList.removeAll()
                       
                       //iterating through all the values
                       for Foods in snapshot.children.allObjects as! [DataSnapshot] {
                           //getting values
                           let foodObject = Foods.value as? [String: AnyObject]
                           let foodName  = foodObject?["name"]
                           let foodDescription  = foodObject?["description"]
                           let foodPrice = foodObject?["price"]
                         let foodImage = foodObject?["foodImage"]
                           
                           //creating artist object with model and fetched values
                        let food = FoodModel(description: foodDescription as! String?, name: foodName as! String?, price: foodPrice as! String?, foodImage: foodImage as! String?)
                           
                           //appending it to list
                           self.foodList.append(food)
                         
                         
                      
                         
                       }
                       
                       //reloading the tableview
                       self.downTableview.reloadData()
                   }
               })
    }
    
    

    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          navigationController?.setNavigationBarHidden(true, animated: animated)
          
          
      }

      override func viewWillDisappear(_ animated: Bool) {
          super.viewWillDisappear(animated)
          navigationController?.setNavigationBarHidden(true, animated: animated)
      }
    
    
}


extension Try_1_ViewController: RestaurantTableViewCellDelegate{
    func plusItemTapped() {
        print("PLus Tapped:")
        
        self.count = self.count + 1
        
        print(self.count)
        
    }
    
    func minusItemTapped() {
        print("Minus Tapped:")
        self.count = self.count - 1
           print(self.count)
    }
    
    
       
    
}
