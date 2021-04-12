//
//  AdminAcountViewController.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 4/9/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//


import UIKit
import Firebase
import Lottie

class AdminAcountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var startText: UITextField!
    @IBOutlet weak var endText: UITextField!
    let datePicker = UIDatePicker()
    
    var total = Int()
    
    @IBOutlet weak var cartTableView: UITableView!
    
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    
    
    
    var refCarts: DatabaseReference!
    var refDates: DatabaseReference!
       
        var cartList = [AdminAccountModel]()
       
       
       public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
              return cartList.count
          }
          
        
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           
           
       
           return 100
           
       }
    
        
          
          public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
              
            
            
              
            
              //creating a cell using the custom class
              let cell = tableView.dequeueReusableCell(withIdentifier: "ACCOUNT_CELL", for: indexPath) as! AdminAccountTableViewCell
              
              
            
              
              //the artist object
              let cart: AdminAccountModel
           //getting the artist of selected position
                  cart = cartList[indexPath.row]
              
             
              //adding values to labels
          
              cell.orderId.text = cart.orderId
           cell.amount.text = cart.amount
            
            self.total += Int(cell.amount.text ?? "0") ?? 0
            
            self.totalAmount.text = String("Rs. \(self.total)")
          
              
              
              
              //returning cell
              return cell
          }
    
    func createDatePicker(){
        
        startText.textAlignment = .center
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        
        toolbar.setItems([doneBtn], animated: true)
        
        self.startText.inputAccessoryView = toolbar
        
        startText.inputView = datePicker
        
       
        
       
    }
    
    @objc func donePressed(){
           datePicker.datePickerMode = UIDatePicker.Mode.date
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "dd/MM/yyyy"
           let dateString = dateFormatter.string(from: datePicker.date)
           
           let toDate =  dateFormatter.date(from:dateString )!
           

        
          // let dateStringFix = dateFormatter.date(from: dateString)
           


        self.totalAmount.text = ""
        self.total = 0
           
           startText.text = dateString
           startLabel.text = dateString
           
           
           self.view.endEditing(true)
           
           //getting a reference to the node artists
                 refCarts = Database.database().reference().child("order history");
                                 
                                 //observing the data changes
                                     // refCarts.observe(DataEventType.value, with: { (snapshot) in
                                          
                // query_process.observe(.value, with: { snapshot in
                 let query_process = refCarts.queryOrdered(byChild: "date").queryEnding(atValue:"22/01/2021")
                                   //           query_process.observe(DataEventType.value, with: { (snapshot) in
                        
                        query_process.observe(DataEventType.value, with: { snapshot in
                     //query_process.ob
                                         
                                          //if the reference have some values
                                          if snapshot.childrenCount > 0 {
                                            
                                           
                                            
                                        
                                            
                                           
                                              //clearing the list
                                              self.cartList.removeAll()
                                             
                                            // self.animationView.alpha = 0
                                              //iterating through all the values
                                        for carts in snapshot.children.allObjects as! [DataSnapshot] {
                                                  //getting values
                                                  let cartObject = carts.value as? [String: AnyObject]
                                                 let orderId  = carts.key
                                                  let amount  = cartObject?["amount"]
                                                  let date = cartObject?["date"]
                                                 
                                               

                                                let isoDate = date
                                                let customDateStart = self.startText.text!
                                              let customDateEnd = self.endText.text!
                                            

                                            let dateFormatter = DateFormatter()
                                            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                                            dateFormatter.dateFormat = "dd-MM-yyyy"
                                        let Newdate = dateFormatter.date(from:isoDate as! String)!
                                                let CustomNewdateStart = dateFormatter.date(from:customDateStart)
                                            let CustomNewdateEnd = dateFormatter.date(from:customDateEnd)
                                                                                      
                                                if(Newdate > CustomNewdateStart! && Newdate < CustomNewdateEnd!){
                                                                                          
                                                                                          //creating artist object with model and fetched values
                                            let cart = AdminAccountModel(orderId: orderId as! String?, amount: amount as! String?,date: date as! String?)
                                                                                             
                                                                                          
                                                                                             //appending it to list
                                            self.cartList.append(cart)
                                                                                          
                                    self.cartTableView.reloadData()
                                                                                          
                                                                                      }
                                                                                     //self.total +=
                                                
                                                
                                              }
                                              
                                              //reloading the tableview
                                              self.cartTableView.reloadData()
                                          }
                                        
                                         
                                        
                                       
                                        
                                      })
           
          
           
           
           
       }
    
    func createDatePickerEnd(){
           
           endText.textAlignment = .center
           
           let toolbar = UIToolbar()
           toolbar.sizeToFit()
           
           let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedEnd))
           
           toolbar.setItems([doneBtn], animated: true)
           
           self.endText.inputAccessoryView = toolbar
           
           endText.inputView = datePicker
        
        
           
          
       }
    
    @objc func donePressedEnd(){
        datePicker.datePickerMode = UIDatePicker.Mode.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: datePicker.date)
        
     
        
        endText.text = dateString
        
         self.totalAmount.text = ""
        self.total = 0
        
        self.view.endEditing(true)
        
        //getting a reference to the node artists
                        refCarts = Database.database().reference().child("order history");
                                        
                                        //observing the data changes
                                            // refCarts.observe(DataEventType.value, with: { (snapshot) in
                                                 
                       // query_process.observe(.value, with: { snapshot in
                        let query_process = refCarts.queryOrdered(byChild: "date").queryEnding(atValue:"22/01/2021")
                                          //           query_process.observe(DataEventType.value, with: { (snapshot) in
                               
                               query_process.observe(DataEventType.value, with: { snapshot in
                            //query_process.ob
                                                
                                                 //if the reference have some values
                                                 if snapshot.childrenCount > 0 {
                                                   
                                                  
                                                   
                                               
                                                   
                                                  
                                                     //clearing the list
                                                     self.cartList.removeAll()
                                                    
                                                   // self.animationView.alpha = 0
                                                     //iterating through all the values
                                               for carts in snapshot.children.allObjects as! [DataSnapshot] {
                                                         //getting values
                                                         let cartObject = carts.value as? [String: AnyObject]
                                                        let orderId  = carts.key
                                                         let amount  = cartObject?["amount"]
                                                         let date = cartObject?["date"]
                                                        
                                                      

                                                       let isoDate = date
                                                       let customDateStart = self.startText.text!
                                                     let customDateEnd = self.endText.text!
                                                   

                                                   let dateFormatter = DateFormatter()
                                                   dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                                                   dateFormatter.dateFormat = "dd-MM-yyyy"
                                               let Newdate = dateFormatter.date(from:isoDate as! String)!
                                                       let CustomNewdateStart = dateFormatter.date(from:customDateStart)
                                                   let CustomNewdateEnd = dateFormatter.date(from:customDateEnd)
                                                                                             
                                                       if(Newdate > CustomNewdateStart! && Newdate < CustomNewdateEnd!){
                                                                                                 
                                                                                                 //creating artist object with model and fetched values
                                                   let cart = AdminAccountModel(orderId: orderId as! String?, amount: amount as! String?,date: date as! String?)
                                                                                                    
                                                                                                 
                                                                                                    //appending it to list
                                                   self.cartList.append(cart)
                                                                                                 
                                           self.cartTableView.reloadData()
                                                                                                 
                                                                                             }
                                                                                            //self.total +=
                                                       
                                                       
                                                     }
                                                     
                                                     //reloading the tableview
                                                     self.cartTableView.reloadData()
                                                 }
                                               
                                                
                                               
                                              
                                               
                                             })
       
        
        
        
    }
       
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd/MM/yyyy"
        let result = formatter.string(from: date)
        
        
        self.startText.text = result
        self.endText.text = result
        
        let toDate = formatter.date(from:result)
        
        createDatePicker()

        createDatePickerEnd()
       
        cartTableView.delegate = self
                      cartTableView.dataSource = self
                      
                      //getting a reference to the node artists
        refCarts = Database.database().reference().child("order history");
                        
                        //observing the data changes
                            // refCarts.observe(DataEventType.value, with: { (snapshot) in
                                 
       // query_process.observe(.value, with: { snapshot in
        let query_process = refCarts.queryOrdered(byChild: "date").queryEnding(atValue:"22/01/2021")
                   //           query_process.observe(DataEventType.value, with: { (snapshot) in
        
        query_process.observe(DataEventType.value, with: { snapshot in
            //query_process.ob
                                
                                 //if the reference have some values
                                 if snapshot.childrenCount > 0 {
                                   
                                  
                                   
                               
                                   
                                  
                                     //clearing the list
                                     self.cartList.removeAll()
                                    
                                   // self.animationView.alpha = 0
                                     //iterating through all the values
                                     for carts in snapshot.children.allObjects as! [DataSnapshot] {
                                         //getting values
                                         let cartObject = carts.value as? [String: AnyObject]
                                        let orderId  = carts.key
                                         let amount  = cartObject?["amount"]
                                         let date = cartObject?["date"]
                                        
                                        let isoDate = date
                                        let customDate = "01/05/2021"

                                        let dateFormatter = DateFormatter()
                                        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                                        dateFormatter.dateFormat = "dd-MM-yyyy"
                                        let Newdate = dateFormatter.date(from:isoDate as! String)!
                                        let CustomNewdate = dateFormatter.date(from:customDate)!
                                        
                                        if(Newdate > CustomNewdate){
                                            
                                            //creating artist object with model and fetched values
                                            let cart = AdminAccountModel(orderId: orderId as! String?, amount: amount as! String?,date: date as! String?)
                                               
                                            
                                               //appending it to list
                                               self.cartList.append(cart)
                                            
                                             self.cartTableView.reloadData()
                                            
                                        }
                                       //self.total += cartAmount as! Int
                                     
                                      
                                        
                                            
                                            
                                        
                                         
                                      
                                      
                                         
                                       
                                       
                                       
                                     }
                                     
                                     //reloading the tableview
                                     self.cartTableView.reloadData()
                                 }
                               
                                
                               
                              
                               
                             })
        
        
        
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
