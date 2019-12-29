//
//  ViewController.swift
//  Wasatta
//
//  Created by Said Abdulla on 10/8/18.
//  Copyright © 2018 Said Abdulla. All rights reserved.
//

import UIKit
import Shades
import Alamofire
import SwiftyJSON
import SVProgressHUD
import Toast_Swift
import SVProgressHUD
import FacebookCore
import FacebookLogin
import FBSDKLoginKit
import GoogleSignIn
import Localize_Swift






class SignInViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
 
    
    
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    

    

    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var Hellolbl: UILabel!
    @IBOutlet weak var Hellosub: UILabel!
    @IBOutlet weak var btn_signin: UIButton!
    @IBOutlet weak var btn_skip: UIButton!
    @IBOutlet weak var facebook: UIButton!
    @IBOutlet weak var google: UIButton!
    @IBOutlet weak var signup: UIButton!






    var parameters:[String:String] = [:]
    var Gparameters:[String:String] = [:]

    var fbname:String?
    var fbid:String?
    var fbemail:String?
    
    var Gname:String?
    var Gid:String?
    var Gemail:String?
    var lang: String?
    var fblogin: String?
    var GoogleLogin: String?

    
    
    var accessToken: String?

    @IBOutlet weak var googleButton: AZSocialButton!
    
    @IBOutlet weak var facebookButton: AZSocialButton!
    let languageVC = TestLocaVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        languageVC.getCurrentSelectedLang()

       // getDeviceLanguage()

        if UserDefaults.standard.string(forKey: "access_token") != nil{
            DispatchQueue.main.async
                {
                    self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
                    self.navigationController?.popToRootViewController(animated: false)


                    let homePage = self.storyboard?.instantiateViewController(withIdentifier: "initialVC")

                    self.appDelegate.window?.rootViewController = homePage
            }

        }
        
        self.setText()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: NSNotification.Name( LCLLanguageChangeNotification), object: nil)
    }
    
    // Remove the LCLLanguageChangeNotification on viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func setText(){
        btn_signin.setTitle("Sign in".localized(using: "ButtonTitles"), for: UIControl.State.normal)
        btn_skip.setTitle("Skip".localized(using: "ButtonTitles"), for: UIControl.State.normal)
        facebook.setTitle("Sign in with Facebook".localized(using: "ButtonTitles"), for: UIControl.State.normal)
        google.setTitle("Sign in with Google".localized(using: "ButtonTitles"), for: UIControl.State.normal)
        signup.setTitle("Sign up to continue".localized(using: "ButtonTitles"), for: UIControl.State.normal)

        Hellolbl.text = "Hello".localized();
        Hellosub.text = "Sign in to continue".localized();
        Username.placeholder = "Email Address".localized();
        Password.placeholder = "Password".localized();



    }
    
    
    func getDeviceLanguage(){
        
        let DeviceLang = Locale.preferredLanguages[0]
        let languageArr = DeviceLang.components(separatedBy: "-")
        self.lang = languageArr.first!
        
        
        if languageArr.first == "en"{
            lang  = "en"
            print("my language is \(lang)")
        }
        
        if languageArr.first == "ar"{
            lang  = "ar"
            print("my language is \(lang)")
           // UIView.appearance().semanticContentAttribute = .forceRightToLeft

        }
        
        if languageArr.first == "fr"{
            lang  = "fr"
            print("my language is \(lang)")
        }
        
        if languageArr.first == "es"{
            lang  = "es"
            print("my language is \(lang)")
        }
        
        if languageArr.first == "ru"{
            lang  = "ru"
            print("my language is \(lang)")
        }
        
        if languageArr.first == "tr"{
            lang  = "tr"
            print("my language is \(lang)")
        }
        
        if languageArr.first == "de"{
            lang  = "de"
            print("my language is \(lang)")
        }
            
        else if languageArr.first != "ar" && languageArr.first != "en"
            && languageArr.first != "fr" && languageArr.first != "es" && languageArr.first != "tr" && languageArr.first != "de" && languageArr.first != "ru"{
            lang = "ar"
        }
    }
    
    @IBAction func facebookBtnTapped(_ sender: Any) {
        
        print("hello")
        getFacebookUserInfo()
      

    }
    
    
   
    
    
    func getFacebookUserInfo(){
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile, .email], viewController: self) { (result) in
//        loginManager.logIn([.publicProfile, .email ], viewController: self) { (result) in
            switch result{
            case .cancelled:
                print("Cancel button click")
            case .success:
                self.fblogin = FBSDKAccessToken.current().tokenString
                UserDefaults.standard.set(self.fblogin, forKey: "fblogin")

                self.postFBLogin()

              
            default:
                print("??")
            }
        }
    }
    
    
   
    
    func postFBLogin(){
        
        
        
        let params = ["fields" : "id, name, email "]
      
        
        let connection = GraphRequestConnection()
        connection.add(GraphRequest(graphPath: "/me", parameters: params)) { httpResponse, result in
            switch result {
            case .success(let response):
                print("Custom Graph Request Succeeded: \(response)")
                self.fbname = response.dictionaryValue?["name"] as! String
                self.fbid = response.dictionaryValue?["id"] as! String
                self.fbemail = response.dictionaryValue?["email"] as! String
                
                
                self.parameters["password"] = "\(response.dictionaryValue?["id"] ?? "")"
                self.parameters["username"] = "\(response.dictionaryValue?["email"] ?? "")"

                
                self.parameters["grant_type"] = "password"
                
               
                //Send HTTP Request to perform Sign in
                let myUrl = URL(string: "https://www.wasataa.com/token")
                var request = URLRequest(url:myUrl!)
                
                request.httpMethod = "POST"// Compose a query string
                let httpHeader = ["Content-Type": "application/x-www-form-urlencoded", "Accept": "application/json"]
                
                print("paraaaaaa \(self.parameters)")
                
                SVProgressHUD.show()
                
                
                Alamofire.request(myUrl!, method: HTTPMethod.post, parameters: self.parameters, headers: httpHeader).responseJSON { (data) in
                    
                    print("paraaaaaa \(self.parameters)")

                    
                    if let dictonry = data.value as? NSDictionary {
                        
                        if let AccessToken = dictonry["access_token"] as? String{
                            
                            self.view.makeToast("thank you")
                            self.accessToken = "bearer " + AccessToken
                            print("User Access Token is: \(self.accessToken)")
                            UserDefaults.standard.set(self.accessToken, forKey: "access_token")
                            
                            
                            
                            DispatchQueue.main.async
                                {
                                    
                                    let homePage = self.storyboard?.instantiateViewController(withIdentifier: "initialVC")
                                    
                                    self.appDelegate.window?.rootViewController = homePage
                            }
                            
                        }
                        
                        if let error = dictonry["error"] as? String{
                            
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "sign_up") as? SignUpViewController
                            vc?.name = self.fbname!
                            vc?.password = self.fbid!
                            vc?.email = self.fbemail!


                            self.appDelegate.window?.rootViewController = vc

                        
                          
                            
                        }
                        
                        
                        
                    }else{
                        
                        self.view.makeToast("Network error")
                        
                    }
                    
                    SVProgressHUD.dismiss()
                    
                    
                    
                    
                    
                }
                
                
            case .failed(let error):
                print("Graph Request Failed: \(error)")
                
                
            }
        }
        connection.start()
        
        
       
    }
    
   
    @IBAction func skipTapped(_ sender: Any) {

        DispatchQueue.main.async
            {
          self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
                                    self.navigationController?.popToRootViewController(animated: false)
                
                                    let homePage = self.storyboard?.instantiateViewController(withIdentifier: "initialVC")
                
                                    self.appDelegate.window?.rootViewController = homePage
        }
        
    }
    
    @IBAction func googleBtnTapped(_ sender: Any) {
        
        print("Google Sign in Tapped")
        
        GIDSignIn.sharedInstance().delegate=self
        GIDSignIn.sharedInstance().uiDelegate=self
        GIDSignIn.sharedInstance().signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            
            self.GoogleLogin = GIDSignIn.sharedInstance().currentUser.authentication.accessToken
            UserDefaults.standard.set(self.GoogleLogin, forKey: "Googlelogin")

            print("Google Access Token\(accessToken)")

            
            self.Gname = user.profile.name
            self.Gid = user.userID
            self.Gemail = user.profile.email
            
            self.Gparameters["password"] = user.userID
            self.Gparameters["username"] = user.profile.email
            
            
            self.Gparameters["grant_type"] = "password"
            
            
            //Send HTTP Request to perform Sign in
            let myUrl = URL(string: "https://www.wasataa.com/token")
            var request = URLRequest(url:myUrl!)
            
            request.httpMethod = "POST"// Compose a query string
            let httpHeader = ["Content-Type": "application/x-www-form-urlencoded", "Accept": "application/json"]
            
            print("paraaaaaa \(self.Gparameters)")
            
            SVProgressHUD.show()
            
            
            Alamofire.request(myUrl!, method: HTTPMethod.post, parameters: self.Gparameters, headers: httpHeader).responseJSON { (data) in
                
                print("paraaaaaa \(self.Gparameters)")
                
                
                if let dictonry = data.value as? NSDictionary {
                    
                    if let AccessToken = dictonry["access_token"] as? String{
                        
                        self.view.makeToast("thank you")
                        self.accessToken = "bearer " + AccessToken
                        print("User Access Token is: \(self.accessToken)")
                        UserDefaults.standard.set(self.accessToken, forKey: "access_token")
                        
                        
                        
                        DispatchQueue.main.async
                            {
                                
                                let homePage = self.storyboard?.instantiateViewController(withIdentifier: "initialVC")
                                
                                self.appDelegate.window?.rootViewController = homePage
                        }
                        
                    }
                    
                    if let error = dictonry["error"] as? String{
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "sign_up") as? SignUpViewController
                        vc?.name = self.Gname!
                        vc?.password = self.Gid!
                        vc?.email = self.Gemail!
                        
                        
                        self.appDelegate.window?.rootViewController = vc
                        
                        
                        
                        
                    }
                    
                    
                    
                }else{
                    
                    self.view.makeToast("Network error")
                    
                }
                
                SVProgressHUD.dismiss()

            // ...
        }
    }
    }
    
    
   
    
    

    @IBAction func SignInButtonTapped(_ sender: Any) {
        
        print("tapped")
        
       
        postLogin()

        
      
        
        
        }
    
    
    
    func postLogin(){
        
        // Read values from text fields
        let userName = Username.text
        let userPassword = Password.text
        
        // Check if required fields are not empty
        if (userName?.isEmpty)! || (userPassword?.isEmpty)!
        {
            // Display alert message here
            print("User name \(String(describing: userName)) or password \(String(describing: userPassword)) is empty")
            self.view.makeToast("One of the required fields is missing")
            
            return
        }
        
        //Send HTTP Request to perform Sign in
        let myUrl = URL(string: "https://www.wasataa.com/token")
        var request = URLRequest(url:myUrl!)
        
        request.httpMethod = "POST"// Compose a query string
        let httpHeader = ["Content-Type": "application/x-www-form-urlencoded",
                          "Accept": "application/json"]
        let parameters:[String:String] = ["grant_type": "password","username": userName!, "password": userPassword!]
        
        print("parameters\(parameters)")
        
        var style = ToastStyle()
        
        // this is just one of many style options
        style.backgroundColor = .brown
        SVProgressHUD.show()
        
        
        Alamofire.request(myUrl!, method: HTTPMethod.post, parameters: parameters, headers: httpHeader).responseJSON { (data) in
            
            if let dictonry = data.value as? NSDictionary {
                
                if let AccessToken = dictonry["access_token"] as? String{
                    
                    self.view.makeToast("thank you")
                    self.accessToken = "bearer " + AccessToken
                    print("User Access Token is: \(self.accessToken)")
                    UserDefaults.standard.set(self.accessToken, forKey: "access_token")
                    
                    
                    
                    DispatchQueue.main.async
                        {
                            
                            let homePage = self.storyboard?.instantiateViewController(withIdentifier: "initialVC")
                            
                            //                            let appDelegate = UIApplication.shared.delegate
                            self.appDelegate.window?.rootViewController = homePage
                    }
                    
                }
                
                if let error = dictonry["error"] as? String{
                    self.view.makeToast("Provided username and password is incorrect")
                    
                }
                
                
                
            }else{
                
                self.view.makeToast("Network error")
                
            }
            
            SVProgressHUD.dismiss()
            
            
            
            
            
        }
    }

    
    
    @IBAction func registerNewAccountButtonTapped(_ sender: Any) {
        print("Register account button tapped")
        
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "sign_up") as! SignUpViewController
        
        self.present(registerViewController, animated: true)
        
        
        
        
    }
    
    
    

    
    
}
extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
