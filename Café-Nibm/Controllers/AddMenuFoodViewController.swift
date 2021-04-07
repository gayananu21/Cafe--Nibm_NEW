//
//  AddMenuFoodViewController.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 4/6/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher
import FirebaseAuth

class AddMenuFoodViewController: UIViewController {
    
    @IBOutlet weak var featuredImage: UIImageView!
    @IBOutlet weak var foodDescription: UITextView!
    @IBOutlet weak var foodDiscount: UITextField!
    @IBOutlet weak var foodPrice: UITextField!
    @IBOutlet weak var foodName: UITextField!
    var refFoodMenus: DatabaseReference!
    
    var numberOfButtons = 0
    var buttonArray = [String]()

    @IBOutlet weak var stackView: UIStackView!
    
    
    @IBOutlet weak var selectedButton: GradientView!
    
    
    @IBOutlet var cityButtons = [UIButton]()
    
    
    @IBAction func handleSelection(_ sender: UIButton) {
        
        cityButtons.forEach { (button) in
                 UIView.animate(withDuration: 0.5, animations: {
                     button.isHidden = !button.isHidden
                     self.view.layoutIfNeeded()
                 })
             }
    }
    
    
    
    @IBAction func onAddNewImages(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                                     let VC1 = storyBoard.instantiateViewController(withIdentifier: "ADD_NEW_IMAGES") as! AddNewCollectionImagesViewController
        
        
        if(self.foodName.text != ""){
            
            VC1.newMenuFood = foodName.text ?? ""
            VC1.foodPrice = foodPrice.text ?? ""
            VC1.discount = foodDiscount.text ?? ""
            VC1.foodDescription = foodDescription.text ?? ""
            VC1.featuredImage = featuredImage.image!
            
                   
            self.navigationController?.modalPresentationStyle = .none
            
                 
                    self.navigationController?.pushViewController(VC1, animated: true)
        }
        
        else{
            
            let alert = UIAlertController(title: "NOTICE", message: "Add a new food name before adding images!", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                                                           
                                                                    

                                                      }))
                                                                          self.present(alert, animated: true, completion: nil)
        }
                                
       
                                              
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureStackView()
        
       

        
    }
    
    func configureStackView(){
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        stackView.spacing = 0
        
        
        addButtonToStackView()
        
    }
    
    
    func addButtonToStackView() {
           
          
           
               
               
               //getting a reference to the node artists
                      refFoodMenus = Database.database().reference().child("FoodCategories");
               
               
                        
                        //observing the data changes
                             refFoodMenus.observe(DataEventType.value, with: { (snapshot) in
                                 
                                 //if the reference have some values
                                 if snapshot.childrenCount > 0 {
                                     
                                  
                                    
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
                                     
                 
                                           print(self.numberOfButtons)
                                       
                                       let button = SurveyButton()
                                
                                if(i % 2 == 0){
                                    button.backgroundColor = .lightGray
                                    
                                                }
                                                                   
                                else {
                                                                       
                                    button.backgroundColor = .lightGray
                                    button.alpha = 0.8
                                      }
                                                                   
                                       
                                
                                
                                                       button.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
                                   
                                       
                                     button.setTitle("\(self.buttonArray[i])", for: .normal)
                    
                                self.cityButtons.append(button)
                               
                                      // button.setTitle("\(self.buttonArray[4])", for: .normal)
                                 self.stackView.addArrangedSubview(button)
                                //self.cityButtons.append(button)
                               }
                             })
       
           
         }
    
    
    @objc func buttonAction(_ sender: UIButton) {
        
        
        guard let title = sender.currentTitle else {
                   return
               }
             
            
            
        
         self.selectedButton.setTitle("\(title ?? "")", for: .normal)
                        
      
        cityButtons.forEach { (button) in
                                UIView.animate(withDuration: 0.5, animations: {
                                    button.isHidden = true
                                    self.view.layoutIfNeeded()
                                })
                            }

             
         }
    
    
    
    @IBAction func onPreview(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HOME_TAB")
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
        
    }
    
    @IBAction func onCategory(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ADD_CAT_TAB")
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
        
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
