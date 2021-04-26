
//
//  EditFoodItemViewController.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 4/12/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//


import UIKit
import Firebase
import Kingfisher
import FirebaseAuth
import FirebaseStorage
import Lottie

class EditFoodItemViewController:UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate   {

    
    @IBOutlet weak var loadImage01: UIImageView!
    @IBOutlet weak var loadImage02: UIImageView!
    @IBOutlet weak var loadImage03: UIImageView!
    @IBOutlet weak var loadImage04: UIImageView!
    @IBOutlet weak var loadImage05: UIImageView!
    
    
    
    
    var editFoodName = ""
    var editFoodPrice = ""
    var Editdiscount = ""
    var editCategory = ""
    var editDescription = ""
     var editFoodKey = ""
    
    var defaultUrl = URL(string: "https://firebasestorage.googleapis.com/v0/b/iosp-488c9.appspot.com/o/foodCollection%2FDefault%20Images%2Ficon-image-512.png?alt=media&token=82c7f8f9-69da-4230-bc05-b477996a6866")
   
        @IBOutlet weak var eView: UIView!
           

           let lottieView = AnimationView()
        
        
        @IBOutlet weak var featuredImage: UIImageView!
        @IBOutlet weak var foodDescription: UITextView!
        @IBOutlet weak var foodDiscount: UITextField!
        @IBOutlet weak var foodPrice: UITextField!
        @IBOutlet weak var foodName: UITextField!
        var refFoodMenus: DatabaseReference!
          var refAddNewFood: DatabaseReference!
    
