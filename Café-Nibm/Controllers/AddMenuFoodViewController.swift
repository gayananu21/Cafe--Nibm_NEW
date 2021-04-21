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
import FirebaseStorage
import Lottie

class AddMenuFoodViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate   {
    
    
    @IBOutlet weak var eView: UIView!
       

    let lottieView = AnimationView()
    
    
    @IBOutlet weak var featuredImage: UIImageView!
    @IBOutlet weak var foodDescription: UITextView!
    @IBOutlet weak var foodDiscount: UITextField!
    @IBOutlet weak var foodPrice: UITextField!
    @IBOutlet weak var foodName: UITextField!
    var refFoodMenus: DatabaseReference!
      var refAddNewFood: DatabaseReference!
    
    var numberOfButtons = 0
    var buttonArray = [String]()
    
   

    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    
    
     private let storage = Storage.storage().reference()
    
    @IBOutlet weak var selectedButton: GradientView!
    
    
    @IBOutlet var cityButtons = [UIButton]()
    
    var fName = ""
    
    var isChecked = false
    
    
    
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
        
        self.foodName.addBottomBorderMenu()
        self.foodPrice.addBottomBorderMenu()
        self.foodDiscount.addBottomBorderMenu()
        
        configureStackView()
        
        self.foodName.text = self.fName
        
        
         refAddNewFood = Database.database().reference().child("Foods");
        
       

        //Looks for single or multiple taps.
             let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

                   //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
                   //tap.cancelsTouchesInView = false

             view.addGestureRecognizer(tap)
        
        
        
        
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

        
    }
    
    @objc func dismissKeyboard() {
                  //Causes the view (or one of its embedded text fields) to resign the first responder status.
                  view.endEditing(true)
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
    @IBAction func onCheckBoxTapped(_ sender: Any) {
        
        toggleCheckBoc()
    }
    
    func toggleCheckBoc(){
           self.isChecked = !isChecked
           
           if self.isChecked {
            let image = UIImage(named: "checkBox") as UIImage?
               
            
            self.checkboxButton.setImage(image, for: .normal)
           }
           
           else{
            
            let image = UIImage(named: "emptyCheckBox") as UIImage?
               
            
            self.checkboxButton.setImage(image, for: .normal)

            
       
            
               
           }
           
       }
    
    @IBAction func onAddFeaturedImage(_ sender: Any) {
        
        
        
        
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker,animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
            
            return
        }
        
        guard let imageData = image.pngData() else{
            return
        }
        
       
        
        storage.child("featured images/\(self.foodName.text ?? "")/featuredImage.jpg").putData(imageData, metadata: nil, completion: {_, error in
            guard error == nil else {
                print("Failed to upload")
                
                let alert = UIAlertController(title: "Error", message: "Failed to uplod new image!", preferredStyle: UIAlertController.Style.alert)

                                                                                                                                                 // add the actions (buttons)
                                                                                                                                                 alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                                                                                                                                 
                                                                                                                                                 // show the alert
                                                                                                                                                 self.present(alert, animated: true, completion: nil)
                return
            }
        })
        
        storage.child("featured images/\(self.foodName.text ?? "")/featuredImage.jpg").downloadURL(completion: {url, error in
            guard let url = url, error == nil else{
                return
                
            }
            let urlString = url.absoluteString
            
            DispatchQueue.main.async {
                
                           self.featuredImage.image = image
                // create the alert
                                                    let alert = UIAlertController(title: "Success", message: "Image uploaded successfully!", preferredStyle: UIAlertController.Style.alert)

                                                                // add the actions (buttons)
                                                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                                                                            
                                                                // show the alert
                                                        self.present(alert, animated: true, completion: nil)
                       }
            print("Download URL: \(urlString)")
            UserDefaults.standard.set(urlString, forKey: "url")
        })
    }
  
    
    
    
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
           
           picker.dismiss(animated: true, completion: nil)
       }
    
    override func viewWillAppear(_ animated: Bool) {
                  super.viewWillAppear(animated)
                  navigationController?.setNavigationBarHidden(true, animated: animated)
                  
                  
              }

              override func viewWillDisappear(_ animated: Bool) {
                  super.viewWillDisappear(animated)
                  navigationController?.setNavigationBarHidden(false, animated: animated)
                     
              }
       
    @IBAction func onAddNewItem(_ sender: Any) {
        
        if(self.foodName.text != "" && self.foodPrice.text != "" && self.foodDescription.text != "Add Food Description" && self.selectedButton.currentTitle != "Select Item Category") {
            
            if(self.isChecked == false){
                
                let alert = UIAlertController(title: "NOTICE", message: "Please confirm sell it as a item.", preferredStyle: UIAlertController.Style.alert)

                                           // add the actions (buttons)
                               alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                                                       
                                           // show the alert
                                   self.present(alert, animated: true, completion: nil)
                
            }
            else{
                
                guard let urlString = UserDefaults.standard.value(forKey: "url") as? String,
                                   let url = URL(string: urlString)   else {
                                      return
                                  }
                
                
                
                let key = refAddNewFood.childByAutoId().key
                
               
                
                
                //creating artist with the given values
                        let newFood = [
                                        "id":key,
                                        "name": foodName.text! as String,
                                        "price": foodPrice.text! as String,
                                        "discount": foodDiscount.text! as String,
                                        "description": foodDescription.text! as String,
                                        "type": selectedButton.currentTitle! as String,
                                        "availability": "on",
                                        "foodImage": urlString
                                        
                                      ]
                
                //adding the artist inside the generated unique key
                         refAddNewFood.child(key!).setValue(newFood)
                
                
               
            }
            
        }
        
        else{
            
            let alert = UIAlertController(title: "Error", message: "Please make sure all the fields are filled!", preferredStyle: UIAlertController.Style.alert)

                                                                        // add the actions (buttons)
                                                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                                                                                    
                                                                        // show the alert
                                                                self.present(alert, animated: true, completion: nil)
            
        }
        
        
        
        
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

extension UITextField {
    func addBottomBorderMenu(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: 1200, height: 1)
        bottomLine.backgroundColor = #colorLiteral(red: 0.002138899435, green: 0.7532717322, blue: 0.003318697221, alpha: 1)
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}
