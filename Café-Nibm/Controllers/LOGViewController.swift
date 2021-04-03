

//
//  LOGViewController.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 3/7/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LOGViewController: UIViewController {

    let user = Auth.auth().currentUser
    
     var ref: DatabaseReference!
    
    @IBOutlet weak var noFoods: UITextField!
    @IBOutlet weak var foodName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
       
        // Do any additional setup after loading the view.
    }
    @IBAction func addClicked(_ sender: Any) {
        
        //creating artist with the given values
                let artist = [
                                                               
                                "foodName": foodName.text! as String,
                                "noFoods": noFoods.text! as String,
                                
                              ]
        
        ref = Database.database().reference().child("TestOrder/\(self.user?.uid ?? "")");

            
                //adding the artist inside the generated unique key
                ref.setValue(artist)
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
