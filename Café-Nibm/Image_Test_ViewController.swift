


//
//  Image_Test_ViewController.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 3/6/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class Image_Test_ViewController: UIViewController {
  
    @IBOutlet weak var myImage: UIImageView!
    
        override func viewDidLoad() {
            super.viewDidLoad()
                       
          

      do {
        guard let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/iosp-488c9.appspot.com/o/images%2Fburger%2F3.jpg?alt=media&token=8ee70f70-17d7-4312-8404-c97a8f7290cc") else { return  }
          let data = try Data(contentsOf: url)
          self.myImage.image = UIImage(data: data)
      }
      catch{
          print(error)
      }
            
           
           
    }

}