    var refEditFood: DatabaseReference!
        
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
                                                         let VC1 = storyBoard.instantiateViewController(withIdentifier: "EDIT_IMAGES") as! EditPhotosViewController
            
            
            if(self.foodName.text != ""){
                
                VC1.editFoodName = foodName.text ?? ""
                
                       
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
            
            
            self.foodName.addBottomBorderdit()
            self.foodPrice.addBottomBorderdit()
            self.foodDiscount.addBottomBorderdit()
            
            let keyId = editFoodKey
            refEditFood = Database.database().reference().child("Foods/\(keyId ?? "")");
            
            
            
            configureStackView()
            
            self.foodName.text = editFoodName
            self.foodPrice.text = editFoodPrice
            self.foodDescription.text = editDescription
            
            
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
            
            
            
            storage.child("foodCollection/\(self.editFoodName)/image01.jpg").downloadURL(completion: {url, error in
                                         let url = url
                let urlString = url?.absoluteString
                                     
                                     
                                         let setImageRef = Database.database().reference()
                                         let onSetImageUrl = setImageRef.child("FoodCollection/\(self.editFoodName)/Image_01/url")
                                         
                                         onSetImageUrl.setValue(urlString)
                                     
                                   
                
                
                
               // let defaultUrlString = self.defaultUrl?.absoluteString
                                                       
                                       
                
                                        UserDefaults.standard.set(urlString, forKey: "url_01")
                
            DispatchQueue.main.async {
                                           
                let task = URLSession.shared.dataTask(with: url ?? self.defaultUrl! , completionHandler: { data, _, error in
                                               guard let data = data, error == nil else{
                                                   return
                                               }
                                              
                                               DispatchQueue.main.asyncAfter(deadline: .now()) {
                                               
                                                  
                                                  self.loadImage01.image = UIImage(data: data)
                                               }
                                           })
                                           task.resume()
                
            }
                                    })

            
            storage.child("foodCollection/\(self.editFoodName)/image02.jpg").downloadURL(completion: {url, error in
                                         let url = url
                let urlString = url?.absoluteString
                                     
                                     
                                         let setImageRef = Database.database().reference()
                                         let onSetImageUrl = setImageRef.child("FoodCollection/\(self.editFoodName)/Image_02/url")
                                         
                                         onSetImageUrl.setValue(urlString)
                                     
                                                                 
                                                       
                                       
                                        UserDefaults.standard.set(urlString, forKey: "url_02")
                

                DispatchQueue.main.async {
                                               
                    let task = URLSession.shared.dataTask(with: url ?? self.defaultUrl! , completionHandler: { data, _, error in
                                                   guard let data = data, error == nil else{
                                                       return
                                                   }
                                                  
                                                   DispatchQueue.main.asyncAfter(deadline: .now()) {
                                                   
                                                      
                                                      self.loadImage02.image = UIImage(data: data)
                                                   }
                                               })
                                               task.resume()
                    
                }
                                    })
            
            storage.child("foodCollection/\(self.editFoodName)/image03.jpg").downloadURL(completion: {url, error in
                                         let url = url
                let urlString = url?.absoluteString
                                     
                                     
                                         let setImageRef = Database.database().reference()
                                         let onSetImageUrl = setImageRef.child("FoodCollection/\(self.editFoodName)/Image_03/url")
                                         
                                         onSetImageUrl.setValue(urlString)
                                     
                                                                 
                                                       
                                       
                                        UserDefaults.standard.set(urlString, forKey: "url_03")

                DispatchQueue.main.async {
                                               
                    let task = URLSession.shared.dataTask(with: url ?? self.defaultUrl! , completionHandler: { data, _, error in
                                                   guard let data = data, error == nil else{
                                                       return
                                                   }
                                                  
                                                   DispatchQueue.main.asyncAfter(deadline: .now()) {
                                                   
                                                      
                                                      self.loadImage03.image = UIImage(data: data)
                                                   }
                                               })
                                               task.resume()
                    
                }
                                    })

            
            storage.child("foodCollection/\(self.editFoodName)/image04.jpg").downloadURL(completion: {url, error in
                                         let url = url
                let urlString = url?.absoluteString
                                     
                                     
                                         let setImageRef = Database.database().reference()
                                         let onSetImageUrl = setImageRef.child("FoodCollection/\(self.editFoodName)/Image_04/url")
                                         
                                         onSetImageUrl.setValue(urlString)
                                     
                                                                 
                                                       
                                       
                                        UserDefaults.standard.set(urlString, forKey: "url_04")
                

                DispatchQueue.main.async {
                                               
                    let task = URLSession.shared.dataTask(with: url ?? self.defaultUrl! , completionHandler: { data, _, error in
                                                   guard let data = data, error == nil else{
                                                       return
                                                   }
                                                  
                                                   DispatchQueue.main.asyncAfter(deadline: .now()) {
                                                   
                                                      
                                                      self.loadImage04.image = UIImage(data: data)
                                                   }
                                               })
                                               task.resume()
                    
                }
                                    })
            
            storage.child("foodCollection/\(self.editFoodName)/image05.jpg").downloadURL(completion: {url, error in
                                         let url = url
                let urlString = url?.absoluteString
                                     
                                     
                                         let setImageRef = Database.database().reference()
                                         let onSetImageUrl = setImageRef.child("FoodCollection/\(self.editFoodName)/Image_05/url")
                                         
                                         onSetImageUrl.setValue(urlString)
                                     
                                                                 
                                                       
                                       
                                        UserDefaults.standard.set(urlString, forKey: "url_05")
                

                DispatchQueue.main.async {
                                               
                    let task = URLSession.shared.dataTask(with: url ?? self.defaultUrl! , completionHandler: { data, _, error in
                                                   guard let data = data, error == nil else{
                                                       return
                                                   }
                                                  
                                                   DispatchQueue.main.asyncAfter(deadline: .now()) {
                                                   
                                                      
                                                      self.loadImage05.image = UIImage(data: data)
                                                   }
                                               })
                                               task.resume()
                    
                }
                                    })
            
            
            guard let urlString = UserDefaults.standard.value(forKey: "url") as? String,
                                        let url = URL(string: urlString)   else {
                                           
                                          
                                           return
                                       }
                            
                            let task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
                                guard let data = data, error == nil else{
                                    return
                                }
                               
                                DispatchQueue.main.asyncAfter(deadline: .now()) {
                                
                                   
                                   self.loadImage01.image = UIImage(data: data)
                                }
                            })
                            task.resume()
                       
                       
                       guard let urlString_02 = UserDefaults.standard.value(forKey: "url_02") as? String,
                                               let url_02 = URL(string: urlString_02)   else {
                                                  return
                                              }
                                   
                                   let task_02 = URLSession.shared.dataTask(with: url_02, completionHandler: { data, _, error in
                                       guard let data = data, error == nil else{
                                           return
                                       }
                                      
                                       DispatchQueue.main.asyncAfter(deadline: .now()) {
                                      self.loadImage02.image = UIImage(data: data)                                       }
                                   })
                                   task_02.resume()
                       
                       
                       guard let urlString_03 = UserDefaults.standard.value(forKey: "url_03") as? String,
                                                         let url_03 = URL(string: urlString_03)   else {
                                                            return
                                                        }
                                             
                                             let task_03 = URLSession.shared.dataTask(with: url_03, completionHandler: { data, _, error in
                                                 guard let data = data, error == nil else{
                                                     return
                                                 }
                                                
                                                 DispatchQueue.main.asyncAfter(deadline: .now()) {
                                                       self.loadImage03.image = UIImage(data: data)
                                                 }
                                             })
                                             task_03.resume()
                       
                       guard let urlString_04 = UserDefaults.standard.value(forKey: "url_04") as? String,
                                                         let url_04 = URL(string: urlString_04)   else {
                                                            return
                                                        }
                                             
                                             let task_04 = URLSession.shared.dataTask(with: url_04, completionHandler: { data, _, error in
                                                 guard let data = data, error == nil else{
                                                     return
                                                 }
                                                
                                                 DispatchQueue.main.asyncAfter(deadline: .now()) {
                                                       self.loadImage04.image = UIImage(data: data)
                                                 }
                                             })
                                             task_04.resume()
                       
                       
                       guard let urlString_05 = UserDefaults.standard.value(forKey: "url_05") as? String,
                                                         let url_05 = URL(string: urlString_05)   else {
                                                            return
                                                        }
                                             
                                             let task_05 = URLSession.shared.dataTask(with: url_05, completionHandler: { data, _, error in
                                                 guard let data = data, error == nil else{
                                                     return
                                                 }
                                                
                                                 DispatchQueue.main.asyncAfter(deadline: .now()) {
                                                      self.loadImage05.image = UIImage(data: data)
                                                 }
                                             })
                                             task_05.resume()
            
            
            
            
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
        
    @IBAction func onBackTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Are you sure", message: "Are you sure you want to go back before finishing edit food item", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Home", style: UIAlertAction.Style.destructive, handler: { action in
                             
                             let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let vc = storyboard.instantiateViewController(withIdentifier: "HOME_TAB")
                                     vc.modalPresentationStyle = .fullScreen
                                    vc.modalTransitionStyle = .crossDissolve
                                    self.present(vc, animated: true)
                             
                            }))
        alert.addAction(UIAlertAction(title: "Cancel ", style: .default, handler: { action in

         

        }))
                            self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
        override func viewWillAppear(_ animated: Bool) {
                      super.viewWillAppear(animated)
                      navigationController?.setNavigationBarHidden(false, animated: animated)
                      
                      
                  }

                  override func viewWillDisappear(_ animated: Bool) {
                      super.viewWillDisappear(animated)
                      navigationController?.setNavigationBarHidden(false, animated: animated)
                         
                  }
           
        @IBAction func onSaveItem(_ sender: Any) {
            
            if(self.foodName.text != "" && self.foodPrice.text != "" && self.foodDescription.text != "Add Food Description" && self.selectedButton.currentTitle != "Select Item Category") {
                
                if(self.isChecked == false){
                    
                    let alert = UIAlertController(title: "NOTICE", message: "Please confirm sell it as a item.", preferredStyle: UIAlertController.Style.alert)

                                               // add the actions (buttons)
                                   alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                                                           
                                               // show the alert
                                       self.present(alert, animated: true, completion: nil)
                    
                }
                else{
                    
                    let key = editFoodKey
                                       
                                       
                                                          let alert = UIAlertController(title: "Key", message: "Key: \(key)", preferredStyle: UIAlertController.Style.alert)

                                                                      // add the actions (buttons)
                                                          alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                                                                                  
                                                                      // show the alert
                                                              self.present(alert, animated: true, completion: nil)
                   
                    
                    
                   
                   
                    
                    //creating artist with the given values
                            let newFood = [
                                            
                                            "name": foodName.text! as String,
                                            "price": foodPrice.text! as String,
                                            "discount": foodDiscount.text! as String,
                                            "description": foodDescription.text! as String,
                                            "type": selectedButton.currentTitle! as String,
                                        
                                           // "foodImage": urlString
                                            
                                          ]
                    
                    let refUp = Database.database().reference()
                               
                               
                               let updateStatus = refUp.child("Foods/\(key)")
                               //updateStatus.updateChildValues(["status": "preparing"])
                    
                    //adding the artist inside the generated unique key
                    updateStatus.updateChildValues(["name": foodName.text! as String, "price": foodPrice.text! as String, "discount": foodDiscount.text! as String, "description": foodDescription.text! as String, "type": selectedButton.currentTitle! as String])
                    
                   
                    
                   
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
        
      
    }

extension UITextField {
    func addBottomBorderdit(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: 1200, height: 1)
        bottomLine.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        borderStyle = .none
        
        layer.addSublayer(bottomLine)
    }
}


