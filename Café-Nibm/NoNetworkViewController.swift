
//
//  NoNetworkViewController.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 3/22/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import UIKit
import Lottie

class NoNetworkViewController: UIViewController {

    

      @IBOutlet weak var eView: UIView!
      

    let lottieView = AnimationView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.lottieView.alpha = 1
                                        self.lottieView.animation = Animation.named("No_Network")
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
    
    @IBAction func onReferesh(_ sender: Any) {
        
        
        if NetworkMonitor.shared.isConnected == true {
            
            print("No network")
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                                             let VC1 = storyBoard.instantiateViewController(withIdentifier: "LOGIN") as! LoginScreenViewController
                                       
                           
                           
                           

                                                               
                                  
                                  self.navigationController?.pushViewController(VC1, animated: true)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
           
    }

}


