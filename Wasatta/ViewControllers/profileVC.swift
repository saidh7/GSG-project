//
//  profileVC.swift
//  Wasatta
//
//  Created by Said Abdulla on 12/15/18.
//  Copyright © 2018 Said Abdulla. All rights reserved.
//

import UIKit
import SVProgressHUD
import SideMenu
import Kingfisher
import SwiftyJSON
import Alamofire
import FlagPhoneNumber
import Toast_Swift
import Localize_Swift



class profileVC: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var navItem: UINavigationItem!

    
    @IBOutlet weak var changePW: UIButton!
    let loginVC = SignInViewController()
    let languageVC = TestLocaVC()
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    var phoneNumberTextField: FPNTextField!
    @IBOutlet weak var updateBtn: UIButton!

    var code:String = ""



    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)


        loadData()
        phoneNumberTextField = FPNTextField(frame: CGRect(x: 0, y: 0, width: phoneView.bounds.width, height: 45))
        phoneNumberTextField.borderStyle = .roundedRect
        phoneNumberTextField.backgroundColor = #colorLiteral(red: 0.968773067, green: 0.968773067, blue: 0.968773067, alpha: 1)
        
        phoneNumberTextField.flagSize = CGSize(width: 30, height: 30)
        phoneNumberTextField.flagButtonEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        phoneNumberTextField.flagPhoneNumberDelegate = self
        phoneNumberTextField.hasPhoneNumberExample = true
        phoneNumberTextField.placeholder = "Phone number"
        
       phoneView.addSubview(phoneNumberTextField)
        
        self.setText()
        languageVC.getCurrentSelectedLang()


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)

    }

    
    override func viewDidAppear(_ animated: Bool) {
      
          self.navigationController?.setNavigationBarHidden(true, animated: false)
  
          
      }
      
     
    
    
    
    @objc func setText(){
        
        let updatebtnarrtibutedstr = NSAttributedString(string: "Update".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        
        
        updateBtn.setAttributedTitle(updatebtnarrtibutedstr, for: .normal)
        
       
        
        self.navItem.title = "My profile".localized();
        
        
        
    }
    
    @IBAction func dismiss(_ sender: Any) {
        
        print("dismiss")
        
        navigationController?.popViewController(animated: true)
        
//        dismiss(animated: true, completion: nil)
    }
    @IBAction func changePasswordBtn(_ sender: Any){
        let secondView = self.storyboard?.instantiateViewController(withIdentifier: "change_password") as! changePasswordVC
//        self.present(secondView, animated: true, completion: nil)
        self.navigationController?.pushViewController(secondView, animated: true)
        
//        DispatchQueue.main.async
//            {
//                let homePage = self.storyboard?.instantiateViewController(withIdentifier: "change_password")
//
//                self.appDelegate.window?.rootViewController = homePage
//        }
    }
    

    
    func loadData(){
        SVProgressHUD.show()
        let token = UserDefaults.standard.value(forKey: "access_token")
        let url = "https://www.wasataa.com/api/Account/UserInfo"
        let header = ["Content-Type":"application/x-www-form-urlencoded ",
                      "Authorization":token
            ] as! [String : String]
      
    
        Alamofire.request(url,method: .get,headers:header)
            .responseJSON { response in
                switch response.result {
                case .success:
                    let responseResult = JSON(response.result.value!)
                    if let data = responseResult.dictionary {
                        
                        
                        if let email = data["email"]?.stringValue, email != nil{
                            
                          
                            
                            let fbToken = UserDefaults.standard.value(forKey: "fblogin")
                            
                            if fbToken != nil{
                                print ("Fb access \(fbToken)")
                                self.emailTF.isUserInteractionEnabled = false
                                self.emailTF.clearButtonMode = .never
                                //self.changePW.isHidden = true

                            }
                            
                            
                            let GoogleToken = UserDefaults.standard.value(forKey: "Googlelogin")
                            
                            if GoogleToken != nil{
                                self.emailTF.isUserInteractionEnabled = false
                                self.emailTF.clearButtonMode = .never
                                //self.changePW.isHidden = true


                            }
                            
                            self.emailTF.text = email
                            
                        }
                        
                        if let fullName = data["fullName"]?.stringValue, fullName != nil{
                            self.usernameTF.text = fullName
                            
                        }
                        
                        if let phone = data["phone"]?.stringValue, let phoneCode = data["phoneCode"]?.stringValue {
                            self.phoneNumberTextField.text = phone
                            self.code = phoneCode

                            
                        }
                        
                        SVProgressHUD.dismiss()
                        
                    }
                case .failure(let error):
                    print("******** \(error.localizedDescription) *******")
                    
                }
        }
    }
    
    @IBAction func editProfileTapped(_ sender: Any) {
        
        print("Sign Up Button Tapped")

        
       

        
        let userNameTF = usernameTF.text
        let emailAddressTF = emailTF.text
        let PhoneNumber = phoneNumberTextField.text
        
        
        if (emailAddressTF?.isEmpty)! || (userNameTF?.isEmpty)! ||
            (PhoneNumber?.isEmpty)!
        {
            self.view.makeToast("One of the required fields is missing")
            return
        }
        
        SVProgressHUD.show()
        let token = UserDefaults.standard.value(forKey: "access_token")
        
        // Send HTTP Request to Register user
        let myUrl = URL(string: "https://www.wasataa.com/api/Account/Profile")
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"// Compose a query string
        
        let header = ["Content-Type":"application/x-www-form-urlencoded ",
                      "Authorization":token
            ] as! [String : String]
        
        let postString = ["FullName": userNameTF!,
                          "Email": emailAddressTF!,
                          //"Password": passwordTF!,
                          //"ConfirmPassword": RepeatedPW!,
                          //"PhoneCode": "+" + self.code,
                          "Phone":(PhoneNumber?.replacingOccurrences(of: " ", with: ""))!,
                          
                          ] as [String: String]
        
        print(postString)
        
        Alamofire.request(myUrl!, method: HTTPMethod.post, parameters: postString, headers: header).responseJSON { (data) in

            print("AlamofireAlamofireAlamofire")
            print(data.error)
            print(data.value)
            if let dictonry = data.value as? NSDictionary {
                
                let statusCode = dictonry["statusCode"] as? Int
                let message = dictonry["message"] as? String
                if statusCode == 200 {
                    print("success")
                    
                    self.view.makeToast("The profile has been changed successfully".localized())

                }
                else if let errors = dictonry["errors"] as? NSArray, let first = errors.firstObject  {
                    
                    
                }
                
            }
            
            SVProgressHUD.dismiss()

        }
        

        
       
    }
    
    
    
    private func getCustomTextFieldInputAccessoryView(with items: [UIBarButtonItem]) -> UIToolbar {
        let toolbar: UIToolbar = UIToolbar()
        
        toolbar.barStyle = UIBarStyle.default
        toolbar.items = items
        toolbar.sizeToFit()
        
        return toolbar
    }
    
    
    

}


extension profileVC: FPNTextFieldDelegate {
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        textField.leftViewMode = .always
        
    }
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        print(name, dialCode, code)
        
        let codee:String = dialCode

        
        self.code = dialCode.replacingOccurrences(of: "+", with: "")
        
    }
}


