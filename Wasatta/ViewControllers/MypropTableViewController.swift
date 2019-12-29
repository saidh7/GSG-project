//
//  MypropTableViewController.swift
//  Wasatta
//
//  Created by Said Abdulla on 12/14/18.
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



class MypropTableViewController: UIViewController , UITableViewDelegate , UITableViewDataSource, RealEstateTableViewCellDelegate {
    //    var objects = [RealEstateObject]()
    var objects:[[String:JSON]] = []
    var page:Int = 0
    let loginVc = SignInViewController()
    let languageVC = TestLocaVC()

    
    @IBOutlet weak var adsTable: UITableView!
    @IBOutlet weak var navItem: UINavigationItem!

    
    
    @IBOutlet weak var roomlbl: UILabel!
    @IBOutlet weak var bathroomlbl: UILabel!
    @IBOutlet weak var spacelbl: UILabel!
    @IBOutlet weak var floorslbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        
      //  loginVc.getDeviceLanguage()
        languageVC.getCurrentSelectedLang()


        var preferredStatusBarStyle : UIStatusBarStyle {
            return .lightContent
        }
        
        setNeedsStatusBarAppearanceUpdate()
        
        //  setDefaults()
        self.adsTable.delegate = self
        self.adsTable.dataSource = self
        
        adsTable.estimatedRowHeight = 64
        adsTable.rowHeight = UITableViewAutomaticDimension
        self.objects.removeAll()
        loadData()
        self.configureActionButton()
        self.setText()



        
    }
    
    // Add an observer for LCLLanguageChangeNotification on viewWillAppear. This is posted whenever a language changes and allows the viewcontroller to make the necessary UI updated. Very useful for places in your app when a language change might happen.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: NSNotification.Name( LCLLanguageChangeNotification), object: nil)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
//        self.objects.removeAll()
//        loadData()
//        self.adsTable.reloadData()
        
        self.reloadData()

//        adsTable.reloadData()


    }
    
    // Remove the LCLLanguageChangeNotification on viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)

    }
    
    @objc func setText(){
//
//        roomlbl.text = "Room".localized();
//        bathroomlbl.text = "Bathroom".localized();
//        spacelbl.text = "Space".localized();
//        floorslbl.text = "Floors".localized();
        
        self.navItem.title = "My properties".localized();

        
        
    }
    
    
    func configureActionButton() {
        let actionButton = JJFloatingActionButton()
        //        actionButton.addItem(title:"", image: #imageLiteral(resourceName: "upload1"))? { item in
        //
        //            self.realestateTable?.scrollToRow(at: IndexPath(row: 0, section: 0),at: .top, animated: true)
        //
        //
        //        }
        
        actionButton.addItem(title: "item 1", image: UIImage(named: "home-added")?.withRenderingMode(.alwaysTemplate)) { item in
            // do something
            print("ali")
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "addvc") as! AddPropertyVC
//            self.present(vc, animated: true, completion: nil)
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
        
        
        actionButton.buttonColor = #colorLiteral(red: 0.1764705926, green: 0.3856945006, blue: 0.5607843399, alpha: 1)
               
        
    }

    
    
    @IBAction func dismiss(_ sender: Any) {
        
//        navigationController?.popViewController(animated: true)
        self.navigationController?.popViewController(animated: true)

        
//        dismiss(animated: true, completion: nil)
    }

    

    func reloadData(){
        self.objects.removeAll()
        page = 0
        loadData()
        self.adsTable.reloadData()
    }
    
    
    func loadData(){
        SVProgressHUD.show()
        let token = UserDefaults.standard.value(forKey: "access_token")
        let url = "https://www.wasataa.com/api/RealEstate/MyRealEstate"
        let header = ["Content-Type":"application/x-www-form-urlencoded ",
                      "Authorization":token
            ] as! [String : String]
        let langstring = languageVC.lang
        page = page + 1
        let pageStr = String(page)
        let parameters = ["Lang":langstring!,
                          "page": pageStr
            ] as [String : Any]
        Alamofire.request(url,method: .get,parameters: parameters,headers:header)
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
            cell.delegate = self

          
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
//           self.present(vc!, animated: true, completion: nil)
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
    
    
    
    func deleteTapped(_ cell: RealEstateTableViewCell) {
        let alert = UIAlertController(title: "Alert".localized(),
                                      message: "Are you sure that you want to remove this properity?".localized(),
                                      preferredStyle: .alert)
        
        let submitAction = UIAlertAction(title: "Ok".localized(), style: .default, handler: { (action) -> Void in
            let index = self.adsTable.indexPath(for: cell)
            let data = self.objects[(index?.row)!]
            SVProgressHUD.show()
            let token = UserDefaults.standard.value(forKey: "access_token")
            let parameterss = ["id": data["id"]?.stringValue ?? "0"
                ] as [String : Any]
            
            let url = "https://www.wasataa.com/api/RealEstate/RemoveRealestate"
            let header = [
                "Authorization": token
                ] as! [String : String]
            
            Alamofire.request(url,method: .get,parameters: parameterss,headers:header)
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        let responseResult = JSON(response.result.value!)
                        
                        self.reloadData()
                        SVProgressHUD.dismiss()
                        
                        
                    case .failure(let error):
                        print("******** \(error.localizedDescription) *******")
                        
                    }
            }
            
            
            
            
        })
        let cancel = UIAlertAction(title: "Cancle".localized(), style: .destructive, handler: { (action) -> Void in })
        
        alert.addAction(submitAction)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        SVProgressHUD.dismiss()
        
        
        
    }
    
    
    
    func EditTapped(_ cell: RealEstateTableViewCell) {
        let index = adsTable.indexPath(for: cell)
        let data = objects[(index?.row)!]
        let controller =  self.storyboard?.instantiateViewController(withIdentifier: "EditPropertyVC") as! EditPropertyVC
        controller.selectedID = data["id"]?.stringValue
//        self.present(controller, animated: true, completion: nil)
        
        self.navigationController?.pushViewController(controller, animated: true)

    }
    
}
