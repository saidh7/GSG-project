//
//  changePasswordVC.swift
//  Wasatta
//
//  Created by Said Abdulla on 12/22/18.
//  Copyright © 2018 Said Abdulla. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Toast_Swift
import SVProgressHUD
import SideMenu




class changePasswordVC: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    let languageVC = TestLocaVC()
    override func viewDidLoad() {
        super.viewDidLoad()
        languageVC.getCurrentSelectedLang()
        self.navigationController?.setNavigationBarHidden(true, animated: false)


       // setupSideMenu()


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
        
       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           self.navigationController?.setNavigationBarHidden(true, animated: false)

       }

       
       override func viewDidAppear(_ animated: Bool) {
         
             self.navigationController?.setNavigationBarHidden(true, animated: false)
     
             
         }

    // MARK: - Table view data source
    
    fileprivate func setupSideMenu() {
        SideMenuManager.default.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
        
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.default.menuAddPanGestureToPresent(toView: navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: navigationController!.view)
        
        SideMenuManager.default.menuShadowRadius = 7.0
        SideMenuManager.default.menuShadowColor = UIColor.black
        SideMenuManager.default.menuAnimationBackgroundColor = #colorLiteral(red: 0.6196078431, green: 0.4666666667, blue: 0.2156862745, alpha: 1)
    }

    @IBAction func dismiss(_ sender: Any) {
        print("dismiss")
        
        navigationController?.popViewController(animated: true)
        
//        dismiss(animated: true, completion: nil)
    }
    @IBAction func changePasswordTapped(_ sender: Any) {
        
        let password = self.password.text
        let newPass = self.newPassword.text
        let confirmPass = self.confirmPassword.text
        
        
        if (password?.isEmpty)! || (newPass?.isEmpty)! ||
            (confirmPass?.isEmpty)!
        {
            self.view.makeToast("One of the required fields is missing")
            return
        }
        
        SVProgressHUD.show()
        let token = UserDefaults.standard.value(forKey: "access_token")
        
        // Send HTTP Request to Register user
        let myUrl = URL(string: "https://www.wasataa.com/api/Account/ChangePassword")
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"// Compose a query string
        
        let header = ["Content-Type":"application/x-www-form-urlencoded ",
                      "Authorization":token
            ] as! [String : String]
        
        let postString = ["OldPassword": password!,
                          "NewPassword": newPass!,
                          "ConfirmPassword": confirmPass!,
          
            
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
                    print("Please login Again!")
                    sleep(2)
                    self.view.makeToast("\(message)")
                    SVProgressHUD.show()


                    
                    
                    UserDefaults.standard.removeObject(forKey: "access_token")
                    
                    
                    
                    
                    DispatchQueue.main.async
                        {
                            self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
                            self.navigationController?.popToRootViewController(animated: false)
                            let homePage = self.storyboard?.instantiateViewController(withIdentifier: "sign_in")
                            
                            self.appDelegate.window?.rootViewController = homePage
                    }
                    SVProgressHUD.dismiss()
                }
                else if let errors = dictonry["errors"] as? NSArray, let first = errors.firstObject  {
                    
                    
                    self.view.makeToast("\(first)")


                    
                    
                }
                
                SVProgressHUD.dismiss()

                
            }
        }
    }
    

}
