//
//  SearchResultsTableViewController.swift
//  Wasatta
//
//  Created by Said Abdulla on 12/13/18.
//  Copyright © 2018 Said Abdulla. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON
import Kingfisher
import JJFloatingActionButton
import Localize_Swift


class SearchResultsTableViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    let filter = FilterViewController()
    var page:Int = 0
    var objects:[[String:JSON]] = []
    @IBOutlet weak var ResultsTable: UITableView!
    @IBOutlet weak var lbl_no_data:UILabel!
    let loginVc = SignInViewController()
    let languageVC = TestLocaVC()

    @IBOutlet weak var navItem: UINavigationItem!

    
    @IBOutlet weak var roomlbl: UILabel!
    @IBOutlet weak var bathroomlbl: UILabel!
    @IBOutlet weak var spacelbl: UILabel!
    @IBOutlet weak var floorslbl: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // print("paraaaahhjghjgaaa \(Parameters)")
        lbl_no_data.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        
        
      //  loginVc.getDeviceLanguage()
        languageVC.getCurrentSelectedLang()

        
        var preferredStatusBarStyle : UIStatusBarStyle {
            return .lightContent
        }
        
        setNeedsStatusBarAppearanceUpdate()
        
        //  setDefaults()
        self.ResultsTable.delegate = self
        self.ResultsTable.dataSource = self
        
        ResultsTable.estimatedRowHeight = 64
        ResultsTable.rowHeight = UITableViewAutomaticDimension
        self.objects.removeAll()
        if UserDefaults.standard.string(forKey: "access_token") != nil{
            self.configureActionButton()
        }
        self.setText()

        
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: NSNotification.Name( LCLLanguageChangeNotification), object: nil)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    
    
  
        
        override func viewDidAppear(_ animated: Bool) {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }
    
    @objc func setText(){
        
//        roomlbl.text = "Room".localized();
//        bathroomlbl.text = "Bathroom".localized();
//        spacelbl.text = "Space".localized();
//        floorslbl.text = "Floors".localized();
        
        self.navItem.title = "Search results".localized();

        
        
    }
    
    @IBAction func dismiss(_ sender: Any) {
       print("sesrdfgfhgfgjhghj")
              
              let vc = self.navigationController?.viewControllers.first
              if vc == self.navigationController?.visibleViewController {
                  print("yes")
                  DispatchQueue.main.async
                           {
                
           
                               let homePage = self.storyboard?.instantiateViewController(withIdentifier: "initialVC")
           
                               self.appDelegate.window?.rootViewController = homePage
                       }


              }else{
                  navigationController?.popViewController(animated: true)
                  print("NO")


              }
    }
    
    func loadData(Parameters:[String: String]){
        SVProgressHUD.show()
        let url = "https://www.wasataa.com/api/RealEstate/RealEstateWithFilters"
        page = page + 1
//        let parameters = ["Lang":langstring,
//                          "page": pageStr,] as [String : Any]
        
        //?PropertyClass=27&PropertyType=22&Country=164&City=1&Rooms=35+&Baths=34+&FromPrice=0&ToPrice=90000&FromSize=0&ToSize=1000&page=1&Lang=ar
        
        
        



        
        
      
        
        print("paraparapara\(Parameters)")
        
        Alamofire.request(url,method: .get,parameters: Parameters ?? [:])
            .responseJSON { response in
                switch response.result {
                case .success:
                    let responseResult = JSON(response.result.value!)

                     let data = responseResult["results"].arrayValue
                        self.lbl_no_data.isHidden = true
                    
                       
                        for i in data{

                            self.objects.append(i.dictionary!)
                        }
                        self.ResultsTable.reloadData()
                    
                      let datastring = responseResult["results"].stringValue
                    if datastring != "" {
                        self.lbl_no_data.isHidden = false
                        self.lbl_no_data.text = "There is no results".localized()
                    }
                    
                        SVProgressHUD.dismiss()
                        
                    
                case .failure(let error):
                    print("******** \(error.localizedDescription) *******")
                    
                }
        }
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


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "result_cell", for: indexPath) as! SearchResultsTableViewCell
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
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//
//        if indexPath.row == objects.count - 2 {
//            loadData(Parameters: [:])
//            SVProgressHUD.dismiss()
//
//        }
//    }

    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

  

}
