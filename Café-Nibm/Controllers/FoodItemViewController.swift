//
//  FoodItemViewController.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 2/23/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher
import FirebaseAuth


class FoodItemViewController: UIViewController {
    
   var picArray: [UIImage] = []
    // Initialize Database, Auth, Storage
                
    @IBOutlet weak var activityLoading: UIActivityIndicatorView!
    
  var imageArray = [String]()
    
      var foodCount:Int = 1
    
    var NewpicArray = UIImageView()
    var MyPicArray = [UIImageView]()
    
    
    
    
    
    var refCollection: DatabaseReference!
    let user = Auth.auth().currentUser
    
    var fName = " "
    var fDescription = " "
    var fPrice = " "
    var foodKey = ""
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var foodDescription: RoundLabel!
    @IBOutlet weak var noFoods: UITextField!
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    
    @IBOutlet weak var pageView: UIPageControl!
    
    var refAddCart: DatabaseReference!
    
     var imageList = [CollectionModel]()
    
    var imgArrNew: [UIImage] = [
    
    ]
     
     
     var imgArr: [UIImage] = [
     
     
     ]
         
         var timer = Timer()
         var counter = 0
         
         override func viewDidLoad() {
             super.viewDidLoad()
            
            
            let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
            view.addSubview(navBar)

            let navItem = UINavigationItem(title: "SomeTitle")
            let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: "action")
            navItem.rightBarButtonItem = doneItem

            navBar.setItems([navItem], animated: false)
           
                   
                   // Points to the root reference
                   let storageRef = Storage.storage().reference()
            
           
            
            foodName.text = fName
            foodDescription.text = fDescription
            foodPrice.text = fPrice
            
    
            
            refAddCart = Database.database().reference().child("addCart/\(self.user?.uid ?? "")");
            
            
             pageView.numberOfPages = imgArr.count
             pageView.currentPage = 0
             DispatchQueue.main.async {
                 self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
                
                
                
                
             }
            
            //Looks for single or multiple taps.
                        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

                              //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
                              //tap.cancelsTouchesInView = false

                        view.addGestureRecognizer(tap)
            
            

         }
    override func viewWillAppear(_ animated: Bool) {
              super.viewWillAppear(animated)
              navigationController?.setNavigationBarHidden(false, animated: animated)
        
        
              
              
          }

          override func viewWillDisappear(_ animated: Bool) {
              super.viewWillDisappear(animated)
              navigationController?.setNavigationBarHidden(true, animated: animated)
          }
    
    
    
    
    
    @IBAction func plusItemsTapped(_ sender: Any) {
         
         self.foodCount = self.foodCount+1
          self.noFoods.text=String(self.foodCount)
     }
     
     @IBAction func minusItemsTapped(_ sender: Any) {

         self.foodCount=self.foodCount-1
          self.noFoods.text=String(self.foodCount)
         
         
     }
     
    
    
    
    @IBAction func addCartClick(_ sender: Any) {
        
        addArtist()
        
        UIView.animate(withDuration: 1, delay: 0.5, options: .transitionCrossDissolve, animations: {
              self.errorLabel.alpha = 0
          }, completion: nil)

    
    }
    
    
    
      func addArtist(){
        
        
        
        let foodP = Int(foodPrice.text!) ?? 0
        let foodNo = Int(noFoods.text!) ?? 0
        
        let total = foodP * foodNo
        
          //generating a new key inside artists node
          //and also getting the generated key
          let key = refAddCart.childByAutoId().key
        
          var currentDateTime = Date()

             let dateFormatter = DateFormatter()
             dateFormatter.timeStyle = .medium

        
                    
          //creating artist with the given values
          let artist = [
                          "id":key,
                          "foodName": foodName.text! as String,
                          "foodPrice": foodPrice.text! as String,
                          "noFoods": noFoods.text! as String,
                          "amount": String(total) as String,
                          "date": "\(dateFormatter.string(from: currentDateTime))"

                          
                        ]
      
          //adding the artist inside the generated unique key
          refAddCart.child(key!).setValue(artist)
          
          //displaying message
          errorLabel.alpha = 1
      }
    
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
         override func didReceiveMemoryWarning() {
             super.didReceiveMemoryWarning()
             // Dispose of any resources that can be recreated.
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

    @IBAction func onBackTap(_ sender: Any) {
        
        
    }
    @IBAction func onEditTap(_ sender: Any) {
        
        
    }
    @IBAction func onEditFoodItem(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                                        let VC1 = storyBoard.instantiateViewController(withIdentifier: "EDIT_MENU_FOOD") as! EditFoodItemViewController
                                   
                                   
        VC1.editFoodName = foodName.text ?? ""
        VC1.editDescription = foodDescription.text ?? ""
        VC1.editFoodPrice = foodPrice.text ?? ""
        VC1.editFoodKey = foodKey
        
        
                      
                      
                      
                      
                      

                                                          
                             
                             self.navigationController?.pushViewController(VC1, animated: true)
                      
        
        
    }
}

     extension FoodItemViewController: UICollectionViewDelegate, UICollectionViewDataSource {
         func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if(foodName.text == "Burger"){
                
                self.imgArr = [
                    UIImage(named:"f1")!,
                    UIImage(named:"f2")!,
                    UIImage(named:"f3")!,
                    UIImage(named:"f4")!,
                    UIImage(named:"f5")!,
                    UIImage(named:"f6")!
                    
                    ]
                
            }

             return 5
         }
         
         func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
             if let vc = cell.viewWithTag(111) as? UIImageView {
                
                

                //refCollection
                
                //getting a reference to the node artists
                      
                       //getting a reference to the node artists
                refCollection = Database.database().reference().child("FoodCollection").child("\(self.fName)");
                                
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

     extension FoodItemViewController: UICollectionViewDelegateFlowLayout {
         
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
