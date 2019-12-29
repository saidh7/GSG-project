//
//  TestLocaVC.swift
//  Wasatta
//
//  Created by Said Abdulla on 3/20/19.
//  Copyright © 2019 Said Abdulla. All rights reserved.
//

import UIKit
import Localize_Swift


class TestLocaVC: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
   
    var lang:String?
    
    

    
    var actionSheet: UIAlertController!
    
    var availableLanguages = Localize.availableLanguages()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentSelectedLang()
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        let objectToRemove = "Base"

//        availableLanguages.remove(at: 0)
        availableLanguages.remove(object: objectToRemove)
        self.setText()
        
    }
    
    
    
    // Add an observer for LCLLanguageChangeNotification on viewWillAppear. This is posted whenever a language changes and allows the viewcontroller to make the necessary UI updated. Very useful for places in your app when a language change might happen.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: NSNotification.Name( LCLLanguageChangeNotification), object: nil)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)

    }
    
    // Remove the LCLLanguageChangeNotification on viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
           
        self.navigationController?.setNavigationBarHidden(true, animated: false)

           
           
        
        
        
    }

    
    // MARK: Localized Text
    
    @objc func setText(){
        textLabel.text = "Hello world".localized();
//        resetButton.setTitle("Reset".localized(using: "ButtonTitles"), for: UIControl.State.normal)
        
        
        let changearrtibutedstr = NSAttributedString(string: "Choose language".localized(),attributes: [NSAttributedStringKey.foregroundColor : #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)])
        
        
        changeButton.setAttributedTitle(changearrtibutedstr, for: .normal)
        
        let defaultarrtibutedstr = NSAttributedString(string: "Use default".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray])
        
        
        resetButton.setAttributedTitle(defaultarrtibutedstr, for: .normal)
        
        
        let continuearrtibutedstr = NSAttributedString(string: "Enter Wasataa".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray])
        
        
        continueButton.setAttributedTitle(continuearrtibutedstr, for: .normal)

    }
    
    @IBAction func continueTapped(_ sender: Any) {
        
                    DispatchQueue.main.async
                        {
                            self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
                            self.navigationController?.popToRootViewController(animated: false)
        
                            let homePage = self.storyboard?.instantiateViewController(withIdentifier: "initialVC")
        
                            self.appDelegate.window?.rootViewController = homePage
                    }
        
//
//        let viewToPush = initialVC()
//        let nav = UINavigationController(rootViewController: viewToPush)
//        nav.pushViewController(nav, animated: true)
//

//        if UserDefaults.standard.string(forKey: "access_token") != nil{
//               let vc = self.storyboard?.instantiateViewController(withIdentifier: "initialVC") as! initialVC
//
//            self.present(vc, animated: true, completion: nil)
//
////               self.navigationController?.pushViewController(vc, animated: true)
//
//
//        }else{
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "sign_in") as! SignInViewController
//            self.present(vc, animated: true, completion: nil)
//
////            self.navigationController?.pushViewController(vc, animated: true)
//        }
    }
    // MARK: IBActions
    
    
    func getCurrentSelectedLang(){
//
//        let availableLang = Localize.availableLanguages()
//        for lang in availableLang{
//
//
//        }
//
        if Localize.currentLanguage() == "ar"{
            self.lang  = "ar"
            print("my language is \(lang)")
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }else if Localize.currentLanguage() == "fr"{
            self.lang  = "fr"
            print("my language is \(lang)")
            UIView.appearance().semanticContentAttribute = .forceLeftToRight

        }else if Localize.currentLanguage() == "es"{
            self.lang  = "es"
            print("my language is \(lang)")
            UIView.appearance().semanticContentAttribute = .forceLeftToRight

        }else if Localize.currentLanguage() == "ru"{
            self.lang  = "ru"
            print("my language is \(lang)")
            UIView.appearance().semanticContentAttribute = .forceLeftToRight

        }else if Localize.currentLanguage() == "tr"{
            self.lang  = "tr"
            print("my language is \(lang)")
            UIView.appearance().semanticContentAttribute = .forceLeftToRight

        }else if Localize.currentLanguage() == "de"{
            self.lang  = "de"
            print("my language is \(lang)")
            UIView.appearance().semanticContentAttribute = .forceLeftToRight

        }else if Localize.currentLanguage() == "en"{
            self.lang  = "en"
            print("my language is \(lang)")
            UIView.appearance().semanticContentAttribute = .forceLeftToRight

        }
        
//        else if
//            Localize.currentLanguage() != "ar" &&
//            Localize.currentLanguage() != "en" &&
//            Localize.currentLanguage() != "fr" &&
//            Localize.currentLanguage() != "es" &&
//            Localize.currentLanguage() != "tr" &&
//            Localize.currentLanguage() != "de" &&
//            Localize.currentLanguage() != "ru"
//        {
//            self.lang = "ar"
//        }
        
        
        
        
    }
    
    @IBAction func doChangeLanguage(_ sender: AnyObject) {
        actionSheet = UIAlertController(title: nil, message: "Switch Language".localized(), preferredStyle: UIAlertController.Style.actionSheet)
        for language in availableLanguages {
            let displayName = Localize.displayNameForLanguage(language)
            let languageAction = UIAlertAction(title: displayName, style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                Localize.setCurrentLanguage(language)
                
//                self.lang = language
//                print ("langlanglang\(self.lang!)")
//
//                
                
            })
            actionSheet.addAction(languageAction)
            
           
        }
        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: UIAlertAction.Style.cancel, handler: {
            (alert: UIAlertAction) -> Void in
        })
        actionSheet.addAction(cancelAction)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func doResetLanguage(_ sender: AnyObject) {
        Localize.resetCurrentLanguageToDefault()
        self.lang = "en"

    }

}

   extension Array where Element: Equatable {

    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        guard let index = index(of: object) else {return}
        remove(at: index)
    }

}
