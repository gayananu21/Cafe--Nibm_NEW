import UIKit

class Slide: UIView {

    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDesc: UITextView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var eView: UIView!
    
    @IBAction func loginClick(_ sender: Any) {
        
                labelTitle.textColor = .red
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let setViewController = mainStoryboard.instantiateViewController(withIdentifier: "LOGIN") as! LoginScreenViewController
        
        
        let rootViewController = self.window!.rootViewController
        let navController = UINavigationController(rootViewController: setViewController)
         navController.modalPresentationStyle = .fullScreen
        rootViewController?.present(navController, animated:true, completion: nil)
       
        //rootViewController?.present(setViewController, animated: true, completion: nil)
        
        

    }
}
