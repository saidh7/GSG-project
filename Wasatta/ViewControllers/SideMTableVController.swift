//
//  SideMTableVController.swift
//  Wasatta
//
//  Created by Said Abdulla on 12/20/18.
//  Copyright © 2018 Said Abdulla. All rights reserved.
//

import UIKit
import SideMenu
import SVProgressHUD
import Localize_Swift



class SideMTableVController: UITableViewController {

    @IBOutlet weak var AddProperty: UITableViewVibrantCell!
    
    @IBOutlet weak var MyProp: UITableViewVibrantCell!
    
    
    @IBOutlet weak var profile: UITableViewVibrantCell!
    
    @IBOutlet weak var login: UITableViewVibrantCell!
    
    @IBOutlet weak var signout: UITableViewVibrantCell!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var lgoutlbl: UILabel!
    @IBOutlet weak var loginlbl: UILabel!
    @IBOutlet weak var profilelbl: UILabel!
    @IBOutlet weak var homelbl: UILabel!
    
    @IBOutlet weak var myproplbl: UILabel!
    
    @IBOutlet weak var addproplbl: UILabel!
    @IBOutlet weak var langlbl: UILabel!

    
    func userExist(){
        login.isHidden = true
    }
    
    func userNotExist(){
        AddProperty.isHidden = true
        MyProp.isHidden = true
        profile.isHidden = true
        signout.isHidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.reloadData()
        
//        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
        self.navigationController?.popToRootViewController(animated: false)
        self.setText()

    }
    
    
  
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard SideMenuManager.default.menuBlurEffectStyle == nil else {
            return
        }
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: NSNotification.Name( LCLLanguageChangeNotification), object: nil)
    }
    
    // Remove the LCLLanguageChangeNotification on viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func setText(){
        
        lgoutlbl.text = "Logout".localized();
        loginlbl.text = "Login".localized();
        profilelbl.text = "Profile".localized();
        homelbl.text = "Home".localized();
        myproplbl.text = "My properties".localized();
        addproplbl.text = "Add property".localized();
        langlbl.text = "Change language".localized();

       
        
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath) as! UITableViewVibrantCell
        
        
         cell.blurEffectStyle = SideMenuManager.default.menuBlurEffectStyle


//        if UserDefaults.standard.string(forKey: "access_token") != nil{
//
//            if indexPath.row == 3{
//                cell.isHidden = true
//                return cell
//
//            }else {
//                return cell
//            }
//
//        }
        
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{




        if UserDefaults.standard.string(forKey: "access_token") != nil{

            if indexPath.row == 4{
                return 0
            }else {

                return 60

            }

        }

        if UserDefaults.standard.string(forKey: "access_token") == nil{

            if indexPath.row == 1 || indexPath.row == 2  || indexPath.row == 3 || indexPath.row == 5{
                return 0
            }else {

                return 60

            }

        }

        return 40


    }
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        switch(indexPath.row){
        case 0:
            dismiss(animated: true, completion: nil)

//            let vc = (self.storyboard?.instantiateViewController(withIdentifier: "MainHome"))!
//            self.navigationController?.pushViewController(vc, animated: true)
            
//            self.navigationController?.popViewController(animated: true)
//
//            DispatchQueue.main.async
//                {
//
//                    self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
//                    self.navigationController?.popToRootViewController(animated: false)
//                    let homePage = self.storyboard?.instantiateViewController(withIdentifier: "MainHome")
//
//                    self.appDelegate.window?.rootViewController = homePage
//
//                    //                    let secondView = self.storyboard?.instantiateViewController(withIdentifier: "MainHome")
//                    //                    self.present(secondView!, animated: true, completion: nil)
//            }
            
            
        case 5:
            
            let alert = UIAlertController(title: "Confirm".localized(),
                                          message: "Are you sure that you are want to logout?".localized(),
                                          preferredStyle: .alert)
            
            let submitAction = UIAlertAction(title: "Ok".localized(), style: .default, handler: { (action) -> Void in
                SVProgressHUD.show()
                
                UserDefaults.standard.removeObject(forKey: "access_token")
             


                
                DispatchQueue.main.async
                    {
                        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
                        self.navigationController?.popToRootViewController(animated: false)
                        let homePage = self.storyboard?.instantiateViewController(withIdentifier: "sign_in")
                        
                        self.appDelegate.window?.rootViewController = homePage
                }
            })
            let cancel = UIAlertAction(title: "Cancle".localized(), style: .destructive, handler: { (action) -> Void in })
            
            alert.addAction(submitAction)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
            SVProgressHUD.dismiss()
            
            break
            
        case 4:
            DispatchQueue.main.async
                {
                    self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
                    self.navigationController?.popToRootViewController(animated: false)
                    
                    let homePage = self.storyboard?.instantiateViewController(withIdentifier: "sign_in")
                    
                    self.appDelegate.window?.rootViewController = homePage
            }
            
        case 6:
            let vc = (self.storyboard?.instantiateViewController(withIdentifier: "lang"))!
            self.navigationController?.pushViewController(vc, animated: true)
//            DispatchQueue.main.async
//                {
//                    self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
//                    self.navigationController?.popToRootViewController(animated: false)
//
//                    let homePage = self.storyboard?.instantiateViewController(withIdentifier: "lang")
//
//                    self.appDelegate.window?.rootViewController = homePage
//            }
           break
        case 1:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "addvc") as! AddPropertyVC
//            self.present(vc, animated: true, completion: nil)
            self.navigationController?.pushViewController(vc, animated: true)

            break
            
        case 3:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "user_profile") as! profileVC
            self.navigationController?.pushViewController(vc, animated: true)

        break
        case 2:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "my_prop") as! MypropTableViewController
            self.navigationController?.pushViewController(vc, animated: true)

//            self.present(vc, animated: true, completion: nil)

//            DispatchQueue.main.async
//                {
//                    self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
//                    self.navigationController?.popToRootViewController(animated: false)
//
//                    let homePage = self.storyboard?.instantiateViewController(withIdentifier: "my_prop")
//
//                    self.appDelegate.window?.rootViewController = homePage
//            }
            

            
            
        default:
            break
        }
        //...
    }
    
}
