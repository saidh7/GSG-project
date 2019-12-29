//
//  FilterViewController.swift
//  Wasatta
//
//  Created by Said Abdulla on 10/25/18.
//  Copyright © 2018 Said Abdulla. All rights reserved.
//

import UIKit
import DropDown
import SVProgressHUD
import Alamofire
import SwiftyJSON
import PMSuperButton
import Localize_Swift




class FilterViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    var parameters:[String: String] = [:]
    let loginVc = SignInViewController()
    let languageVC = TestLocaVC()


    let drop_choseProperty = DropDown()
    let drop_chosePropertyType = DropDown()
    let drop_choseCountry = DropDown()
    let drop_choseCity = DropDown()
    let drop_choseRooms = DropDown()
    let drop_choseBathRooms = DropDown()
    var Arr_Property: [JSON] = []
    var Arr_Property_Type: [JSON] = []
    var Arr_property_Type_Commercial: [JSON] = []
    var Arr_Property_Type_Residential: [JSON] = []
    var Arr_Country: [JSON] = []
    var Arr_City: [JSON] = []
    var Arr_Rooms: [JSON] = []
    var Arr_bathRoom: [JSON] = []
    @IBOutlet weak var btn_Property_type: PMSuperButton!
    
    @IBOutlet weak var btn_filter: UIButton!
    var Arr_rent_period: [JSON] = []
    var Arr_build_age: [JSON] = []
    var Arr_heating_exist: [JSON] = []
    var Arr_heating_one: [JSON] = []
    var Arr_heating_two: [JSON] = []
    var Arr_property_status: [JSON] = []
    var Arr_properity_owner: [JSON] = []
    var Arr_properity_floors: [JSON] = []
    var Arr_properity_currentfloors: [JSON] = []
    var Arr_properity_balcony: [JSON] = []
    var Arr_properity_furnitures: [JSON] = []
    var Arr_properity_currency: [JSON] = []
    var Arr_properity_areaunit: [JSON] = []

    let drop_rent_period = DropDown()
    let drop_build_age = DropDown()
    let drop_heating_exist = DropDown()
    let drop_heating_one = DropDown()
    let drop_heating_two = DropDown()
    let drop_property_status = DropDown()
    let drop_properity_owner = DropDown()
    let drop_properity_floors = DropDown()
    let drop_properity_currentfloor = DropDown()
    let drop_properity_balcony = DropDown()
    let drop_properity_furnitures = DropDown()
    let drop_properity_currency = DropDown()
    let drop_properity_unityype = DropDown()

    @IBOutlet weak var heatingtwoView: UIView!
    @IBOutlet weak var heatingoneView: UIView!
    @IBOutlet weak var rentperiodView: UIView!
    @IBOutlet weak var searchmore_View: UIView!
    @IBOutlet weak var btn_rent_period: PMSuperButton!
    @IBOutlet weak var btn_build_age: PMSuperButton!
    @IBOutlet weak var btn_heating_exist: PMSuperButton!
    @IBOutlet weak var btn_heating_one: PMSuperButton!
    @IBOutlet weak var btn_heating_two: PMSuperButton!
    @IBOutlet weak var btn_property_status: PMSuperButton!
    @IBOutlet weak var btn_properity_owner: PMSuperButton!
    @IBOutlet weak var btn_properity_floors: PMSuperButton!
    @IBOutlet weak var btn_properity_currentfloor: PMSuperButton!
    @IBOutlet weak var btn_properity_balcony: PMSuperButton!
    @IBOutlet weak var btn_properity_furnitures: PMSuperButton!

    @IBOutlet weak var btn_properity_currency: PMSuperButton!
    @IBOutlet weak var btn_properity_areaunit: PMSuperButton!


    @IBOutlet weak var showmoreView: UIView!
    @IBOutlet weak var showmoreBtn: UIButton!

    @IBOutlet weak var rentdurationlbl: UILabel!
    @IBOutlet weak var propcat: UILabel!
    @IBOutlet weak var propaddresslbl: UILabel!
    @IBOutlet weak var roomslbl: UILabel!
    @IBOutlet weak var bathroomslbl: UILabel!
    @IBOutlet weak var balaconalbl: UILabel!
    @IBOutlet weak var furniturelbl: UILabel!
    @IBOutlet weak var floorlbl: UILabel!
    @IBOutlet weak var currenfloorlbl: UILabel!
    @IBOutlet weak var buildingagelbl: UILabel!
    @IBOutlet weak var heatinglbl: UILabel!
    @IBOutlet weak var propstatuslbl: UILabel!
    @IBOutlet weak var propownerlbl: UILabel!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var spacelbl: UILabel!
    @IBOutlet weak var purchasebtn: UIButton!
    @IBOutlet weak var rentbtn: UIButton!
    @IBOutlet weak var currencylbl: UILabel!
    @IBOutlet weak var areaunitlbl: UILabel!
    
    @IBOutlet weak var btn_Purchase: PMSuperButton!
    
    @IBOutlet weak var btn_Country: PMSuperButton!
    
    @IBOutlet weak var btn_City: PMSuperButton!
    @IBOutlet weak var btn_Rent: PMSuperButton!
    @IBOutlet weak var navItem: UINavigationItem!

    
    @IBOutlet weak var btn_Rooms: PMSuperButton!
    
    @IBOutlet weak var btn_Bathrooms: PMSuperButton!
    @IBOutlet weak var highPriceLBL: UILabel!
    @IBOutlet weak var lowPriceLBL: UILabel!
    @IBOutlet weak var highSpaceLBL: UILabel!
    @IBOutlet weak var lowSpaceLBL: UILabel!
    @IBOutlet weak var indicatorSliderOne: AORangeSlider!
    @IBOutlet weak var indicatorSlideTwo: AORangeSlider!
    @IBOutlet weak var PropTypeTwoDropdownButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rentperiodView.isHidden = true
        self.searchmore_View.isHidden = true
       self.navigationController?.setNavigationBarHidden(true, animated: false)


        //loginVc.getDeviceLanguage()
        languageVC.getCurrentSelectedLang()

        
        loadPropertyData()
        propertySelected(Selceted: 1)
        setupIndicatorSlider()
        setupSpaceSlider()
        indicatorSliderOne.lowValue = 0
        indicatorSlideTwo.lowValue = 0
        
        
        let appearance = DropDown.appearance()
        
        appearance.cellHeight = 40
        appearance.backgroundColor = UIColor(white: 1, alpha: 1)
        appearance.selectionBackgroundColor = UIColor(red: 0.6494, green: 0.8155, blue: 1.0, alpha: 0.1)
        //        appearance.separatorColor = UIColor(white: 0.7, alpha: 0.8)
        appearance.cornerRadius = 8
        appearance.shadowColor = UIColor(white: 0.6, alpha: 1)
        appearance.shadowOpacity = 0.9
        appearance.shadowRadius = 25
        appearance.animationduration = 0.25
        appearance.textColor = .darkGray
        appearance.textFont = UIFont(name:"Tajawal-Regular",size:13)!
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
    
    @objc func setText(){
     
        let btnfilterarrtibutedstr = NSAttributedString(string: "Filter Results".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        
        
        btn_filter.setAttributedTitle(btnfilterarrtibutedstr, for: .normal)

        let btnpurchasearrtibutedstr = NSAttributedString(string: "Purchase".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        
        

              let showmore = NSAttributedString(string: "More search filters".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        
        
        showmoreBtn.setAttributedTitle(showmore, for: .normal)


        
        
        btn_Purchase.setAttributedTitle(btnpurchasearrtibutedstr, for: .normal)
        

        
        let btnrentarrtibutedstr = NSAttributedString(string: "Rent".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray])
        
        
        btn_Rent.setAttributedTitle(btnrentarrtibutedstr, for: .normal)

        
        rentdurationlbl.text = "Rent Period".localized();
        propcat.text = "Property category".localized();
        propaddresslbl.text = "Address".localized();
        roomslbl.text = "Rooms".localized();
        bathroomslbl.text = "Bathrooms".localized();
        balaconalbl.text = "Balcony".localized();
        furniturelbl.text = "Furniture".localized();
        floorlbl.text = "Floors".localized();
        currenfloorlbl.text = "Current floor".localized();
        buildingagelbl.text = "building Age".localized();
        heatinglbl.text = "Heating".localized();
        propstatuslbl.text = "Property status".localized();
        propownerlbl.text = "Property owner".localized();
        pricelbl.text = "Price".localized();
        spacelbl.text = "Space".localized();
        currencylbl.text = "Currency type".localized();
        areaunitlbl.text = "Area unit".localized();

        self.navItem.title = "Search for property".localized();



    }
    
    @IBAction func btn_Purchase_Tapped(_ sender: Any) {
        
        propertySelected(Selceted: 1)
        self.rentperiodView.isHidden = true


        
    }
    
    @IBAction func showmoreBtn_Tapped(_ sender: Any){
        
        self.searchmore_View.isHidden = false
        self.showmoreView.isHidden = true

        
    }
    
    
    
    @IBAction func filter_btn_Tapped(_ sender: Any) {
        print("hellooooo")

        let langstring = languageVC.lang
        parameters["lang"] = langstring!
        parameters["page"] = "1"
        
        
        let vc = self.navigationController?.viewControllers.first
        if vc == self.navigationController?.visibleViewController {
        print("yes")
        DispatchQueue.main.async
        {
                 
            
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "sr_vc") as! SearchResultsTableViewController

            vc.loadData(Parameters:self.parameters)

            self.appDelegate.window?.rootViewController = vc
        }


        }else{
               
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "sr_vc") as! SearchResultsTableViewController
        vc.loadData(Parameters:parameters)
        self.navigationController?.pushViewController(vc, animated: true)


               }
        
        
        

    }
    
    @IBAction func btn_Rent_Tapped(_ sender: Any) {
        propertySelected(Selceted: 2)
        self.rentperiodView.isHidden = false

        
    }
    @IBAction func PropTypeBuTapped(_ sender: Any) {
        
        //drop_choseProperty.show()
        self.drop_choseProperty.show()
        
        
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
    
    @IBAction func PropRentPeriod(_ sender: Any) {
        
        self.drop_rent_period.show()
        
        
    }

    
    @IBAction func PropTypeTwoBuTapped(_ sender: Any) {
        self.drop_chosePropertyType.show()
        
    }
    
    
    @IBAction func btn_Country_Tapped(_ sender: Any) {
        self.drop_choseCountry.show()
    }
    
    
    @IBAction func btn_City_Tapped(_ sender: Any) {
        self.drop_choseCity.show()

    }
    
    
    @IBAction func btn_Rooms_Tapped(_ sender: Any) {
        self.drop_choseRooms.show()

    }
    
    
    @IBAction func btn_Bathrooms_Tapped(_ sender: Any) {
        self.drop_choseBathRooms.show()

    }
    
    
    
    @IBAction func btn_buidingAge_Tapped(_ sender: Any) {
        self.drop_build_age.show()
        
    }
    
    
    @IBAction func btn_heatingexist_Tapped(_ sender: Any) {
        self.drop_heating_exist.show()
        
    }
    
    
    @IBAction func btn_heatingone_Tapped(_ sender: Any) {
        self.drop_heating_one.show()
        
    }
    
    
    @IBAction func btn_heatingtwo_Tapped(_ sender: Any) {
        self.drop_heating_two.show()
        
    }
    
    
    @IBAction func btn_properitystatus_Tapped(_ sender: Any) {
        self.drop_property_status.show()
        
    }
    
    @IBAction func btn_properitypwner_Tapped(_ sender: Any) {
        self.drop_properity_owner.show()
        
    }
    
    
    @IBAction func btn_floors_Tapped(_ sender: Any) {
        self.drop_properity_currentfloor.show()

    }
    
    @IBAction func btn_currentfloor_Tapped(_ sender: Any) {
        self.drop_properity_floors.show()

        
    }
    
    
    
    @IBAction func btn_balcony_Tapped(_ sender: Any) {
        self.drop_properity_balcony.show()
        
    }
    
    
    @IBAction func btn_furnitures_Tapped(_ sender: Any) {
        self.drop_properity_furnitures.show()
        
    }
    
    
    @IBAction func btn_currency_Tapped(_ sender: Any) {
        
              self.drop_properity_currency.show()

        
     }
    
    
    @IBAction func btn_areaunit_Tapped(_ sender: Any) {

        self.drop_properity_unityype.show()

     }
    
    


    
    
    
    
    func propertySelected(Selceted:Int){
        switch Selceted {
        case 1:
            btn_Purchase.backgroundColor = #colorLiteral(red: 0.6431372549, green: 0.5019607843, blue: 0.262745098, alpha: 1)
            //btn_Purchase.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            
            let btnurchasearrtibutedstr = NSAttributedString(string: "Purchase".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
            
            
            btn_Purchase.setAttributedTitle(btnurchasearrtibutedstr, for: .normal)
            btn_Rent.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            //btn_Rent.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
            
            let btnrentarrtibutedstr = NSAttributedString(string: "Rent".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray])
            
            
            btn_Rent.setAttributedTitle(btnrentarrtibutedstr, for: .normal)
            parameters["PropertyClass"] = "26"
            break
        case 2:
            btn_Purchase.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
          //  btn_Purchase.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
            let btnurchasearrtibutedstr = NSAttributedString(string: "Purchase".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray])
            
            
            btn_Purchase.setAttributedTitle(btnurchasearrtibutedstr, for: .normal)

            btn_Rent.backgroundColor = #colorLiteral(red: 0.6431372549, green: 0.5019607843, blue: 0.262745098, alpha: 1)
           // btn_Rent.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            
            let btnrentarrtibutedstr = NSAttributedString(string: "Rent".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
            
            
            btn_Rent.setAttributedTitle(btnrentarrtibutedstr, for: .normal)
            parameters["PropertyClass"] = "27"
            break
        default:
            break
        }
    }
    
    
    func loadPropertyData(){
        SVProgressHUD.show()
        let url = "https://www.wasataa.com/api/RealEstate/PropertyRealEstateForSearch"
        let langstring = languageVC.lang
        let parameterss = ["Lang":langstring!
            ] as [String : Any]
        Alamofire.request(url,method: .get,parameters: parameterss)
            .responseJSON { response in
                switch response.result {
                case .success:
                    let responseResult = JSON(response.result.value!)
                    if let data = responseResult.dictionary{
                        
                    
                        
                        if let comme_prop = data["propertyTypeCommercial"]?.array{
                            self.Arr_property_Type_Commercial = comme_prop
                        }
                        if let resi_prop = data["propertyTypeResidential"]?.array{
                            self.Arr_Property_Type_Residential = resi_prop
                        }
                        if let property_class = data["propertyClass"]?.array{
                            self.Arr_Property_Type = property_class
                        }
                        if let property_type = data["propertyType"]?.array{
                            self.Arr_Property = property_type
                            self.setupProperty_TypeDrop(data:(self.Arr_Property_Type_Residential))
                            self.setupPropertyDrop()
                        }
                        
                        if let country = data["country"]?.array{
                            self.Arr_Country = country
                            self.btn_Country.setTitle(country[0]["name"].stringValue, for: .normal)
                            self.parameters["Country"] = self.Arr_Country[0]["id"].stringValue
                            self.loadCityData(id: self.Arr_Country[0]["id"].stringValue)
                        }
                        
                        if let rooms = data["room"]?.array{
                            self.Arr_Rooms = rooms
                        }
                        
                        if let rentperiod = data["leaseTerm"]?.array{
                            self.Arr_rent_period = rentperiod
                        }
                        
                        if let buildage = data["buildAge"]?.array{
                            self.Arr_build_age = buildage
                        }
                        
                        if let heating = data["heating"]?.array{
                            self.Arr_heating_exist = heating
                        }
                        
                        if let heatingone = data["heatingType"]?.array{
                            self.Arr_heating_one = heatingone
                        }
                        
                        
                        if let heatingtwo = data["heatingDistribution"]?.array{
                            self.Arr_heating_two = heatingtwo
                        }
                        
                        
                        if let propStatus = data["usageStatus"]?.array{
                            self.Arr_property_status = propStatus
                        }
                        
                        
                        if let propowner = data["whoOwnerAds"]?.array{
                            self.Arr_properity_owner = propowner
                        }
                        
                        if let floors = data["floor"]?.array{
                            self.Arr_properity_floors = floors
                        }
                        
                        if let currentfloor = data["floorsNumber"]?.array{
                            self.Arr_properity_currentfloors = currentfloor
                        }
                        
                        if let balcony = data["porch"]?.array{
                            self.Arr_properity_balcony = balcony
                        }
                        
                        if let furnitures = data["furniture"]?.array{
                            self.Arr_properity_furnitures = furnitures
                        }
                        
                        
                        if let currency = data["priceType"]?.array{
                          self.Arr_properity_currency = currency
                         }

                        if let areaunit = data["unitArea"]?.array{
                        self.Arr_properity_areaunit = areaunit
                        }
                        



                        
                        if let bathrooms = data["bathRoom"]?.array{
                            self.Arr_bathRoom = bathrooms
                        }

                        self.setupCoutryDrop()
                        self.setupRoomsDrop()
                        self.setupBathRoomsDrop()
                        self.setupPropertyRentPeriod()
                        self.setupbuidingAge()
                        self.setupheatingexist()
                        self.setupheatingone()
                        self.setupheatingtwo()
                        self.setuppropStatus()
                        self.setuppropOwner()
                        self.setuppropfloors()
                        self.setuppropcurrentfloors()
                        self.setuppropbalcony()
                        self.setuppropcurrentfurnitures()
                        
                        self.setuppropcurrency()
                        self.setuppropcurrentareaunit()

                    }
                    
                    SVProgressHUD.dismiss()
                    
                    
                case .failure(let error):
                    print("******** \(error.localizedDescription) *******")
                    
                }
        }
    }
    
 
    func loadCityData(id:String){
        SVProgressHUD.show()
        let url = "https://www.wasataa.com/api/RealEstate/GetCity"
        let langstring = languageVC.lang
        let parameterss = ["Country":id,
                           "lang": langstring!
            ] as [String : Any]
        Alamofire.request(url,method: .get,parameters: parameterss)
            .responseJSON { response in
                switch response.result {
                case .success:
                    let responseResult = JSON(response.result.value!)
                    if let data = responseResult.dictionary{
                        if let city = data["data"]?.array{
                            self.parameters["City"] = city[0]["id"].stringValue
                            self.Arr_City = city
                            self.setupCitiesDrop()
                        }
                        
                        SVProgressHUD.dismiss()
                        
                    }
                case .failure(let error):
                    print("******** \(error.localizedDescription) *******")
                    
                }
        }
    }
    
    func setupCitiesDrop() {
        
        
        drop_choseCity.anchorView = btn_City
        
        let lang = languageVC.lang
        
        if lang == "ar"{
            drop_choseCity.anchorView = btn_Country
            drop_choseCity.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }

           

        
        }
        
        
        drop_choseCity.bottomOffset = CGPoint(x: 0, y: btn_City.bounds.height)
        
        
        var BranchNames = [String]()
        for item in Arr_City {
            
            BranchNames.append("\(item["name"].stringValue )")
            
        }
        self.parameters["City"] = self.Arr_City[0]["id"].stringValue
        self.btn_City.setTitle(BranchNames[0], for: .normal)
        
        drop_choseCity.dataSource = BranchNames
        
        
        drop_choseCity.selectionAction = { [weak self] (index, item) in
            self?.parameters["City"] = self?.Arr_City[index]["id"].stringValue
            self?.btn_City.setTitle(item, for: .normal)
            
        }
        

        
        
    }
    
    func setupDropDownAppreance(){
        
        let appearance = DropDown.appearance()
        
        appearance.cellHeight = 60
        appearance.backgroundColor = UIColor(white: 1, alpha: 1)
        appearance.selectionBackgroundColor = UIColor(red: 0.6494, green: 0.8155, blue: 1.0, alpha: 0.2)
        //        appearance.separatorColor = UIColor(white: 0.7, alpha: 0.8)
        appearance.cornerRadius = 10
        appearance.shadowColor = UIColor(white: 0.6, alpha: 1)
        appearance.shadowOpacity = 0.9
        appearance.shadowRadius = 25
        appearance.animationduration = 0.25
        appearance.textColor = .darkGray
    
    }
    
    

    
    
    
    
    func setupPropertyRentPeriod() {
        drop_rent_period.anchorView = btn_rent_period
        let lang = languageVC.lang
        if lang == "ar"{
            drop_rent_period.anchorView = btn_rent_period
            drop_rent_period.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }

            
        }
        
        
        drop_rent_period.bottomOffset = CGPoint(x: 0, y: drop_rent_period.bounds.height)
        
        
        var BranchNames = [String]()
        for item in Arr_rent_period {
            
            BranchNames.append("\(item["name"].stringValue )")
            
        }
        self.btn_rent_period.setTitle(BranchNames[0], for: .normal)
        drop_rent_period.dataSource = BranchNames
        
        
        drop_rent_period.selectionAction = { [weak self] (index, item) in
            
            self?.btn_rent_period.setTitle(item, for: .normal)
            self?.parameters["leaseTerm"] = self?.Arr_rent_period[index]["id"].stringValue
            
        }
        
        
    }
    
    
    func setupheatingone() {
        drop_heating_one.anchorView = btn_heating_one
        let lang = languageVC.lang
        if lang == "ar"{
            drop_heating_one.anchorView = btn_heating_one
            drop_heating_one.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }

            
        }
        
        
        drop_heating_one.bottomOffset = CGPoint(x: 0, y: drop_heating_one.bounds.height)
        
        
        var BranchNames = [String]()
        for item in Arr_heating_one {
            
            BranchNames.append("\(item["name"].stringValue )")
            
        }
        self.btn_heating_one.setTitle(BranchNames[0], for: .normal)
        drop_heating_one.dataSource = BranchNames
        
        
        drop_heating_one.selectionAction = { [weak self] (index, item) in
            
            self?.btn_heating_one.setTitle(item, for: .normal)
            self?.parameters["heatingType"] = self?.Arr_heating_one[index]["id"].stringValue
            
        }
        
        
    }
    
    
    func setupheatingtwo() {
        drop_heating_two.anchorView = btn_heating_two
        let lang = languageVC.lang
        if lang == "ar"{
            drop_heating_two.anchorView = btn_heating_two
            drop_heating_two.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }

            
        }
        
        
        drop_heating_two.bottomOffset = CGPoint(x: 0, y: drop_heating_two.bounds.height)
        
        
        var BranchNames = [String]()
        for item in Arr_heating_two {
            
            BranchNames.append("\(item["name"].stringValue )")
            
        }
        self.btn_heating_two.setTitle(BranchNames[0], for: .normal)
        drop_heating_two.dataSource = BranchNames
        
        
        drop_heating_two.selectionAction = { [weak self] (index, item) in
            
            self?.btn_heating_two.setTitle(item, for: .normal)
            self?.parameters["heatingDistribution"] = self?.Arr_heating_two[index]["id"].stringValue
            
        }
        
        
    }
    
    
    func setuppropfloors() {
        drop_properity_floors.anchorView = btn_properity_currentfloor
        let lang = languageVC.lang
        if lang == "ar"{
            drop_properity_floors.anchorView = btn_properity_floors
            drop_properity_floors.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }

            
        }
        
        
        drop_properity_floors.bottomOffset = CGPoint(x: 0, y: drop_properity_floors.bounds.height)
        
        
        var BranchNames = [String]()
        for item in Arr_properity_floors {
            
            BranchNames.append("\(item["name"].stringValue )")
            
        }
        self.btn_properity_floors.setTitle(BranchNames[0], for: .normal)
        drop_properity_floors.dataSource = BranchNames
        
        
        drop_properity_floors.selectionAction = { [weak self] (index, item) in
            
            self?.btn_properity_floors.setTitle(item, for: .normal)
            self?.parameters["floor"] = self?.Arr_properity_floors[index]["id"].stringValue
            
        }
        
        
    }

    func setuppropcurrentfloors() {
        drop_properity_currentfloor.anchorView = btn_properity_floors
        let lang = languageVC.lang
        if lang == "ar"{
            drop_properity_currentfloor.anchorView = btn_properity_currentfloor
            drop_properity_currentfloor.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }

            
        }
        
        
        drop_properity_currentfloor.bottomOffset = CGPoint(x: 0, y: drop_properity_currentfloor.bounds.height)
        
        
        var BranchNames = [String]()
        for item in Arr_properity_currentfloors {
            
            BranchNames.append("\(item["name"].stringValue )")
            
        }
        self.btn_properity_currentfloor.setTitle(BranchNames[0], for: .normal)
        drop_properity_currentfloor.dataSource = BranchNames
        
        
        drop_properity_currentfloor.selectionAction = { [weak self] (index, item) in
            
            self?.btn_properity_currentfloor.setTitle(item, for: .normal)
            self?.parameters["floorsNumber"] = self?.Arr_properity_currentfloors[index]["id"].stringValue
            
        }
        
        
    }
    
    func setuppropbalcony() {
        drop_properity_balcony.anchorView = btn_properity_balcony
        let lang = languageVC.lang
        if lang == "ar"{
            drop_properity_balcony.anchorView = btn_properity_furnitures
            drop_properity_balcony.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }

            
        }
        
        
        drop_properity_balcony.bottomOffset = CGPoint(x: 0, y: drop_properity_balcony.bounds.height)
        
        
        var BranchNames = [String]()
        for item in Arr_properity_balcony {
            
            BranchNames.append("\(item["name"].stringValue )")
            
        }
        self.btn_properity_balcony.setTitle(BranchNames[0], for: .normal)
        drop_properity_balcony.dataSource = BranchNames
        
        
        drop_properity_balcony.selectionAction = { [weak self] (index, item) in
            
            self?.btn_properity_balcony.setTitle(item, for: .normal)
            self?.parameters["porch"] = self?.Arr_properity_balcony[index]["id"].stringValue
            
        }
        
        
    }
    
    
    func setuppropcurrentfurnitures() {
        drop_properity_furnitures.anchorView = btn_properity_furnitures
        let lang = languageVC.lang
        if lang == "ar"{
            drop_properity_furnitures.anchorView = btn_properity_balcony
            drop_properity_furnitures.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }

            
        }
        
        
        drop_properity_furnitures.bottomOffset = CGPoint(x: 0, y: drop_properity_furnitures.bounds.height)
        
        
        var BranchNames = [String]()
        for item in Arr_properity_furnitures {
            
            BranchNames.append("\(item["name"].stringValue )")
            
        }
        self.btn_properity_furnitures.setTitle(BranchNames[0], for: .normal)
        drop_properity_furnitures.dataSource = BranchNames
        
        
        drop_properity_furnitures.selectionAction = { [weak self] (index, item) in
            
            self?.btn_properity_furnitures.setTitle(item, for: .normal)
            self?.parameters["furniture"] = self?.Arr_properity_furnitures[index]["id"].stringValue
            
        }
        
        
    }

    
    
    func setuppropcurrency() {
        drop_properity_currency.anchorView = btn_properity_currency
        let lang = languageVC.lang
        if lang == "ar"{
            drop_properity_currency.anchorView = btn_properity_areaunit
            drop_properity_currency.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }

            
        }
        
        
        drop_properity_currency.bottomOffset = CGPoint(x: 0, y: drop_properity_currency.bounds.height)
        
        
        var BranchNames = [String]()
        for item in Arr_properity_currency {
            
            BranchNames.append("\(item["name"].stringValue )")
            
        }
        self.btn_properity_currency.setTitle(BranchNames[0], for: .normal)
        drop_properity_currency.dataSource = BranchNames
        
        
        drop_properity_currency.selectionAction = { [weak self] (index, item) in
            
            self?.btn_properity_currency.setTitle(item, for: .normal)
            self?.parameters["priceType"] = self?.Arr_properity_currency[index]["id"].stringValue
            
        }
        
        
    }
    
    
    
    func setuppropcurrentareaunit() {
           drop_properity_unityype.anchorView = btn_properity_areaunit
           let lang = languageVC.lang
           if lang == "ar"{
               drop_properity_unityype.anchorView = btn_properity_currency
               drop_properity_unityype.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }

               
           }
           
           
           drop_properity_unityype.bottomOffset = CGPoint(x: 0, y: drop_properity_unityype.bounds.height)
           
           
           var BranchNames = [String]()
           for item in Arr_properity_areaunit {
               
               BranchNames.append("\(item["name"].stringValue )")
               
           }
           self.btn_properity_areaunit.setTitle(BranchNames[0], for: .normal)
           drop_properity_unityype.dataSource = BranchNames
           
           
           drop_properity_unityype.selectionAction = { [weak self] (index, item) in
               
               self?.btn_properity_areaunit.setTitle(item, for: .normal)
               self?.parameters["unitArea"] = self?.Arr_properity_areaunit[index]["id"].stringValue
               
           }
           
           
       }


    
    


    func setuppropStatus() {
        drop_property_status.anchorView = btn_property_status
        let lang = languageVC.lang
        if lang == "ar"{
            drop_property_status.anchorView = btn_property_status
            drop_property_status.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }

            
        }
        
        
        drop_property_status.bottomOffset = CGPoint(x: 0, y: drop_property_status.bounds.height)
        
        
        var BranchNames = [String]()
        for item in Arr_property_status {
            
            BranchNames.append("\(item["name"].stringValue )")
            
        }
        self.btn_property_status.setTitle(BranchNames[0], for: .normal)
        drop_property_status.dataSource = BranchNames
        
        
        drop_property_status.selectionAction = { [weak self] (index, item) in
            
            self?.btn_property_status.setTitle(item, for: .normal)
            self?.parameters["usageStatus"] = self?.Arr_property_status[index]["id"].stringValue
            
        }
        
        
    }


    func setupPropertyDrop() {
        drop_choseProperty.anchorView = btn_Property_type
let lang = languageVC.lang
        if lang == "ar"{
            drop_choseProperty.anchorView = PropTypeTwoDropdownButton
            drop_choseProperty.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }


        }
        
        
        drop_choseProperty.bottomOffset = CGPoint(x: 0, y: btn_Property_type.bounds.height)
        
        
        var BranchNames = [String]()
        for item in Arr_Property {
            
            BranchNames.append("\(item["name"].stringValue )")
            
        }
        self.btn_Property_type.setTitle(BranchNames[0], for: .normal)
        drop_choseProperty.dataSource = BranchNames
        
        
        drop_choseProperty.selectionAction = { [weak self] (index, item) in
//            self?.parameters["PropertyClass"] = self?.Arr_Property[index]["id"].stringValue
            self?.btn_Property_type.setTitle(item, for: .normal)
            if index == 0{
                self?.setupProperty_TypeDrop(data:(self?.Arr_Property_Type_Residential)!)
            }else{
                self?.setupProperty_TypeDrop(data:(self?.Arr_property_Type_Commercial)!)
            }
            
        }
        
        
    }

    func setupProperty_TypeDrop(data:[JSON]) {
        
        drop_chosePropertyType.anchorView = PropTypeTwoDropdownButton
        let lang = languageVC.lang
        if lang == "ar"{
            drop_chosePropertyType.anchorView = btn_Property_type
            drop_chosePropertyType.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }

            
        }
        
        drop_chosePropertyType.bottomOffset = CGPoint(x: 0, y: PropTypeTwoDropdownButton.bounds.height)
        
        
        var BranchNames = [String]()
        for item in data {
            
            BranchNames.append("\(item["name"].stringValue )")
            
        }
        self.parameters["PropertyType"] = data[0]["id"].stringValue
        self.PropTypeTwoDropdownButton.setTitle(BranchNames[0], for: .normal)
        drop_chosePropertyType.dataSource = BranchNames
        
        
        drop_chosePropertyType.selectionAction = { [weak self] (index, item) in
            self?.parameters["PropertyType"] = data[index]["id"].stringValue
            self?.PropTypeTwoDropdownButton.setTitle(item, for: .normal)
            
        }
        
        
    }
    
    func setup_propertyClass(){
        
    }
    
   
    
    func setupCoutryDrop() {
        
        
        drop_choseCountry.anchorView = btn_Country
        
        let lang = languageVC.lang
        
        if lang == "ar"{
            drop_choseCountry.anchorView = btn_City
            drop_choseCountry.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }

            
        }
        
        
        drop_choseCountry.bottomOffset = CGPoint(x: 0, y: btn_Country.bounds.height)
        
        
        var BranchNames = [String]()
        for item in (Arr_Country) {
            BranchNames.append("\(item["name"].stringValue )")
            
        }
        self.btn_Country.setTitle(BranchNames[0], for: .normal)
        
        drop_choseCountry.dataSource = BranchNames
        
        
        drop_choseCountry.selectionAction = { [weak self] (index, item) in
            
            //  let stringArray = item.split(separator: "-")
            self?.btn_Country.setTitle(item, for: .normal)
            self?.parameters["Country"] = self?.Arr_Country[index]["id"].stringValue
            self?.loadCityData(id: self?.Arr_Country[index]["id"].stringValue ?? "0" )
            
        }
        
        
    }
    
    func setupbuidingAge() {
        
        
        drop_build_age.anchorView = btn_build_age
        let lang = languageVC.lang
        if lang == "ar"{
            drop_build_age.anchorView = btn_build_age
            drop_build_age.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }

            
        }
        
        
        drop_build_age.bottomOffset = CGPoint(x: 0, y: btn_build_age.bounds.height)
        
        
        var BranchNames = [String]()
        for item in Arr_build_age {
            
            BranchNames.append("\(item["name"].stringValue )")
            
        }
        self.btn_build_age.setTitle(BranchNames[0], for: .normal)
        drop_build_age.dataSource = BranchNames
        
        
        drop_build_age.selectionAction = { [weak self] (index, item) in
            
            self?.btn_build_age.setTitle(item, for: .normal)
            self?.parameters["buildAge"] = self?.Arr_build_age[index]["id"].stringValue
            
        }
        
        
        
        
        
        
        
        
        
    }

    func setupheatingexist() {
        
        
        drop_heating_exist.anchorView = btn_heating_exist
        let lang = languageVC.lang
        if lang == "ar"{
            drop_heating_exist.anchorView = btn_heating_exist
            drop_heating_exist.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }

            
        }
        
        
        drop_heating_exist.bottomOffset = CGPoint(x: 0, y: btn_heating_exist.bounds.height)
        
        
        var BranchNames = [String]()
        for item in Arr_heating_exist {
            
            BranchNames.append("\(item["name"].stringValue )")
            
        }
        self.btn_heating_exist.setTitle(BranchNames[0], for: .normal)
        drop_heating_exist.dataSource = BranchNames
        
        
        drop_heating_exist.selectionAction = { [weak self] (index, item) in
            
            self?.btn_heating_exist.setTitle(item, for: .normal)
            self?.parameters["heating"] = self?.Arr_heating_exist[index]["id"].stringValue
            
            
            if self?.drop_heating_exist.indexForSelectedRow == 2 { // Int?
            
            print("Selected item: \(item) at index: \(index)")
                
                self?.heatingoneView.isHidden = true
                self?.heatingtwoView.isHidden = true
                  self?.parameters["heating"] = self?.Arr_heating_exist[index]["id"].stringValue


                
            }else{
                self?.heatingoneView.isHidden = false
                self?.heatingtwoView.isHidden = false
                 self?.parameters["heating"] = self?.Arr_heating_exist[index]["id"].stringValue
                
            }


            
//
//            for i in self.Arr_heating_exist{
//
//            }
            
        }
        
        
        
        
        
        
        
        
        
    }
    
    func setuppropOwner() {
        
        
        drop_properity_owner.anchorView = btn_properity_owner
        let lang = languageVC.lang
        if lang == "ar"{
            drop_properity_owner.anchorView = btn_properity_owner
            drop_properity_owner.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }

            
        }
        
        
        drop_properity_owner.bottomOffset = CGPoint(x: 0, y: btn_properity_owner.bounds.height)
        
        
        var BranchNames = [String]()
        for item in Arr_properity_owner {
            
            BranchNames.append("\(item["name"].stringValue )")
            
        }
        self.btn_properity_owner.setTitle(BranchNames[0], for: .normal)
        drop_properity_owner.dataSource = BranchNames
        
        
        drop_properity_owner.selectionAction = { [weak self] (index, item) in
            
            self?.btn_properity_owner.setTitle(item, for: .normal)
            self?.parameters["whoOwnerAds"] = self?.Arr_properity_owner[index]["id"].stringValue
            
        }
        
        
        
        
        
        
        
        
        
    }

    func setupRoomsDrop() {
        
        
        drop_choseRooms.anchorView = btn_Rooms
        let lang = languageVC.lang

        if lang == "ar"{
            drop_choseRooms.anchorView = btn_Bathrooms
            drop_choseRooms.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }

            
        }
        
        drop_choseRooms.bottomOffset = CGPoint(x: 0, y: btn_Rooms.bounds.height)
        
        
        var BranchNames = [String]()
        for item in Arr_Rooms {
            
            BranchNames.append("\(item["name"].stringValue )")
            
        }
        self.parameters["Rooms"] = self.Arr_Rooms[0]["id"].stringValue
        self.btn_Rooms.setTitle(BranchNames[0], for: .normal)
        drop_choseRooms.dataSource = BranchNames
        
        
        drop_choseRooms.selectionAction = { [weak self] (index, item) in
            
            self?.btn_Rooms.setTitle(item, for: .normal)
            self?.parameters["Rooms"] = self?.Arr_Rooms[index]["id"].stringValue
            
        }
        
        
    }
    
    func setupBathRoomsDrop() {
        
        
        drop_choseBathRooms.anchorView = btn_Bathrooms
        let lang = languageVC.lang

        if lang == "ar"{
            drop_choseBathRooms.anchorView = btn_Rooms
            drop_choseBathRooms.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }

            
        }

        
        drop_choseBathRooms.bottomOffset = CGPoint(x: 0, y: btn_Bathrooms.bounds.height)
        
        
        var BranchNames = [String]()
        for item in Arr_bathRoom {
            
            BranchNames.append("\(item["name"].stringValue )")
            
        }
        self.parameters["Baths"] = self.Arr_bathRoom[0]["id"].stringValue
        self.btn_Bathrooms.setTitle(BranchNames[0], for: .normal)
        drop_choseBathRooms.dataSource = BranchNames
        
        
        drop_choseBathRooms.selectionAction = { [weak self] (index, item) in
            
            self?.btn_Bathrooms.setTitle(item, for: .normal)
            self?.parameters["Baths"] = self?.Arr_bathRoom[index]["id"].stringValue
            
            
        }
        
        
    }
    

    
    func setupIndicatorSlider() {
        indicatorSliderOne.trackBackgroundImage = #imageLiteral(resourceName: "hollowProgress").resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
        indicatorSliderOne.trackImage = #imageLiteral(resourceName: "solidProgress").resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
        indicatorSliderOne.lowHandleImageNormal = #imageLiteral(resourceName: "custom-handle")
        indicatorSliderOne.lowHandleImageHighlighted = #imageLiteral(resourceName: "custom-handle")
        indicatorSliderOne.highHandleImageNormal = #imageLiteral(resourceName: "custom-handle")
        indicatorSliderOne.highHandleImageHighlighted = #imageLiteral(resourceName: "custom-handle")
//
//        indicatorSliderOne.minimumValue = 0
//        indicatorSliderOne.maximumValue = 5000000
//        indicatorSliderOne.lowValue = 0
//        indicatorSliderOne.highValue = 500
//        indicatorSliderOne.minimumDistance = 500
        
        indicatorSliderOne.minimumValue = 0
        indicatorSliderOne.maximumValue = 1000000
        indicatorSliderOne.lowValue = 0
        indicatorSliderOne.highValue = 1000000
        indicatorSliderOne.minimumDistance = 500
        

        
        
        let lowLabel = lowPriceLBL
        let highLabel = highPriceLBL
        self.parameters["FromPrice"] = "0"
        self.parameters["ToPrice"] = "1000000"
        indicatorSliderOne.valuesChangedHandler = { [weak self] in
            guard let `self` = self else {
                return
            }
         
            
            self.parameters["FromPrice"] = String(format: "%.0f", self.indicatorSliderOne.lowValue)
            self.parameters["ToPrice"] = String(format: "%.0f", self.indicatorSliderOne.highValue)
            
            lowLabel?.text = String(format: "%.0f", self.indicatorSliderOne.lowValue)
           
            highLabel?.text = String(format: "%.0f", self.indicatorSliderOne.highValue)
        }
        
        // + "$"
        // + "$"
        
    }
    
    
    func setupSpaceSlider() {
        
        
        
        indicatorSlideTwo.trackBackgroundImage = #imageLiteral(resourceName: "hollowProgress").resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
        indicatorSlideTwo.trackImage = #imageLiteral(resourceName: "solidProgress").resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
        
        indicatorSlideTwo.lowHandleImageNormal = #imageLiteral(resourceName: "custom-handle")
        indicatorSlideTwo.lowHandleImageHighlighted = #imageLiteral(resourceName: "custom-handle")
        indicatorSlideTwo.highHandleImageNormal = #imageLiteral(resourceName: "custom-handle")
        indicatorSlideTwo.highHandleImageHighlighted = #imageLiteral(resourceName: "custom-handle")
        
//        indicatorSlideTwo.minimumValue = 0
//        indicatorSlideTwo.maximumValue = 10000
//        indicatorSlideTwo.lowValue = 0
//        indicatorSlideTwo.highValue = 500
//        indicatorSlideTwo.minimumDistance = 500
        
        indicatorSlideTwo.minimumValue = 0
        indicatorSlideTwo.maximumValue = 2000
        indicatorSlideTwo.lowValue = 0
        indicatorSlideTwo.highValue = 2000
        indicatorSlideTwo.minimumDistance = 200

        let lowSpaceLabel = lowSpaceLBL
        let highSpaceLabel = highSpaceLBL
        self.parameters["FromSize"] = "0"
        self.parameters["ToSize"] = "2000"
        indicatorSlideTwo.valuesChangedHandler = { [weak self] in
            guard let `self` = self else {
                return
            }
            self.parameters["FromSize"] = String(format: "%.0f", self.indicatorSlideTwo.lowValue)
            self.parameters["ToSize"] = String(format: "%.0f", self.indicatorSlideTwo.highValue)
            lowSpaceLabel?.text = String(format: "%.0f", self.indicatorSlideTwo.lowValue)
            highSpaceLabel?.text = String(format: "%.0f", self.indicatorSlideTwo.highValue)
            
            // + "sm"
            // + "sm"
        }
        
    }
    

}


class LocalizedButton : UIButton {
    @IBInspectable var localizedTitle : String = "" {
        didSet {
            self.setTitle(localizedTitle.localized, for: .normal)
        }
    }

}
