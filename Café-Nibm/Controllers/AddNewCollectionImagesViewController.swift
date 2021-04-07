//
//  AddNewCollectionImagesViewController.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 4/7/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import UIKit
import Lottie
import FirebaseStorage
import Firebase
import Kingfisher
import FirebaseAuth


class AddNewCollectionImagesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var addImage_05: UIButton!
    @IBOutlet weak var addImage_01: UIButton!
    @IBOutlet weak var addImage_04: UIButton!
    
    @IBOutlet weak var addImage_03: UIButton!
    @IBOutlet weak var addImage_02: UIButton!
    
    
    @IBOutlet weak var label_01: UILabel!
    @IBOutlet weak var label_02: UILabel!
    @IBOutlet weak var label_03: UILabel!
    @IBOutlet weak var label_04: UILabel!
    @IBOutlet weak var label_05: UILabel!
    
    var newMenuFood = ""
    var foodPrice = ""
    var discount = ""
    var category = ""
    var foodDescription = ""
    var featuredImage = UIImage()
    
    
    
        var refRemoveImage: DatabaseReference!
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var btnStatus = Int()
    
    private let storage = Storage.storage().reference()
    
     @IBOutlet weak var activityLoading: UIActivityIndicatorView!
    
     var NewpicArray = UIImageView()
    
      var imageArray = [String]()
    
    
    
    
    
    var timer = Timer()
    var counter = 0
    
    @IBOutlet weak var sliderCollectionView: UICollectionView!
      
      @IBOutlet weak var pageView: UIPageControl!
    
    
    var refCollection: DatabaseReference!
   
    
    let user = Auth.auth().currentUser
    
    
    let storageDel = Storage.storage()
     
   
    
    let defaultImage = UIImage(systemName: "plus")
      
    @IBAction func onBackTapped(_ sender: Any) {
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                                           let VC1 = storyBoard.instantiateViewController(withIdentifier: "ADD_MENU_FOOD") as! AddMenuFoodViewController
              
              
        
        if(self.newMenuFood != nil){
            
             VC1.foodName.text = self.newMenuFood
        }
        
                  
                
                          VC1.modalPresentationStyle = .fullScreen
                         VC1.modalTransitionStyle = .crossDissolve
                         self.present(VC1, animated: true)
              
        
    }
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
           
            

            
             self.label_01.text = "Add"
             self.label_02.text = "Add"
             self.label_03.text = "Add"
             self.label_04.text = "Add"
             self.label_05.text = "Add"
            
           

            
            
            
           
            
            
            pageView.numberOfPages = 5
                        pageView.currentPage = 1
                        DispatchQueue.main.async {
                            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
                           
                           
                           
                           
                        }
                       
            
        }

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }

    @objc func changeImage() {
          
          if counter < 5 {
              let index = IndexPath.init(item: counter, section: 0)
              self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
              pageView.currentPage = counter
              counter += 1
          } else {
              counter = 0
              let index = IndexPath.init(item: counter, section: 0)
              self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
              pageView.currentPage = counter
              counter = 1
          }
              
          }
        
      
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        picker.dismiss(animated: true, completion: nil)
        
        
       
            
        
        
        if(self.btnStatus == 1){
              self.label_01.text = "Edit"
            
            guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
                       
                       return
                   }
                   
                   guard let imageData = image.pngData() else{
                       return
                   }
                   
           
                          
                  
                   
                   storage.child("foodCollection/\(self.newMenuFood)/image01.jpg").putData(imageData, metadata: nil, completion: {_, error in
                       guard error == nil else {
                           print("Failed to upload")
                           return
                       }
                    
                    self.storage.child("foodCollection/\(self.newMenuFood)/image01.jpg").downloadURL(completion: {url, error in
                                          guard let url = url, error == nil else{
                                           
                                           let alert = UIAlertController(title: "Error", message: "Failed to uplod new image!", preferredStyle: UIAlertController.Style.alert)

                                                                                                         // add the actions (buttons)
                                                                                                         alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                                                                                         
                                                                                                         // show the alert
                                                                                                         self.present(alert, animated: true, completion: nil)
                                                                    self.addImage_01.setImage(image, for: .normal)
                                           
                                              return
                                              
                                          }
                                           let urlString = url.absoluteString
                                         
                                           let setImageRef = Database.database().reference()
                                           let onSetImageUrl = setImageRef.child("FoodCollection/\(self.newMenuFood)/Image_01/url")
                                           
                                           onSetImageUrl.setValue(urlString)
                                       
                                        DispatchQueue.main.async {
                                          
                                       self.sliderCollectionView.reloadData()
                                       
                                       }
                                       
                                          DispatchQueue.main.async {
                                           
                                           
                                              
                                           // create the alert
                                                     let alert = UIAlertController(title: "Success", message: "Image uploaded successfully!", preferredStyle: UIAlertController.Style.alert)

                                                     // add the actions (buttons)
                                                     alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                                     
                                                     // show the alert
                                                     self.present(alert, animated: true, completion: nil)
                                           
                                           self.addImage_01.setImage(image, for: .normal)
                                           }
                                       
                                          print("Download URL: \(urlString)")
                                          UserDefaults.standard.set(urlString, forKey: "url")
                                       
                                      
                                      })
                   })
                   
                  
                   
        }
        
        
        if(self.btnStatus == 2){
            
              self.label_02.text = "Edit"
            
                   guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
                              
                              return
                          }
                          
                          guard let imageData = image.pngData() else{
                              return
                          }
                          
                        
                                 
                         
                          
                          storage.child("foodCollection/\(self.newMenuFood)/image02.jpg").putData(imageData, metadata: nil, completion: {_, error in
                              guard error == nil else {
                                  print("Failed to upload")
                                  return
                              }
                            
                            self.storage.child("foodCollection/\(self.newMenuFood)/image02.jpg").downloadURL(completion: {url, error in
                                                         guard let url = url, error == nil else{
                                                       let alert = UIAlertController(title: "Error", message: "Failed to uplod new image!", preferredStyle: UIAlertController.Style.alert)

                                                                                                                                                 // add the actions (buttons)
                                                                                                                                                 alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                                                                                                                                 
                                                                                                                                                 // show the alert
                                                                                                                                                 self.present(alert, animated: true, completion: nil)
                                                                                                            self.addImage_01.setImage(image, for: .normal)
                                                                                   
                                                                                      return
                                                                                      
                                                                                  }
                                                                                  let urlString = url.absoluteString
                                                       

                                                           let setImageRef = Database.database().reference()
                                                           let onSetImageUrl = setImageRef.child("FoodCollection/\(self.newMenuFood)/Image_02/url")
                                                           
                                                           onSetImageUrl.setValue(urlString)
                                                       
                                                                                  
                                                                                  DispatchQueue.main.async {
                                                                                      
                                                                                   // create the alert
                                                                                             let alert = UIAlertController(title: "Success", message: "Image uploaded successfully!", preferredStyle: UIAlertController.Style.alert)

                                                                                             // add the actions (buttons)
                                                                                             alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                                                                             
                                                                                             // show the alert
                                                                                             self.present(alert, animated: true, completion: nil)
                                                             
                                                             self.addImage_02.setImage(image, for: .normal)
                                                                    }
                                                       
                                                      
                                                         print("Download URL: \(urlString)")
                                                         UserDefaults.standard.set(urlString, forKey: "url_02")
                                                     })
                          })
                          
                         
                          
               }
               
       
        if(self.btnStatus == 3){
              self.label_03.text = "Edit"
            
            guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
                       
                       return
                   }
                   
                   guard let imageData = image.pngData() else{
                       return
                   }
                   
                 
                          
                  
                   
                   storage.child("foodCollection/\(self.newMenuFood)/image03.jpg").putData(imageData, metadata: nil, completion: {_, error in
                       guard error == nil else {
                           print("Failed to upload")
                           return
                       }
                    
                    self.storage.child("foodCollection/\(self.newMenuFood)/image03.jpg").downloadURL(completion: {url, error in
                        guard let url = url, error == nil else{
                             let alert = UIAlertController(title: "Error", message: "Failed to uplod new image!", preferredStyle: UIAlertController.Style.alert)

                                                                                                                // add the actions (buttons)
                                                                                                                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                                                                                                
                                                                                                                // show the alert
                                                                                                                self.present(alert, animated: true, completion: nil)
                                                                           self.addImage_01.setImage(image, for: .normal)
                                                  
                                                     return
                                                     
                                                 }
                                                 let urlString = url.absoluteString
                     
                     
                         let setImageRef = Database.database().reference()
                         let onSetImageUrl = setImageRef.child("FoodCollection/\(self.newMenuFood)/Image_03/url")
                         
                         onSetImageUrl.setValue(urlString)
                     
                                                 
                                                 DispatchQueue.main.async {
                                                     
                                                  // create the alert
                                                            let alert = UIAlertController(title: "Success", message: "Image uploaded successfully!", preferredStyle: UIAlertController.Style.alert)

                                                            // add the actions (buttons)
                                                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                                            
                                                            // show the alert
                                                            self.present(alert, animated: true, completion: nil)
                            
                            self.addImage_03.setImage(image, for: .normal)
                                   }
                        print("Download URL: \(urlString)")
                        UserDefaults.standard.set(urlString, forKey: "url_03")
                    })
                   })
                   
                   
                   
        }
        
        
        if(self.btnStatus == 4){
            
              self.label_04.text = "Edit"
            
            guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
                       
                       return
                   }
                   
                   guard let imageData = image.pngData() else{
                       return
                   }
                   
                 
                          
                  
                   
                   storage.child("foodCollection/\(self.newMenuFood)/image04.jpg").putData(imageData, metadata: nil, completion: {_, error in
                       guard error == nil else {
                           print("Failed to upload")
                           return
                       }
                    
                    self.storage.child("foodCollection/\(self.newMenuFood)/image04.jpg").downloadURL(completion: {url, error in
                                          guard let url = url, error == nil else{
                                               let alert = UIAlertController(title: "Error", message: "Failed to uplod new image!", preferredStyle: UIAlertController.Style.alert)

                                                                                                                                  // add the actions (buttons)
                                                                                                                                  alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                                                                                                                  
                                                                                                                                  // show the alert
                                                                                                                                  self.present(alert, animated: true, completion: nil)
                                                                                             self.addImage_01.setImage(image, for: .normal)
                                                                    
                                                                       return
                                                                       
                                                                   }
                                                                   let urlString = url.absoluteString
                                       
                                           let setImageRef = Database.database().reference()
                                           let onSetImageUrl = setImageRef.child("FoodCollection/\(self.newMenuFood)/Image_04/url")
                                           
                                           onSetImageUrl.setValue(urlString)
                                       
                                                                   
                                                                   DispatchQueue.main.async {
                                                                       
                                                                    // create the alert
                                                                              let alert = UIAlertController(title: "Success", message: "Image uploaded successfully!", preferredStyle: UIAlertController.Style.alert)

                                                                              // add the actions (buttons)
                                                                              alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                                                              
                                                                              // show the alert
                                                                              self.present(alert, animated: true, completion: nil)
                                              self.addImage_04.setImage(image, for: .normal)
                                                     }
                                          print("Download URL: \(urlString)")
                                          UserDefaults.standard.set(urlString, forKey: "url_04")
                                      })
                   })
                   
                  
                   
        }
     
        if(self.btnStatus == 5){
            
              self.label_05.text = "Edit"
            
            guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
                       
                       return
                   }
                   
                   guard let imageData = image.pngData() else{
                       return
                   }
                   
                 
                          
                  
                   
                   storage.child("foodCollection/\(self.newMenuFood)/image05.jpg").putData(imageData, metadata: nil, completion: {_, error in
                       guard error == nil else {
                           print("Failed to upload")
                           return
                       }
                    
                    self.storage.child("foodCollection/\(self.newMenuFood)/image05.jpg").downloadURL(completion: {url, error in
                                          guard let url = url, error == nil else{
                                              let alert = UIAlertController(title: "Error", message: "Failed to uplod new image!", preferredStyle: UIAlertController.Style.alert)

                                                                                                                                  // add the actions (buttons)
                                                                                                                                  alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                                                                                                                  
                                                                                                                                  // show the alert
                                                                                                                                  self.present(alert, animated: true, completion: nil)
                                                                                             self.addImage_01.setImage(image, for: .normal)
                                                                    
                                                                       return
                                                                       
                                                                   }
                                                                   let urlString = url.absoluteString
                                       
                                       
                                           let setImageRef = Database.database().reference()
                                           let onSetImageUrl = setImageRef.child("FoodCollection/\(self.newMenuFood)/Image_05/url")
                                           
                                           onSetImageUrl.setValue(urlString)
                                       
                                                                   
                                                                   DispatchQueue.main.async {
                                                                       
                                                                    // create the alert
                                                                              let alert = UIAlertController(title: "Success", message: "Image uploaded successfully!", preferredStyle: UIAlertController.Style.alert)

                                                                              // add the actions (buttons)
                                                                              alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                                                              
                                                                              // show the alert
                                                                              self.present(alert, animated: true, completion: nil)
                                              
                                              self.addImage_05.setImage(image, for: .normal)
                                                     }
                                          print("Download URL: \(urlString)")
                                          UserDefaults.standard.set(urlString, forKey: "url_05")
                                      })
                                      
                   })
                   
                  
        
            
        }
        
       
                
        
    }
    
     
          
    
    @IBAction func onChangeImage_01(_
        sender: Any) {
        
        self.btnStatus = 1
        
        if( self.newMenuFood != "") {
        }
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker,animated: true)

        
        
        
    }
    
    
    @IBAction func onChangeImage_02(_
           sender: Any) {
        
         self.btnStatus = 2
           
           let picker = UIImagePickerController()
           picker.sourceType = .photoLibrary
           picker.delegate = self
           picker.allowsEditing = true
           present(picker,animated: true)

      
           
           
       }
    
    
    @IBAction func onChangeImage_03(_
              sender: Any) {
           
            self.btnStatus = 3
              
              let picker = UIImagePickerController()
              picker.sourceType = .photoLibrary
              picker.delegate = self
              picker.allowsEditing = true
              present(picker,animated: true)

              
              
              
          }
    
    @IBAction func onChangeImage_04(_
              sender: Any) {
           
            self.btnStatus = 4
              
              let picker = UIImagePickerController()
              picker.sourceType = .photoLibrary
              picker.delegate = self
              picker.allowsEditing = true
              present(picker,animated: true)

              
              
              
          }
    
    
    @IBAction func onChangeImage_05(_
              sender: Any) {
           
            self.btnStatus = 5
              
              let picker = UIImagePickerController()
              picker.sourceType = .photoLibrary
              picker.delegate = self
              picker.allowsEditing = true
              present(picker,animated: true)

              
              
              
          }
    
    @IBAction func onDeleteImage_01(_ sender: Any) {
        
    
              
        
        // create the alert
               let alert = UIAlertController(title: "Delete?", message: "Are you sure you want to delete image?", preferredStyle: UIAlertController.Style.alert)

               // add the actions (buttons)
               alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: { action in

                  let urlString = UserDefaults.standard.value(forKey: "url") as? String
                let storageRef = self.storageDel.reference(forURL: urlString!)
                  

                  //Removes image from storage
                  storageRef.delete { error in
                      if let error = error {
                          print(error)
                      } else {
                          // File deleted successfully
                        DispatchQueue.main.async {
                        
                        self.addImage_01.setImage(self.defaultImage, for: .normal)
                        self.label_01.text = "Add"
                               }
                        
                      }
                  }
                
                
                Database.database().reference().child("FoodCollection/\(self.newMenuFood )/Image_01").child("url").removeValue()
               }))
        
               alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
             
               // show the alert
               self.present(alert, animated: true, completion: nil)
       
        
    }
    
    @IBAction func onDeleteImage_02(_ sender: Any) {
        
        
            
        // create the alert
               let alert = UIAlertController(title: "Delete?", message: "Are you sure you want to delete image?", preferredStyle: UIAlertController.Style.alert)

               // add the actions (buttons)
               alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: { action in

                  let urlString = UserDefaults.standard.value(forKey: "url_02") as? String
                let storageRef = self.storageDel.reference(forURL: urlString!)
                  

                  //Removes image from storage
                  storageRef.delete { error in
                      if let error = error {
                          print(error)
                      } else {
                          // File deleted successfully
                        DispatchQueue.main.async {
                        
                        self.addImage_02.setImage(self.defaultImage, for: .normal)
                        self.label_02.text = "Add"
                               }
                        
                      }
                  }
                
                 Database.database().reference().child("FoodCollection/\(self.newMenuFood )/Image_02").child("url").removeValue()

               }))
        
               alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
             
               // show the alert
               self.present(alert, animated: true, completion: nil)
      
        
    }
    
    @IBAction func onDeleteImage_03(_ sender: Any) {
     
        
        // create the alert
               let alert = UIAlertController(title: "Delete?", message: "Are you sure you want to delete image?", preferredStyle: UIAlertController.Style.alert)

               // add the actions (buttons)
               alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: { action in

                  let urlString = UserDefaults.standard.value(forKey: "url_03") as? String
                let storageRef = self.storageDel.reference(forURL: urlString!)
                  

                  //Removes image from storage
                  storageRef.delete { error in
                      if let error = error {
                          print(error)
                      } else {
                          // File deleted successfully
                        DispatchQueue.main.async {
                        
                        self.addImage_03.setImage(self.defaultImage, for: .normal)
                        self.label_03.text = "Add"
                               }
                        
                      }
                  }
                
                 Database.database().reference().child("FoodCollection/\(self.newMenuFood )/Image_03").child("url").removeValue()

               }))
        
               alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
             
               // show the alert
               self.present(alert, animated: true, completion: nil)
            
     
    }
    
    @IBAction func onDeleteImage_04(_ sender: Any) {
        
      
        // create the alert
               let alert = UIAlertController(title: "Delete?", message: "Are you sure you want to delete image?", preferredStyle: UIAlertController.Style.alert)

               // add the actions (buttons)
               alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: { action in

                  let urlString = UserDefaults.standard.value(forKey: "url_04") as? String
                let storageRef = self.storageDel.reference(forURL: urlString!)
                  

                  //Removes image from storage
                  storageRef.delete { error in
                      if let error = error {
                          print(error)
                      } else {
                          // File deleted successfully
                        DispatchQueue.main.async {
                        
                        self.addImage_04.setImage(self.defaultImage, for: .normal)
                        self.label_04.text = "Add"
                               }
                        
                      }
                  }
                
                 Database.database().reference().child("FoodCollection/\(self.newMenuFood )/Image_04").child("url").removeValue()

               }))
        
               alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
             
               // show the alert
               self.present(alert, animated: true, completion: nil)
            
        
    }
    
    @IBAction func onDeleteImage_05(_ sender: Any) {
        
      
        // create the alert
               let alert = UIAlertController(title: "Delete?", message: "Are you sure you want to delete image?", preferredStyle: UIAlertController.Style.alert)

               // add the actions (buttons)
               alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: { action in

                  let urlString = UserDefaults.standard.value(forKey: "url_05") as? String
                let storageRef = self.storageDel.reference(forURL: urlString!)
                  

                  //Removes image from storage
                  storageRef.delete { error in
                      if let error = error {
                          print(error)
                      } else {
                          // File deleted successfully
                        DispatchQueue.main.async {
                        
                        self.addImage_05.setImage(self.defaultImage, for: .normal)
                        self.label_05.text = "Add"
                               }
                        
                      }
                  }
                
                 Database.database().reference().child("FoodCollection/\(self.newMenuFood )/Image_05").child("url").removeValue()

               }))
        
               alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
             
               // show the alert
               self.present(alert, animated: true, completion: nil)
            
       
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
    

}

