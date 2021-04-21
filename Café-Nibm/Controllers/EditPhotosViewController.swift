//
//  EditPhotosViewController.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 3/29/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import UIKit
import Lottie
import FirebaseStorage
import Firebase
import Kingfisher
import FirebaseAuth


class EditPhotosViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var btnStatus = Int()
    
    private let storage = Storage.storage().reference()
    
     @IBOutlet weak var activityLoading: UIActivityIndicatorView!
    
     var NewpicArray = UIImageView()
    
      var imageArray = [String]()
    
    var editFoodName = ""
    
    
    
    var timer = Timer()
    var counter = 0
    
    @IBOutlet weak var sliderCollectionView: UICollectionView!
      
      @IBOutlet weak var pageView: UIPageControl!
    
    
    var refCollection: DatabaseReference!
   
    
    let user = Auth.auth().currentUser
    
    
    let storageDel = Storage.storage()
     
   
    
    let defaultImage = UIImage(systemName: "plus")
      
  
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
             self.label_01.text = "Add"
             self.label_02.text = "Add"
             self.label_03.text = "Add"
             self.label_04.text = "Add"
             self.label_05.text = "Add"
            
            
            
            guard let urlString = UserDefaults.standard.value(forKey: "url") as? String,
                             let url = URL(string: urlString)   else {
                                
                               
                                return
                            }
                 
                 let task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
                     guard let data = data, error == nil else{
                         return
                     }
                    
                     DispatchQueue.main.asyncAfter(deadline: .now()) {
                     
                         let image = UIImage(data: data)
                        self.addImage_01.setImage(image, for: .normal)
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
                                let image = UIImage(data: data)
                               self.addImage_02.setImage(image, for: .normal)
                            }
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
                                          let image = UIImage(data: data)
                                         self.addImage_03.setImage(image, for: .normal)
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
                                          let image = UIImage(data: data)
                                         self.addImage_04.setImage(image, for: .normal)
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
                                          let image = UIImage(data: data)
                                         self.addImage_05.setImage(image, for: .normal)
                                      }
                                  })
                                  task_05.resume()
            
            
           
            
            
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
                   
           
                          
                  
                   
                   storage.child("foodCollection/\(editFoodName)/image01.jpg").putData(imageData, metadata: nil, completion: {_, error in
                       guard error == nil else {
                           print("Failed to upload")
                           return
                       }
                   })
                   
                   storage.child("foodCollection/\(editFoodName)/image01.jpg").downloadURL(completion: {url, error in
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
                    let onSetImageUrl = setImageRef.child("FoodCollection/\(self.editFoodName)/Image_01/url")
                        
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
                   
        }
        
        
        if(self.btnStatus == 2){
            
              self.label_02.text = "Edit"
            
                   guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
                              
                              return
                          }
                          
                          guard let imageData = image.pngData() else{
                              return
                          }
                          
                        
                                 
                         
                          
                          storage.child("foodCollection/\(self.editFoodName)/image02.jpg").putData(imageData, metadata: nil, completion: {_, error in
                              guard error == nil else {
                                  print("Failed to upload")
                                  return
                              }
                          })
                          
                          storage.child("foodCollection/\(self.editFoodName)/image02.jpg").downloadURL(completion: {url, error in
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
                                let onSetImageUrl = setImageRef.child("FoodCollection/\(self.editFoodName)/Image_02/url")
                                
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
                          
               }
               
       
        if(self.btnStatus == 3){
              self.label_03.text = "Edit"
            
            guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
                       
                       return
                   }
                   
                   guard let imageData = image.pngData() else{
                       return
                   }
                   
                 
                          
                  
                   
                   storage.child("foodCollection/\(self.editFoodName)/image03.jpg").putData(imageData, metadata: nil, completion: {_, error in
                       guard error == nil else {
                           print("Failed to upload")
                           return
                       }
                   })
                   
                   storage.child("foodCollection/\(self.editFoodName)/image03.jpg").downloadURL(completion: {url, error in
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
                        let onSetImageUrl = setImageRef.child("FoodCollection/\(self.editFoodName)/Image_03/url")
                        
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
                   
        }
        
        
        if(self.btnStatus == 4){
            
              self.label_04.text = "Edit"
            
            guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
                       
                       return
                   }
                   
                   guard let imageData = image.pngData() else{
                       return
                   }
                   
                 
                          
                  
                   
                   storage.child("foodCollection/\(self.editFoodName)/image04.jpg").putData(imageData, metadata: nil, completion: {_, error in
                       guard error == nil else {
                           print("Failed to upload")
                           return
                       }
                   })
                   
                   storage.child("foodCollection/\(self.editFoodName)/image04.jpg").downloadURL(completion: {url, error in
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
                        let onSetImageUrl = setImageRef.child("FoodCollection/\(self.editFoodName)/Image_04/url")
                        
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
                   
        }
     
        if(self.btnStatus == 5){
            
              self.label_05.text = "Edit"
            
            guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
                       
                       return
                   }
                   
                   guard let imageData = image.pngData() else{
                       return
                   }
                   
                 
                          
                  
                   
                   storage.child("foodCollection/\(self.editFoodName)/image05.jpg").putData(imageData, metadata: nil, completion: {_, error in
                       guard error == nil else {
                           print("Failed to upload")
                           return
                       }
                   })
                   
                   storage.child("foodCollection/\(self.editFoodName)/image05.jpg").downloadURL(completion: {url, error in
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
                        let onSetImageUrl = setImageRef.child("FoodCollection/\(self.editFoodName)/Image_05/url")
                        
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
                   
        }
        
        
    }
    @IBAction func onChangeImage_01(_
        sender: Any) {
        
        self.btnStatus = 1
        
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
        
       /* let urlString = UserDefaults.standard.value(forKey: "url") as? String
        let storageRef = storageDel.reference(forURL: urlString!)
        

        //Removes image from storage
        storageRef.delete { error in
            if let error = error {
                print(error)
            } else {
                // File deleted successfully
            }
        }
*/
        
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
               navigationController?.setNavigationBarHidden(false, animated: animated)
               
               
           }

           override func viewWillDisappear(_ animated: Bool) {
               super.viewWillDisappear(animated)
               navigationController?.setNavigationBarHidden(false, animated: animated)
                  
           }
    

}

extension EditPhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          

            return 5
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell_01", for: indexPath)
            if let vc = cell.viewWithTag(222) as? UIImageView {
               
               

               //refCollection
               
               //getting a reference to the node artists
                     
                      //getting a reference to the node artists
               refCollection = Database.database().reference().child("FoodCollection").child("Burger");
                               
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

    extension EditPhotosViewController: UICollectionViewDelegateFlowLayout {
        
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
