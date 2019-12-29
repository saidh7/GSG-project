//
//  initialVC.swift
//  Wasatta
//
//  Created by Said Abdulla on 3/14/19.
//  Copyright © 2019 Said Abdulla. All rights reserved.
//

import UIKit
import LGButton
import Localize_Swift


class initialVC: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var Textmain: UILabel!
    @IBOutlet weak var search_btn: LGButton!
    @IBOutlet weak var addprop_btn: LGButton!
    @IBOutlet weak var showall_btn: UIButton!
    let languageVC = TestLocaVC()


    override func viewDidLoad() {
        super.viewDidLoad()
//        UIApplication.shared.statusBarStyle = .lightContent

        languageVC.getCurrentSelectedLang()
        self.setText()

        // Do any additional setup after loading the view.
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
        Textmain.text = "Look for properties with one click".localized();
        search_btn.titleString = "Search for properties".localized();
        addprop_btn.titleString = "Add properity".localized();
        showall_btn.setTitle("Show all properties".localized(using: "ButtonTitles"), for: UIControl.State.normal)
       
        

        
        
        
    }
    
    
    @IBAction func Searchbtn(_ sender: Any) {
        print("hello")
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "filter") as! FilterViewController
//        self.present(vc, animated: true, completion: nil)
        DispatchQueue.main.async
                       {
                      
                           let homePage = self.storyboard?.instantiateViewController(withIdentifier: "filter")
                           
                           self.appDelegate.window?.rootViewController = homePage
                   }
        
//        let homePage = self.storyboard?.instantiateViewController(withIdentifier: "filter")
//
//        self.appDelegate.window?.rootViewController = homePage
    }
    
    
    @IBAction func addpropbtn(_ sender: Any) {
        
        if UserDefaults.standard.string(forKey: "access_token") != nil{
            DispatchQueue.main.async
                {
                    self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
                    self.navigationController?.popToRootViewController(animated: false)
                    
                    
                    let homePage = self.storyboard?.instantiateViewController(withIdentifier: "addvc")
                    
                    self.appDelegate.window?.rootViewController = homePage
            }
            
            
            
        }else{
            let login = self.storyboard?.instantiateViewController(withIdentifier: "sign_in")
            
            self.appDelegate.window?.rootViewController = login
        }
    }

    @IBAction func mainTapped(_ sender: Any) {
        
            let login = self.storyboard?.instantiateViewController(withIdentifier: "MainHome")
            
            self.appDelegate.window?.rootViewController = login
        
    }
}
