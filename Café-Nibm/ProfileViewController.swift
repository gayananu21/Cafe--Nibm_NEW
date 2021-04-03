//
//  ProfileViewController.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 2/25/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import Lottie

class ProfileViewController: UIViewController, UITableViewDelegate , UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate   {
    
    private let storage = Storage.storage().reference()
   
    @IBOutlet weak var nameLabel: UILabel!
    

    @IBOutlet weak var eView: UIView!
    

  let lottieView = AnimationView()
    
    
    var recentOrderNoRef = ""
    
      var orderNumber = ""
  
    @IBOutlet weak var changeImageButton: UIButton!
    
  
    
    @IBOutlet weak var doneEditButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var topTableView: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    var topData : [String] = []
    var downData = [String]()
    
    
     var refProfileRecent: DatabaseReference!
    var refProfileRecent1: DatabaseReference!
    let user = Auth.auth().currentUser
    
    //list to store all the artist
     var recentOrderList = [ProfileRecentModel]()
    //list to store all the artist
      var recentOrderList1 = [ProfileRecentModel1]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.lottieView.alpha = 1
                                  self.lottieView.animation = Animation.named("Star")
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
                self.profileImage.image = image
            }
        })
        task.resume()
     
        
        
        profileImage.layer.borderWidth = 0.5
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.systemBlue.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        profileImage.alpha = 1
        
        
        topTableView.delegate = self
        
        topTableView.dataSource = self
        
       //getting a reference to the node artists
       refProfileRecent = Database.database().reference().child("myOrder/\(self.user?.uid ?? "")");
      
         
         //observing the data changes
              refProfileRecent.observe(DataEventType.value, with: { (snapshot) in
                  
                  //if the reference have some values
                  if snapshot.childrenCount > 0 {
                    
                   
                      
                      //iterating through all the values
                      for recentOrders in snapshot.children.allObjects as! [DataSnapshot] {
                          //getting values
                          let recentOrderObject = recentOrders.value as? [String: AnyObject]
                          let totalAmount  = recentOrderObject?["total"]
                          let date = recentOrderObject?["date"]
                        let recentOrderNo =  String(recentOrders.key)
                     
                                                     
                                                        
                        print("key::::::\(recentOrderNo)");
                        
                        self.refProfileRecent1 = Database.database().reference().child("myOrder/\(self.user?.uid ?? "")/\(self.recentOrderNoRef)/\(self.recentOrderNoRef)");
                                                       
                                                        
                       
                          //creating artist object with model and fetched values
                        let recentOrder = ProfileRecentModel(date: date as! String?, totalAmount: totalAmount as! String?, recentOrderNo: recentOrderNo as! String?)
                          
                          //appending it to list
                          self.recentOrderList.append(recentOrder)
                       
                       
                       //observing the data changes
                       self.refProfileRecent1.observe(DataEventType.value, with: { (snapshot1) in
                           
                           //if the reference have some values
                           if snapshot1.childrenCount > 0 {
                               
                                self.recentOrderList1.removeAll()
                               
                               //iterating through all the values
                               for recentOrders1 in snapshot1.children.allObjects as! [DataSnapshot] {
                               
                                   let recentOrderObject1 = recentOrders1.value as? [String: AnyObject]
                               let foodName  = recentOrderObject1?["foodName"]
                                let noItems = recentOrderObject1?["noFoods"]
                                
                               
                                let itemPrice  = recentOrderObject1?["foodPrice"]
                                
                                   
                                   
                                   let recentOrder1 = ProfileRecentModel1(foodName: foodName as! String?, noItems: noItems as! String?, itemPrice: itemPrice as! String?)
                                                          
                                                          //appending it to list
                                                          self.recentOrderList1.append(recentOrder1)
                                   
                                   
                               }
                               //reloading the tableview
                               self.topTableView.reloadData()
                           }
                           
                       })
               
                      
                      }
                      
                      //reloading the tableview
                      self.topTableView.reloadData()
                  }
              })
        
        
        
        
       
        
        for index in 0...20 {
            topData.append("Top Table Row \(index)")
        }
        
        for index in 10...45 {
            downData.append("Down Table Row \(index)")
        }

        
      
    }
    
    
 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
            
            return
        }
        
        guard let imageData = image.pngData() else{
            return
        }
        
       
        
        storage.child("profile/proImage.jpg").putData(imageData, metadata: nil, completion: {_, error in
            guard error == nil else {
                print("Failed to upload")
                return
            }
        })
        
        storage.child("profile/proImage.jpg").downloadURL(completion: {url, error in
            guard let url = url, error == nil else{
                return
                
            }
            let urlString = url.absoluteString
            
            DispatchQueue.main.async {
                
                           self.profileImage.image = image
                       }
            print("Download URL: \(urlString)")
            UserDefaults.standard.set(urlString, forKey: "url")
        })
    }
    @IBAction func onChangeImage(_
        sender: Any) {
        
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker,animated: true)

        
        
        
    }
    
    
    
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
           
           picker.dismiss(animated: true, completion: nil)
       }
    
    @IBAction func editProfile(_ sender: Any) {
        

        
          self.nameTextField.text = self.nameLabel.text
          self.phoneTextField.text = self.phoneLabel.text
        
        
        self.nameLabel.alpha = 0
        self.phoneLabel.alpha = 0
        
        self.nameTextField.alpha = 1
        self.phoneTextField.alpha = 1
        
        self.editButton.alpha = 0
        self.doneEditButton.alpha = 1
        
        self.changeImageButton.alpha = 1
    }
    
    @IBAction func doneEditProfile(_ sender: Any) {
        
        self.view.endEditing(true)


    
        
        self.nameLabel.text = self.nameTextField.text
        self.phoneLabel.text = self.phoneTextField.text
        
        
        self.nameLabel.alpha = 1
        self.phoneLabel.alpha = 1
        
        self.nameTextField.alpha = 0
        self.phoneTextField.alpha = 0
        
        self.doneEditButton.alpha = 0
        self.editButton.alpha = 1
        
         self.changeImageButton.alpha = 0
        
    }
    
    @objc func dismissKeyboard() {
                  //Causes the view (or one of its embedded text fields) to resign the first responder status.
                  view.endEditing(true)
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
              navigationController?.setNavigationBarHidden(false, animated: animated)
          }
        
      public func numberOfSections(in tableView: UITableView) -> Int {
            
            
        
                return 1

        }
        
       public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("you tap on \(indexPath.row)")
            
            
      
            
            if(indexPath.row == indexPath.row){
                
                if(tableView.tag == 10){
                        
                          let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                                            let VC1 = storyBoard.instantiateViewController(withIdentifier: "order") as! Order_History_Detail_ViewController1
                                       //the artist object
                                                    let food: ProfileRecentModel
                                                    
                                                    //getting the artist of selected position
                                                    food = recentOrderList[indexPath.row]
                                       
                VC1.order_histrory_No = food.recentOrderNo ?? ""
                                                       
                          
                    

                                                              
                                 
                                 self.navigationController?.pushViewController(VC1, animated: true)
                
                }
        }
            
        
        
            
        
        
    }
        

        
        
       public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            var numberOfRow = 1
             
                   
                           if(tableView.tag == 10){
                               
                              numberOfRow = recentOrderList.count
                            return numberOfRow
                            
                           }
                           
                           
                           if(tableView.tag == 20){
                                         
                                          numberOfRow = recentOrderList1.count
                                                                  return numberOfRow
                                     }
                           
                           return numberOfRow
        }
        
     public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         
        var heightCell = 1
        
        if(tableView.tag == 10){
            heightCell = 200
            return CGFloat(heightCell)
        }
        
        if(tableView.tag == 20){
            heightCell = 45
            return CGFloat(heightCell)
        }
        return CGFloat(heightCell)

     }
        
       public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var cell = UITableViewCell()
         
            
            if (tableView.tag == 10){
                
               //creating a cell using the custom class
                let cell = tableView.dequeueReusableCell(withIdentifier: "PRO_1", for: indexPath) as! ProfileUITableViewCell
                
                //the artist object
                let order: ProfileRecentModel
                
                //getting the artist of selected position
                order = recentOrderList[indexPath.row]
                
                //adding values to labels
               // cell.dateTime.text = order.date
               // cell.totalAmount.text = order.totalAmount
                cell.orderNumber.text = order.recentOrderNo
                
                recentOrderNoRef = order.recentOrderNo ?? ""
                
                //returning cell
                return cell
            }
        
            if (tableView.tag == 20){
                
                //creating a cell using the custom class
                 let cell = tableView.dequeueReusableCell(withIdentifier: "PRO_2", for: indexPath) as! Profile_1_TableViewCell
                 
                 //the artist object
                 let order: ProfileRecentModel1
                 
                 //getting the artist of selected position
                 order = recentOrderList1[indexPath.row]
                 
                 //adding values to labels
                // cell.foodName.text = order.foodName
               //  cell.noItems.text = order.noItems
                 //cell.itemPrice.text = order.itemPrice
                 
                 //returning cell
                 return cell

            }
            
            return cell

        

    }
    

}