extension AddNewCollectionImagesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          

            return 5
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell_01", for: indexPath)
            if let vc = cell.viewWithTag(222) as? UIImageView {
               
               

               //refCollection
               
               //getting a reference to the node artists
                     
                      //getting a reference to the node artists
                refCollection = Database.database().reference().child("FoodCollection").child(self.newMenuFood);
                               
                               //observing the data changes
                                    refCollection.observe(DataEventType.value, with: { (snapshot) in
                                 
                                 //if the reference have some values
                                 if snapshot.childrenCount > 0 {
                                     
                                     //clearing the list
                                     
                                   
                                   //vc.image = imgArr[indexPath.row]
                                     
                                     //iterating through all the values
                                     for Foods in snapshot.children.allObjects as! [DataSnapshot] {
                                         //getting values
                                         let foodObject = Foods.value as? [String: AnyObject]
                                         let imageUrl  = foodObject?["url"]
                                         
                                       self.imageArray.append(imageUrl as! String)

                                       self.NewpicArray.kf.indicatorType = .activity
                                       self.NewpicArray.kf.setImage(with: URL(string:String(self.imageArray[indexPath.row] )), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)

                                       
                                     
                                        if(vc.image == nil){
                                          self.activityLoading.startAnimating()
                                          self.activityLoading.alpha = 1
                                            self.pageView.alpha = 0
                                                            }
                                        else{
                                                                                   
                                           self.activityLoading.stopAnimating()
                                           self.activityLoading.alpha = 0
                                            self.pageView.alpha = 1
                                                                                  
                                            }
                                      
                                     }
                                   
                                     
                                     
                                 }
                                
                             })
                
                
                
               
               
               vc.image =  self.NewpicArray.image

               
               
            }
            return cell
        }
    }

    extension AddNewCollectionImagesViewController: UICollectionViewDelegateFlowLayout {
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let size = sliderCollectionView.frame.size
            return CGSize(width: size.width, height: size.height)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0.0
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0.0
        }
    }
