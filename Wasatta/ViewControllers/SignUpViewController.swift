//
//  SignUpViewController.swift
//  Wasatta
//
//  Created by Said Abdulla on 10/24/18.
//  Copyright © 2018 Said Abdulla. All rights reserved.
//

import UIKit
import FlagPhoneNumber
import Alamofire
import SVProgressHUD
import Toast_Swift
import Localize_Swift

class SignUpViewController: UIViewController {

    @IBOutlet weak var PhoneView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var uesrnameTextField: UITextField!
    @IBOutlet weak var EmailAddressTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var createaccount: UILabel!
    @IBOutlet weak var createaccountsup: UILabel!
    @IBOutlet weak var signup_btn: UIButton!
    @IBOutlet weak var skip_btn: UIButton!
    @IBOutlet weak var signin_btn: UIButton!
    let languageVC = TestLocaVC()





   // @IBOutlet weak var RepeatPasswordTextField: UITextField!
    var phoneNumberTextField: FPNTextField!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    var para:[String:String] = [:]
    var name: String?
    var password: String?
    var email: String?



    var code:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        print("name: \(name)")
        print("password: \(password)")
        print("email: \(email)")

        prepareDataFromFacebook()
        languageVC.getCurrentSelectedLang()


        // Do any additional setup after loading the view.
        
        // To use your own flag icons, uncommment the line :
        //        Bundle.FlagIcons = Bundle(for: ViewController.self)
        
        phoneNumberTextField = FPNTextField(frame: CGRect(x: 0, y: 0, width: (Int(mainView.bounds.width)), height: 45))
        phoneNumberTextField.borderStyle = .roundedRect
        phoneNumberTextField.backgroundColor = #colorLiteral(red: 0.968773067, green: 0.968773067, blue: 0.968773067, alpha: 1)

        phoneNumberTextField.flagSize = CGSize(width: 30, height: 30)
        phoneNumberTextField.flagButtonEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        phoneNumberTextField.flagPhoneNumberDelegate = self
        phoneNumberTextField.hasPhoneNumberExample = true
           phoneNumberTextField.placeholder = "Phone number".localized()
        phoneNumberTextField.font = UIFont(name: "Tajawal", size: 14)

        
        
     
//           phoneNumberTextField.setCountries(excluding: [.AM, .BW, .BA])
        
        
        PhoneView.addSubview(phoneNumberTextField)
        self.setText()

        //phoneNumberTextField.center = view.center
        
        
    
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
        signup_btn.setTitle("Sign up".localized(using: "ButtonTitles"), for: UIControl.State.normal)
        skip_btn.setTitle("Skip".localized(using: "ButtonTitles"), for: UIControl.State.normal)
        signin_btn.setTitle("Login to continue".localized(using: "ButtonTitles"), for: UIControl.State.normal)
      
        
        createaccount.text = "Create Account".localized();
        createaccountsup.text = "Fill the below informations".localized();
        uesrnameTextField.placeholder = "Name".localized();
        EmailAddressTextField.placeholder = "Email Address".localized();
        PasswordTextField.placeholder = "Password".localized();
        phoneNumberTextField.placeholder = "Phone number".localized();

      
    }
    
    
    
    private func getCustomTextFieldInputAccessoryView(with items: [UIBarButtonItem]) -> UIToolbar {
        let toolbar: UIToolbar = UIToolbar()
        
        toolbar.barStyle = UIBarStyle.default
        toolbar.items = items
        toolbar.sizeToFit()
        
        return toolbar
    }
    
    func prepareDataFromFacebook(){
        
        if name != nil {
            uesrnameTextField.insertText(name!)
            
        }
        
        if password != nil {
            PasswordTextField.insertText(password!)
            PasswordTextField.isUserInteractionEnabled = false

            
            
        }
        
        if email != nil {
            EmailAddressTextField.insertText(email!)
            EmailAddressTextField.isUserInteractionEnabled = false
            
            
            
        }
        
        
    }
    
    
    @IBAction func logintocintinueTapped(_ sender: Any) {
        
        DispatchQueue.main.async
                              {
                             
                                  let homePage = self.storyboard?.instantiateViewController(withIdentifier: "sign_in")
                                  
                                  self.appDelegate.window?.rootViewController = homePage
                          }
        
        
    }
    
    
    
    @IBAction func SignUpButtonTapped(_ sender: Any) {
        print("Sign Up Button Tapped")
        
        // Read values from text fields
        let userNameTF = uesrnameTextField.text
        let emailAddressTF = EmailAddressTextField.text
       // let repeatedMobileNumbetTF = RepeatPasswordTextField.text
        let passwordTF = PasswordTextField.text
        
        let RepeatedPW = PasswordTextField.text
       
        
       
        let PhoneNumber = phoneNumberTextField.text

    
        // Check if required fields are not empty
        if (userNameTF?.isEmpty)! || (emailAddressTF?.isEmpty)! ||
            (passwordTF?.isEmpty)!
        {
      
            
            self.view.makeToast("One of the required fields is missing")

            
            return
        }
        
      
        
        
        // Send HTTP Request to Register user
        let myUrl = URL(string: "https://www.wasataa.com/api/Account/Register")
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"// Compose a query string
       // request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
       // request.addValue("ar", forHTTPHeaderField: "Accept-Language")
        let httpHeader = ["content-type": "application/x-www-form-urlencoded",
                          "Accept-Language": "ar"]
        
        let postString = ["FullName": userNameTF!,
                          "Email": emailAddressTF!,
                          "Password": passwordTF!,
                          "ConfirmPassword": RepeatedPW!,
                          "PhoneCode": "+" + self.code,
                          "Phone":(PhoneNumber?.replacingOccurrences(of: " ", with: ""))!,
            
                          ] as [String: String]
        
        print(postString)
        SVProgressHUD.show()

        
        Alamofire.request(myUrl!, method: HTTPMethod.post, parameters: postString, headers: httpHeader).responseJSON { (data) in

            if let dictonry = data.value as? NSDictionary {
                
                let statusCode = dictonry["statusCode"] as? Int
                let message = dictonry["message"] as? String
                if statusCode == 200 {
                    self.postLogin()
                    
                    
                }
                else if let errors = dictonry["errors"] as? NSArray{
                    
                    self.view.makeToast("\(errors)", duration: 1.0)
                    self.view.hideAllToasts()

                    

                }

            }
        }
        
        SVProgressHUD.dismiss()

        

        
    }
    
    
    
  
    func postLogin(){
        
        // Read values from text fields
        let userName = EmailAddressTextField.text
        let userPassword = PasswordTextField.text
        
       
        
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
                    let ACCESSTOKEN = "bearer " + AccessToken
                    print("User Access Token is: \(ACCESSTOKEN)")
                    UserDefaults.standard.set(ACCESSTOKEN, forKey: "access_token")
                    
                    
                    
                    DispatchQueue.main.async
                        {
                            
                            let homePage = self.storyboard?.instantiateViewController(withIdentifier: "MainHome")
                            
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

}


extension SignUpViewController: FPNTextFieldDelegate {
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        textField.leftViewMode = .always
       // phoneNumberTextField.rightViewMode = .always


    }
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        print(name, dialCode, code)
        
        
        self.code = dialCode.replacingOccurrences(of: "+", with: "")
        
    }
}
