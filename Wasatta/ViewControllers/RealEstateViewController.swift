//
//  RealEstateViewController.swift
//  Wasatta
//
//  Created by Said Abdulla on 10/8/18.
//  Copyright © 2018 Said Abdulla. All rights reserved.
//

import UIKit
import SVProgressHUD
import SideMenu
import Kingfisher
import SwiftyJSON
import Alamofire
import JJFloatingActionButton
import Localize_Swift


class RealEstateViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    //    var objects = [RealEstateObject]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    var objects:[[String:JSON]] = []
    var page:Int = 0
  //  let loginVc = SignInViewController()
    let languageVC = TestLocaVC()
    @IBOutlet weak var roomlbl: UILabel!
    @IBOutlet weak var bathroomlbl: UILabel!
    @IBOutlet weak var spacelbl: UILabel!
    @IBOutlet weak var floorslbl: UILabel!
    @IBOutlet weak var navItem: UINavigationItem!


    @IBOutlet weak var adsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  loginVc.getDeviceLanguage()
        languageVC.getCurrentSelectedLang()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
//        UIApplication.shared.statusBarStyle = .lightContent


        
       
       NotificationCenter.default.addObserver(self, selector: #selector(self.updatecountry), name: .openmyproperty,     object: nil)
        
        
        var preferredStatusBarStyle : UIStatusBarStyle {
            return .lightContent
        }
        
        
        setNeedsStatusBarAppearanceUpdate()
        
        setupSideMenu()
        //  setDefaults()
        self.adsTable.delegate = self
        self.adsTable.dataSource = self
        
        adsTable.estimatedRowHeight = 64
        adsTable.rowHeight = UITableViewAutomaticDimension
        self.objects.removeAll()
        loadData()
        if UserDefaults.standard.string(forKey: "access_token") != nil{
        self.configureActionButton()
        }
        
        self.configureActionButton2()

        
        self.setText()

        //self.addprop()
        
        
        

       // if UserDefaults.standard.string(forKey: "access_token") != nil{
          //  self.emptyFloatySelected(self.floaty)

        //}

        
        
        //        loadDataFromNetwork()
    }        // Do any additional setup after loading the view.

    
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: NSNotification.Name( LCLLanguageChangeNotification), object: nil)
        self.navigationController?.setNavigationBarHidden(false, animated: false)

        
    //    let lang = Localize.setCurrentLanguage("fr")

       // print("langlanglangooo \(lang!)")
    }
    
    // Remove the LCLLanguageChangeNotification on viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)

        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func setText(){
        
//        roomlbl.text = "Room".localized();
//        bathroomlbl.text = "Bathroom".localized();
//        spacelbl.text = "Space".localized();
//        floorslbl.text = "Floors".localized();
        self.navItem.title = "Latest offers".localized();

        
        
    }
    
    func configureActionButton() {
        let actionButton = JJFloatingActionButton()

        actionButton.configureDefaultItem { item in
            item.titlePosition = .trailing

            item.titleLabel.font = .boldSystemFont(ofSize: UIFont.systemFontSize)
            item.titleLabel.textColor = .white
            item.buttonColor = .white
            item.buttonImageColor = .gray

            item.layer.shadowColor = UIColor.black.cgColor
            item.layer.shadowOffset = CGSize(width: 0, height: 1)
            item.layer.shadowOpacity = Float(0.4)
            item.layer.shadowRadius = CGFloat(2)
        }

        actionButton.addItem(title: "Add property".localized(), image: UIImage(named: "home-added")?.withRenderingMode(.alwaysTemplate)) { item in
            // do something
            print("ali")
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "addvc") as! AddPropertyVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
 
        view.addSubview(actionButton)
        
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
        actionButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        if #available(iOS 11.0, *) {
            actionButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70).isActive = true
        } else {
            actionButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 70).isActive = true
            actionButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -25).isActive = true
        }
        
        
        actionButton.buttonColor = #colorLiteral(red: 0.1764705926, green: 0.3856945006, blue: 0.5607843399, alpha: 1)
        
        
    }
    
    
    
        func configureActionButton2() {
            let actionButton = JJFloatingActionButton()

            actionButton.configureDefaultItem { item in
                item.titlePosition = .trailing

                item.titleLabel.font = .boldSystemFont(ofSize: UIFont.systemFontSize)
                item.titleLabel.textColor = .white
                item.buttonColor = .white
                item.buttonImageColor = .gray

                item.layer.shadowColor = UIColor.black.cgColor
                item.layer.shadowOffset = CGSize(width: 0, height: 1)
                item.layer.shadowOpacity = Float(0.4)
                item.layer.shadowRadius = CGFloat(2)
            }

//            actionButton.addItem(title: "Add property".localized(), image: UIImage(named: "addhome")?.withRenderingMode(.alwaysTemplate)) { item in
//                // do something
//                print("ali")
//
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "addvc") as! AddPropertyVC
//                self.present(vc, animated: true, completion: nil)
//            }
            
            
            actionButton.addItem(title: "Map properties".localized(), image: UIImage(named: "markerIcon")?.withRenderingMode(.alwaysTemplate)) { item in
                     // do something
                     print("ali")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MapPropVC") as! MapPropVC

                self.navigationController?.pushViewController(vc, animated: true)

    
    
                 }
            
            view.addSubview(actionButton)
            
            actionButton.translatesAutoresizingMaskIntoConstraints = false
            actionButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
            actionButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
            if #available(iOS 11.0, *) {
                actionButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
                actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
            } else {
                actionButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
                actionButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -25).isActive = true
            }
            
            
            actionButton.buttonColor = #colorLiteral(red: 0.6422192454, green: 0.5002707839, blue: 0.2633349299, alpha: 1)
            
        }


    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    @IBAction func filterBtn_Tapped(_ sender: Any) {
        
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "filter") as! FilterViewController
//        self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)

        
    }
    @objc func updatecountry(){
       let vc = self.storyboard?.instantiateViewController(withIdentifier: "my_prop") as! MypropTableViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
  
  
    
    fileprivate func setupSideMenu() {
        
              
        let lang = languageVC.lang
        if lang == "ar"{
            SideMenuManager.default.rightMenuNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
        }else{
            
//             SideMenuManager.default.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
            let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
            
            SideMenuManager.default.leftMenuNavigationController = menuLeftNavigationController
            
            menuLeftNavigationController?.statusBarEndAlpha = 0




        }
        
        
        
        let sideMenuSet = SideMenuSettings()

        
        SideMenuManager.default.leftMenuNavigationController?.modalPresentationStyle = .overCurrentContext
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.default.addPanGestureToPresent(toView: navigationController!.navigationBar)
//        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: navigationController!.view)
        sideMenuSet.presentationStyle.onTopShadowRadius = 7.0
        sideMenuSet.presentationStyle.onTopShadowColor = UIColor.black
        sideMenuSet.presentationStyle.backgroundColor = #colorLiteral(red: 0.6196078431, green: 0.4666666667, blue: 0.2156862745, alpha: 1)


    }
    
    func loadData(){
        SVProgressHUD.show()
        let url = "https://www.wasataa.com/api/RealEstate/GetRealEstate"
        let langstring = languageVC.lang
        page = page + 1
        let pageStr = String(page)
        let parameters = ["Lang":langstring!,
                          "page": pageStr
            ] as [String : Any]
        Alamofire.request(url,method: .get,parameters: parameters)
            .responseJSON { response in
                switch response.result {
                case .success:
                    let responseResult = JSON(response.result.value!)
                    if let data = responseResult.array {
                        for i in data{
                            self.objects.append(i.dictionary!)

                            
                        }
                        self.adsTable.reloadData()

                        


                        SVProgressHUD.dismiss()
                        
                    }
                    

                case .failure(let error):
                    print("\n\n===========Error===========")
                    print("Error Code: \(error._code)")
                    print("Error Messsage: \(error.localizedDescription)")
                    if let data = response.data, let str = String(data: data, encoding: String.Encoding.utf8){
                        print("Server Error: " + str)
                    }
                    debugPrint(error as Any)
                    print("===========================\n\n")
                }
                

        }
    }
    
    
    

    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ads_cell", for: indexPath) as! RealEstateTableViewCell
        let data = objects[indexPath.row]
        
        if let space = data["sizeBuild"]?.stringValue, space != nil{
            cell.lblSSpace.text  = space
        }
        
        if let spaceUnit = data["unitArea"]?.stringValue, spaceUnit != nil{
            cell.lblSpaceUnit.text  = spaceUnit
        }
        
        if let bathroom = data["bathRoom"]?.stringValue, bathroom != nil{
            cell.lblBath.text  = bathroom
        }
        
        if let rooms = data["room"]?.stringValue, rooms != nil{
            cell.lblRooms.text  = rooms
        }
        
        if let floors = data["floorsNumber"]?.stringValue, floors != nil{
            cell.lblFloor.text  = floors
        }
        if let phonenmber = data["phone"]?.stringValue, phonenmber != nil{
            cell.lblPhonee.text  = phonenmber
        }
        let priceCurrency = data["priceType"]?.stringValue

        if let price = data["price"]?.stringValue, price != nil{
            
            cell.lblPrice.text  = price + " " + priceCurrency!
        }
        
        if let propertyType = data["propertyType"]?.stringValue, propertyType != nil, let propertyClass = data["propertyClass"]?.stringValue, propertyClass != nil {
            cell.title.text  = propertyType + " " + propertyClass
        }
        
        if let country = data["country"]?.stringValue, country != nil, let city = data["city"]?.stringValue, city != nil {
            cell.lblAdress.text  = country + ", " + city
        }
        
        let url = "http://" + (data["mainImageURL"]?.stringValue)!
        let imgurl = URL(string: url as String)!
        cell.propIMG.kf.setImage(with: imgurl)
        
        
        
        
       
        
        print("Row: \(indexPath)")
        print("id: \(data["id"]?.intValue)")
        //        cell.fillData()
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("helooooooo")
        let data = objects[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "RSDetailsViewController") as? RSDetailsViewController
        vc?.objects = data
//        self.present(vc!, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc!, animated: true)

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == objects.count - 2 {
            loadData()
            SVProgressHUD.dismiss()
            
        }
    }
   
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    
    
    
    
    
    
    
}




