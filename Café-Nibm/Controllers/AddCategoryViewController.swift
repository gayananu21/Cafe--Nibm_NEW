//
//  AddCategoryViewController.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 4/6/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Lottie

class AddCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    //@IBOutlet weak var noOrderView: UIView!
    @IBOutlet weak var CategorytableView: UITableView!
    
    @IBOutlet weak var eView: UIView!
    

    let lottieView = AnimationView()
    
    
    //cityButtons
    @IBOutlet var colorsButtons: [UIButton]!
       
    @IBOutlet weak var catName: UITextField!
    @IBOutlet weak var selectedButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    

    var refAddCategory: DatabaseReference!
    var refGetCategory: DatabaseReference!
    
    
         var categoryList = [CategoryModel]()
    
     var categoryId = ""
    
    
    
          public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
              return categoryList.count
          }
          
          
          public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
              //creating a cell using the custom class
              let cell = tableView.dequeueReusableCell(withIdentifier: "CATEGORY_CELL", for: indexPath) as! CategoryTableViewCell
              
              //the artist object
              let category: CategoryModel
              
              //getting the artist of selected position
              category = categoryList[indexPath.row]
              
              //adding values to labels
              cell.categoryName.text = category.name
            if(category.color == "You select: Green"){
               cell.categoryName.firstColor = .white
               cell.categoryName.secondColor = .lightGray
                cell.categoryName.cornerRadius = 15
                cell.backView.borderWidth = 1
                cell.backView.borderColor = .green
            }
           
           else if(category.color == "You select: Purple"){
                cell.categoryName.firstColor = .white
                cell.categoryName.secondColor = .lightGray
                cell.categoryName.cornerRadius = 15
                           cell.backView.borderWidth = 1
                           cell.backView.borderColor = .systemPurple
                       }
                      
            
           else if(category.color == "You select: Orange"){
                                 cell.categoryName.firstColor = .white
                                 cell.categoryName.secondColor = .lightGray
                 cell.categoryName.cornerRadius = 15
                                  cell.backView.borderWidth = 1
                                  cell.backView.borderColor = .systemOrange
                              }
                             
            
           else if(category.color == "You select: Blue"){
                                 cell.categoryName.firstColor = .white
                                  cell.categoryName.secondColor = .lightGray
                 cell.categoryName.cornerRadius = 15
                                   cell.backView.borderWidth = 1
                                   cell.backView.borderColor = .systemBlue
                               }
            
            else{
               cell.categoryName.firstColor = .white
                cell.categoryName.secondColor = .lightGray
                 cell.categoryName.cornerRadius = 15
                                                  cell.backView.borderWidth = 1
                                                  cell.backView.borderColor = .lightGray
            }
              
           
           
           
                      
              //returning cell
              return cell
          }
       
       public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                 return 100
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
                       let cell = tableView.dequeueReusableCell(withIdentifier: "CATEGORY_CELL", for: indexPath) as! CategoryTableViewCell
                       
                       //the artist object
                       let category: CategoryModel
                       
                       //getting the artist of selected position
             category = categoryList[indexPath.row]
             categoryId = category.key!
            
           
            let alert = UIAlertController(title: "Delete", message: "Do you want to delete \(category.name ?? "") category?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "cancel", style: .default, handler: { action in
                                                            
                                                              
                                                             }))
            alert.addAction(UIAlertAction(title: "Delete ", style: .destructive, handler: { action in

                                            tableView.beginUpdates()
                Database.database().reference().child("FoodCategories").child(self.categoryId).removeValue()
                                            tableView.endUpdates()
                                          

                                         }))
                                                             self.present(alert, animated: true, completion: nil)
                                         
                                         
         

            
           
           
         }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.lottieView.alpha = 1
                                         self.lottieView.animation = Animation.named("Pen")
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
        
        
        
        //Looks for single or multiple taps.
             let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

                   //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
                   //tap.cancelsTouchesInView = false

             view.addGestureRecognizer(tap)
        
        refAddCategory = Database.database().reference().child("FoodCategories");
        
        
        
        
                  
                  //getting a reference to the node artists
                  refGetCategory = Database.database().reference().child("FoodCategories");
                           
                           //observing the data changes
                                refGetCategory.observe(DataEventType.value, with: { (snapshot) in
                                    
                                    //if the reference have some values
                                    if snapshot.childrenCount > 0 {
                                      
                                         //self.noOrderView.alpha = 0
                                  //    self.lottieView.alpha = 0
                                        //clearing the list
                                    self.categoryList.removeAll()
                                        
                                        //iterating through all the values
                                        for categories in snapshot.children.allObjects as! [DataSnapshot] {
                                            //getting values
                                          
                                         
                                        
                                          
                                          
                                          let orderObject = categories.value as? [String: AnyObject]
                                          let name  = orderObject?["name"]
                                          let key = orderObject?["id"]
                                          let color = orderObject?["color"]
                                          
                                          
                                            
                                            //creating artist object with model and fetched values
                                            let order = CategoryModel( name: name as! String?, key: key as! String?, color: color as! String?)
                                            
                                            //appending it to list
                                            self.categoryList.append(order)
                                        }
                                        
                                        //reloading the tableview
                                        self.CategorytableView.reloadData()
                                    }
                                  
                                  
                                })
                  
        
        
        
        
    }
    
    @IBAction func onPreview(_ sender: Any) {
        
        if (!(catName.text ?? "").isEmpty) {
            
            let alert = UIAlertController(title: "Add Category", message: "Do you want to add the new category before leaving.", preferredStyle: .alert)
                                                   alert.addAction(UIAlertAction(title: "Discard", style: UIAlertAction.Style.destructive, handler: { action in
                                                    
                                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                                           let vc = storyboard.instantiateViewController(withIdentifier: "HOME_TAB")
                                                            vc.modalPresentationStyle = .fullScreen
                                                           vc.modalTransitionStyle = .crossDissolve
                                                           self.present(vc, animated: true)
                                                    
                                                   }))
                               alert.addAction(UIAlertAction(title: "Add ", style: .default, handler: { action in

                                

                               }))
                                                   self.present(alert, animated: true, completion: nil)
                               
                               
        }
        
        else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                   let vc = storyboard.instantiateViewController(withIdentifier: "HOME_TAB")
                    vc.modalPresentationStyle = .fullScreen
                   vc.modalTransitionStyle = .crossDissolve
                   self.present(vc, animated: true)
        }
        
       
        
    }
    
    @IBAction func onMenu(_ sender: Any) {
        
       if (!(catName.text ?? "").isEmpty) {
            
            let alert = UIAlertController(title: "Add Category", message: "Do you want to add the new category before leaving", preferredStyle: .alert)
                                                   alert.addAction(UIAlertAction(title: "Discard", style: UIAlertAction.Style.destructive, handler: { action in
                                                    
                                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                                           let vc = storyboard.instantiateViewController(withIdentifier: "ADD_MENU_TAB")
                                                            vc.modalPresentationStyle = .fullScreen
                                                           vc.modalTransitionStyle = .crossDissolve
                                                           self.present(vc, animated: true)
                                                    
                                                   }))
                               alert.addAction(UIAlertAction(title: "Add ", style: .default, handler: { action in

                                

                               }))
                                                   self.present(alert, animated: true, completion: nil)
                               
                               
        }

        
        
        else {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ADD_MENU_TAB")
         vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
        }
        
        
    }
    
    @IBAction func handleSelection(_ sender: UIButton) {
          colorsButtons.forEach { (button) in
              UIView.animate(withDuration: 0.5, animations: {
                  button.isHidden = !button.isHidden
                  self.view.layoutIfNeeded()
              })
          }
      }
      
      enum Citys: String {
          case green = "Green"
          case yellow = "Orange"
          case red = "Purple"
          case blue = "Blue"
      }
      
    //city tapped
      @IBAction func colorsTapped(_ sender: UIButton) {
          guard let title = sender.currentTitle, let city = Citys(rawValue: title) else {
              return
          }
          
          switch city {
          case .green:
              
              self.selectedButton.setTitle("You select: Green", for: .normal)
            
            colorsButtons.forEach { (button) in
                         UIView.animate(withDuration: 0.5, animations: {
                             button.isHidden = true
                             self.view.layoutIfNeeded()
                         })
                     }
             
          case .yellow:
              
              self.selectedButton.setTitle("You select: Orange", for: .normal)
            
            colorsButtons.forEach { (button) in
                                    UIView.animate(withDuration: 0.5, animations: {
                                        button.isHidden = true
                                        self.view.layoutIfNeeded()
                                    })
                                }
         
          case .red:
             
              self.selectedButton.setTitle("You select: Purple", for: .normal)
            
            colorsButtons.forEach { (button) in
                                    UIView.animate(withDuration: 0.5, animations: {
                                        button.isHidden = true
                                        self.view.layoutIfNeeded()
                                    })
                                }
            
          case .blue:
            
             self.selectedButton.setTitle("You select: Blue", for: .normal)
            
            colorsButtons.forEach { (button) in
                UIView.animate(withDuration: 0.5, animations: {
                    button.isHidden = true
                    self.view.layoutIfNeeded()
                })
            }
              
          default:
              print("San fran")
              //self.selectedButton.setTitle("San Fransisco", for: .normal)
          }
          
      }

    @IBAction func onAddCategory(_ sender: Any) {
        
       
        addCategory()
        
      
        
    }
    
    func addCategory(){
      
       if (!(catName.text ?? "").isEmpty) {
        

            //generating a new key inside artists node
            //and also getting the generated key
            let key = refAddCategory.childByAutoId().key
          
            
          
                      
            //creating artist with the given values
            let category = [
                            "id":key,
                            "name":catName.text!,
                            "color":selectedButton.currentTitle!,
                            
                            
                          ]
        
            //adding the artist inside the generated unique key
            refAddCategory.child(key!).setValue(category)
            
            //displaying message
        let alert = UIAlertController(title: "SUCCESS", message: "New category added successfully.", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                                                 
                                                               

                  self.catName.text = ""
                self.errorLabel.alpha = 0
                                             

                                            }))
                                                                self.present(alert, animated: true, completion: nil)
                                            
            
        
        }
        
        
       else{
        
        self.errorLabel.alpha = 1
        self.errorLabel.text = "Category name cannot be empty! Please add a valid name."
        
        
        }
      
     
      
    }
    
    @objc func dismissKeyboard() {
                //Causes the view (or one of its embedded text fields) to resign the first responder status.
                view.endEditing(true)
            }
}
