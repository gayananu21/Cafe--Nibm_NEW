import UIKit
import Lottie


class OnboardingViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
       
    
    
    
    let lottieView = AnimationView()
    let lottieView1 = AnimationView()
    let lottieView2 = AnimationView()
    let lottieView3 = AnimationView()
 
    
    var slides:[Slide] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(!appDelegate.hasAlreadyLaunched){
            
            slides = createSlides()
            setupSlideScrollView(slides: slides)
            
        }
        
        else{
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                              let VC1 = storyBoard.instantiateViewController(withIdentifier: "LOGIN") as! LoginScreenViewController
                         
            
                   self.navigationController?.pushViewController(VC1, animated: true)
            

            
        }
        
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func createSlides() -> [Slide] {

        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
       // slide1.imageView.image = UIImage(named: "ic_onboarding_1")
        slide1.labelTitle.text = "WELCOME"
        slide1.labelDesc.text = "Welcome to Nibm Cafe where you'll find everything you want to eat! Your presence is our motivation to do better! Our heartiest welcome goes to you."
        slide1.loginButton.alpha = 0
        
        
        self.lottieView.alpha = 1
                                   self.lottieView.animation = Animation.named("Res")
                                   //let lottieView = AnimationView(animation: loadingAnimation)
                                       // 2. SECOND STEP (Adding and setup):
        slide1.eView.addSubview(self.lottieView)
                                   self.lottieView.contentMode = .scaleAspectFit
                                   self.lottieView.loopMode = .autoReverse
                                   self.lottieView.play(toFrame: .infinity)
                                   
                                   
                                   
                                       // 3. THIRD STEP (LAYOUT PREFERENCES):
                                   self.lottieView.translatesAutoresizingMaskIntoConstraints = false
                                       NSLayoutConstraint.activate([
                                           self.lottieView.leftAnchor.constraint(equalTo: slide1.eView.leftAnchor),
                                           self.lottieView.rightAnchor.constraint(equalTo: slide1.eView.rightAnchor),
                                           self.lottieView.topAnchor.constraint(equalTo: slide1.eView.topAnchor),
                                           self.lottieView.bottomAnchor.constraint(equalTo: slide1.eView.bottomAnchor)
                                       ])
                                   
        
        
        
        
        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
       // slide2.imageView.image = UIImage(named: "ic_onboarding_2")
        slide2.labelTitle.text = "FIND FOOD YOU LOVE"
        slide2.labelTitle.textColor = .orange
        slide2.labelDesc.text = "First, we eat. Then, we do everything else. People who love to eat are always the best people."
        slide2.loginButton.alpha = 0
        
        self.lottieView1.alpha = 1
                                   self.lottieView1.animation = Animation.named("Food")
                                   //let lottieView = AnimationView(animation: loadingAnimation)
                                       // 2. SECOND STEP (Adding and setup):
        slide2.eView.addSubview(self.lottieView1)
                                   self.lottieView1.contentMode = .scaleAspectFit
                                   self.lottieView1.loopMode = .autoReverse
                                   self.lottieView1.play(toFrame: .infinity)
                                   
                                   
                                   
                                       // 3. THIRD STEP (LAYOUT PREFERENCES):
                                   self.lottieView1.translatesAutoresizingMaskIntoConstraints = false
                                       NSLayoutConstraint.activate([
                                           self.lottieView1.leftAnchor.constraint(equalTo: slide2.eView.leftAnchor),
                                           self.lottieView1.rightAnchor.constraint(equalTo: slide2.eView.rightAnchor),
                                           self.lottieView1.topAnchor.constraint(equalTo: slide2.eView.topAnchor),
                                           self.lottieView1.bottomAnchor.constraint(equalTo: slide2.eView.bottomAnchor)
                                       ])
        
        
        
        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
       // slide3.imageView.image = UIImage(named: "ic_onboarding_3")
        slide3.labelTitle.text = "PLACE YOUR ORDER"
        slide3.labelTitle.textColor = .systemPurple
        slide3.labelDesc.text = "You are one step away. Hurry up and place your order. We will notify you soon when foods are ready."
        slide3.loginButton.alpha = 0
        
        self.lottieView2.alpha = 1
                                   self.lottieView2.animation = Animation.named("mob")
                                   //let lottieView = AnimationView(animation: loadingAnimation)
                                       // 2. SECOND STEP (Adding and setup):
        slide3.eView.addSubview(self.lottieView2)
                                   self.lottieView2.contentMode = .scaleAspectFit
                                   self.lottieView2.loopMode = .autoReverse
                                   self.lottieView2.play(toFrame: .infinity)
                                   
                                   
                                   
                                       // 3. THIRD STEP (LAYOUT PREFERENCES):
                                   self.lottieView2.translatesAutoresizingMaskIntoConstraints = false
                                       NSLayoutConstraint.activate([
                                           self.lottieView2.leftAnchor.constraint(equalTo: slide3.eView.leftAnchor),
                                           self.lottieView2.rightAnchor.constraint(equalTo: slide3.eView.rightAnchor),
                                           self.lottieView2.topAnchor.constraint(equalTo: slide3.eView.topAnchor),
                                           self.lottieView2.bottomAnchor.constraint(equalTo: slide3.eView.bottomAnchor)
                                       ])
       
        
        let slide4:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
       // slide4.imageView.image = UIImage(named: "ic_onboarding_4")
        slide4.labelTitle.text = "JOIN WITH US"
        slide4.labelTitle.textColor = .brown
        slide4.labelDesc.text = "We have best receipes for any food. Join with us taste best food for best price."
        slide4.loginButton.alpha = 1
       
        
        self.lottieView3.alpha = 1
                                   self.lottieView3.animation = Animation.named("Log")
                                   //let lottieView = AnimationView(animation: loadingAnimation)
                                       // 2. SECOND STEP (Adding and setup):
        slide4.eView.addSubview(self.lottieView3)
                                   self.lottieView3.contentMode = .scaleAspectFit
                                   self.lottieView3.loopMode = .autoReverse
                                   self.lottieView3.play(toFrame: .infinity)
                                   
                                   
                                   
                                       // 3. THIRD STEP (LAYOUT PREFERENCES):
                                   self.lottieView3.translatesAutoresizingMaskIntoConstraints = false
                                       NSLayoutConstraint.activate([
                                           self.lottieView3.leftAnchor.constraint(equalTo: slide4.eView.leftAnchor),
                                           self.lottieView3.rightAnchor.constraint(equalTo: slide4.eView.rightAnchor),
                                           self.lottieView3.topAnchor.constraint(equalTo: slide4.eView.topAnchor),
                                           self.lottieView3.bottomAnchor.constraint(equalTo: slide4.eView.bottomAnchor)
                                       ])
        
      
        
       
        
        return [slide1, slide2, slide3, slide4]
    }
    
    
    func setupSlideScrollView(slides : [Slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    
    /*
     * default function called when view is scolled. In order to enable callback
     * when scrollview is scrolled, the below code needs to be called:
     * slideScrollView.delegate = self or
     */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        
        // vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        
        
        /*
         * below code changes the background color of view on paging the scrollview
         */
//        self.scrollView(scrollView, didScrollToPercentageOffset: percentageHorizontalOffset)
        
    
        /*
         * below code scales the imageview on paging the scrollview
         */
        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
        
        if(percentOffset.x > 0 && percentOffset.x <= 0.25) {
            
            slides[0].eView.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
            slides[1].eView.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
            
        } else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
            slides[1].eView.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.25, y: (0.50-percentOffset.x)/0.25)
            slides[2].eView.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)
            
        } else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
            slides[2].eView.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
            slides[3].eView.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)
            
        } 
    }
    
    
    
    
    func scrollView(_ scrollView: UIScrollView, didScrollToPercentageOffset percentageHorizontalOffset: CGFloat) {
        if(pageControl.currentPage == 0) {
            //Change background color to toRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1
            //Change pageControl selected color to toRed: 103/255, toGreen: 58/255, toBlue: 183/255, fromAlpha: 0.2
            //Change pageControl unselected color to toRed: 255/255, toGreen: 255/255, toBlue: 255/255, fromAlpha: 1
            
            let pageUnselectedColor: UIColor = fade(fromRed: 255/255, fromGreen: 255/255, fromBlue: 255/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            pageControl.pageIndicatorTintColor = pageUnselectedColor
        
            
            let bgColor: UIColor = fade(fromRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1, toRed: 255/255, toGreen: 255/255, toBlue: 255/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            slides[pageControl.currentPage].backgroundColor = bgColor
            
            let pageSelectedColor: UIColor = fade(fromRed: 81/255, fromGreen: 36/255, fromBlue: 152/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            pageControl.currentPageIndicatorTintColor = pageSelectedColor
        }
    }
    
    
    func fade(fromRed: CGFloat,
              fromGreen: CGFloat,
              fromBlue: CGFloat,
              fromAlpha: CGFloat,
              toRed: CGFloat,
              toGreen: CGFloat,
              toBlue: CGFloat,
              toAlpha: CGFloat,
              withPercentage percentage: CGFloat) -> UIColor {
        
        let red: CGFloat = (toRed - fromRed) * percentage + fromRed
        let green: CGFloat = (toGreen - fromGreen) * percentage + fromGreen
        let blue: CGFloat = (toBlue - fromBlue) * percentage + fromBlue
        let alpha: CGFloat = (toAlpha - fromAlpha) * percentage + fromAlpha
        
        // return the fade colour
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
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

