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
    
  
    @IBOutlet weak var topView1_Width: NSLayoutConstraint!
    
    @IBOutlet weak var topView_1: UIView!
    var titleLabel = UILabel()
    var stackview = UIStackView()
    
    let button = SurveyButton()

    var numberOfButtons = 0
    var btnCount = Int()
    var buttonArray = [String]()
      var refFoodCategories: DatabaseReference!

   // @IBOutlet weak var emptyCartImage: UIImageView!
    
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
                                VC1.foodKey = food.key ?? ""
                
                
                
                
                

                                                    
                       
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
              
             
             cell.delegate = self
                  cell.Index = indexPath
             
              //the artist object
              let food: FoodModel
              
              //getting the artist of selected position
              food = foodList[indexPath.row]
             
             if (food.availability == "on"){
                
               
                cell.foodStatusImage.image = UIImage(named:"xMark")
                
                cell.foodImage.alpha = 0.3
                cell.foodName.alpha = 0.3
                cell.foodDescription.alpha = 0.3
                cell.foodPrice.alpha = 0.3
                cell.foodDiscount.alpha = 0.3
                cell.foodPriceType.alpha = 0.3
                cell.foodDiscount.backgroundColor = .systemRed
                 cell.foodDiscount.borderColor = .systemRed
                
                cell.foodUnView.alpha = 0.5
                
                
                
                
                
                cell.foodSwitch.setOn(true, animated: true)
             }
             
             if (food.availability == "off"){
                
                
                cell.foodUnView.alpha = 0
                
               cell.foodStatusImage.image = UIImage(named:"orderRight")
                
                cell.foodImage.alpha = 1
                cell.foodName.alpha = 1
                cell.foodDescription.alpha = 1
                cell.foodPrice.alpha = 1
                cell.foodDiscount.alpha = 1
                cell.foodPriceType.alpha = 1
                cell.foodDiscount.backgroundColor = .systemGreen
                cell.foodDiscount.borderColor = .systemGreen
                
               
                cell.foodSwitch.setOn(false, animated: true)
             }
              
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
        
        //configureTitleLabel()
                     configureStackView()
     
       
       
       
        
       
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
                                  let key = foodObject?["id"]
                                  let availability = foodObject?["availability"]
                                  
                                  //creating artist object with model and fetched values
                                let food = FoodModel(description: foodDescription as! String?, name: foodName as! String?, price: foodPrice as! String?, foodImage: foodImage as! String?, key: key as! String?, availability: availability as! String?)
                                  
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
                     
              //    self.emptyCartImage.alpha = 0
                       
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
    
    
    func configureStackView(){
          topView_1.addSubview(stackview)
          stackview.axis = .horizontal
          stackview.distribution = .fillEqually
          stackview.spacing = 0
          
          addButtonToStackView()
          setStackViewConstraints()
      }
      
      func addButtonToStackView() {
        
       
        
            
            
            //getting a reference to the node artists
                   refFoodCategories = Database.database().reference().child("FoodCategories");
            
            
                     
                     //observing the data changes
                          refFoodCategories.observe(DataEventType.value, with: { (snapshot) in
                              
                              //if the reference have some values
                              if snapshot.childrenCount > 0 {
                                  
                                //clearing the list
                                self.foodList.removeAll()
                                 
                                 self.numberOfButtons = Int(snapshot.childrenCount) - 1
                                 
                                  
                                  //iterating through all the values
                                  for Foodsd in snapshot.children.allObjects as! [DataSnapshot] {
                                      //getting values
                                      let foodObject = Foodsd.value as? [String: AnyObject]
                                   
                                      let categoryName  = foodObject?["name"]
                                    //  let foodPrice = foodObject?["price"]
                                      //let key = foodObject?["id"]
                                        
                                       
                                    self.buttonArray.append(categoryName as! String)
                      
                                  }
                       
                            }
                            
                            for i in 0...self.numberOfButtons{
                                  
                                 
                                if(self.numberOfButtons<5){
                                    self.topView1_Width.constant = 750
                                            
                                        }
                                        
                                        else{
                                            
                                    self.topView1_Width.constant = CGFloat((self.numberOfButtons + 1) * 150)
                                        }
                                              
                                        
                                    
                                    let button = SurveyButton()
                                    
                                    if(i % 2 == 0){
                                        button.firstColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                                         button.secondColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
                                        button.isHorizontal = false
                                        
                                    }
                                    
                                    else{
                                        
                                        button.firstColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                                        button.secondColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                                         button.isHorizontal = false
                                    }
                                    

                              
                                
                              button.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
                                    
                                //  self.buttonArray = ["hellow","gayan"]
                                    
                                  button.setTitle("\(self.buttonArray[i])", for: .normal)
                                   // button.setTitle("\(self.buttonArray[4])", for: .normal)
                              self.stackview.addArrangedSubview(button)
                            }
                          })
            
            
       
          
          
          
          
        
      }
      
    
      
      func setStackViewConstraints() {
          
          stackview.translatesAutoresizingMaskIntoConstraints                                                             = false
          stackview.topAnchor.constraint(equalTo: topView_1.safeAreaLayoutGuide.topAnchor, constant: 0).isActive                         = true
          stackview.leadingAnchor.constraint(equalTo: topView_1.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive      = true
          stackview.trailingAnchor.constraint(equalTo: topView_1.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive    = true
          stackview.bottomAnchor.constraint(equalTo: topView_1.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive       = true
      }
      
      
      @objc func buttonAction(_ sender: UIButton) {
          
         let title = sender.currentTitle
         
                     
        
              //getting a reference to the node artists
              refFoods = Database.database().reference().child("Foods");
                
                //observing the data changes
              let query = refFoods.queryOrdered(byChild: "type").queryEqual(toValue: "\(title ?? "")")
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
                                 let key = foodObject?["id"]
                               let availability = foodObject?["availability"]
                                 
                                 //creating artist object with model and fetched values
                               let food = FoodModel(description: foodDescription as! String?, name: foodName as! String?, price: foodPrice as! String?, foodImage: foodImage as! String?, key: key as! String?, availability: availability as! String?)
                                 
                                 //appending it to list
                                 self.foodList.append(food)
                               
                               
                              
                               
                               
                               
                             }
                             
                             //reloading the tableview
                             self.downTableview.reloadData()
                         }
                        
                         else{
                            
                            let alert = UIAlertController(title: "NOTICE", message: "There are no foods under: \(title ?? "") category!", preferredStyle: .alert)
                                                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive, handler: { action in
                                                    switch action.style{
                                                        case .default:
                                                        print("default")
                                                        
                                                        case .cancel:
                                                        print("cancel")
                                                        
                                                        case .destructive:
                                                        print("destructive")
                                                        
                                                    }
                                                }))
                            
                                  alert.addAction(UIAlertAction(title: "Add Food", style: .default, handler: { action in

                                                      let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                                      let vc = storyboard.instantiateViewController(withIdentifier: "ADD_MENU_TAB")
                                                       vc.modalPresentationStyle = .fullScreen
                                    vc.modalTransitionStyle = .partialCurl
                                                      self.present(vc, animated: true)

                                                     }))
                                                         
                                                self.present(alert, animated: true, completion: nil)
                            
                            
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
                           let key = foodObject?["id"]
                         let availability = foodObject?["availability"]
                           
                           //creating artist object with model and fetched values
                         let food = FoodModel(description: foodDescription as! String?, name: foodName as! String?, price: foodPrice as! String?, foodImage: foodImage as! String?, key: key as! String?, availability: availability as! String?)
                           
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
                           let key = foodObject?["id"]
                         let availability = foodObject?["availability"]
                           
                           //creating artist object with model and fetched values
                         let food = FoodModel(description: foodDescription as! String?, name: foodName as! String?, price: foodPrice as! String?, foodImage: foodImage as! String?, key: key as! String?, availability: availability as! String?)
                           
                           //appending it to list
                           self.foodList.append(food)
                 
                       }
                       
                       //reloading the tableview
                       self.downTableview.reloadData()
                   }
                
                else{
                    
                    let alert = UIAlertController(title: "ATTENTION", message: "There are no foods at cafe!", preferredStyle: .alert)
                                        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive, handler: { action in
                                            switch action.style{
                                                case .default:
                                                print("default")
                                                
                                                case .cancel:
                                                print("cancel")
                                                
                                                case .destructive:
                                                print("destructive")
                                                
                                            }
                                        }))
                    alert.addAction(UIAlertAction(title: "Add Food", style: .default, handler: { action in

                     let storyboard = UIStoryboard(name: "Main", bundle: nil)
                     let vc = storyboard.instantiateViewController(withIdentifier: "ADD_MENU_TAB")
                      vc.modalPresentationStyle = .fullScreen
                     vc.modalTransitionStyle = .crossDissolve
                     self.present(vc, animated: true)

                    }))
                                        self.present(alert, animated: true, completion: nil)
                    
                    
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
                           let key = foodObject?["id"]
                         let availability = foodObject?["availability"]
                           
                           //creating artist object with model and fetched values
                         let food = FoodModel(description: foodDescription as! String?, name: foodName as! String?, price: foodPrice as! String?, foodImage: foodImage as! String?, key: key as! String?, availability: availability as! String?)
                           
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
                            let key = foodObject?["id"]
                          let availability = foodObject?["availability"]
                            
                            //creating artist object with model and fetched values
                          let food = FoodModel(description: foodDescription as! String?, name: foodName as! String?, price: foodPrice as! String?, foodImage: foodImage as! String?, key: key as! String?, availability: availability as! String?)
                            
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
                         let key = foodObject?["id"]
                       let availability = foodObject?["availability"]
                         
                         //creating artist object with model and fetched values
                       let food = FoodModel(description: foodDescription as! String?, name: foodName as! String?, price: foodPrice as! String?, foodImage: foodImage as! String?, key: key as! String?, availability: availability as! String?)
                         
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
                          let key = foodObject?["id"]
                        let availability = foodObject?["availability"]
                          
                          //creating artist object with model and fetched values
                        let food = FoodModel(description: foodDescription as! String?, name: foodName as! String?, price: foodPrice as! String?, foodImage: foodImage as! String?, key: key as! String?, availability: availability as! String?)
                          
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
          navigationController?.setNavigationBarHidden(false, animated: animated)
      }
    
    @IBAction func onCategory(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ADD_CAT_TAB")
         vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
        
        
    }
    
    @IBAction func onMenu(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ADD_MENU_TAB")
         vc.modalPresentationStyle = .fullScreen
       vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true)
        
        
    }
}



extension Try_1_ViewController: FoodStatusDelegate {
    func CheckAvailability(Index: Int, isOn: Bool) {
        
        

      if(isOn == true){
                  
        
        let food: FoodModel
        
        //getting the artist of selected position
        food = foodList[Index]
                  
        
            let ref = Database.database().reference()
                                 // let userRef = ref.child("addCart/PbvgpIOEccP1DQnwCUz2Iy3wJRm1/-MXSRJGwo57AYd3p5ErH")
            let userRef = ref.child("Foods/\(food.key ?? "")")
                                  userRef.updateChildValues(["availability": String("on")])
  
        
        
        
            
            
            
                  
              }
        
        
        if(isOn == false){
            
            
            //the artist object
                         let food: FoodModel
                         
                         //getting the artist of selected position
                         food = foodList[Index]
            
            
                    
                  
                  
        
            let ref = Database.database().reference()
                                 // let userRef = ref.child("addCart/PbvgpIOEccP1DQnwCUz2Iy3wJRm1/-MXSRJGwo57AYd3p5ErH")
            let userRef = ref.child("Foods/\(food.key ?? "")")
                                  userRef.updateChildValues(["availability": String("off")])
                                  
                                 
                  
              }

        
    }
    
   
    
    
}


