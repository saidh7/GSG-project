//
//  AddPropertyVC.swift
//  Wasatta
//
//  Created by Ahmed Alaloul on 12/11/18.
//  Copyright © 2018 Said Abdulla. All rights reserved.
//

import UIKit
import FlexibleSteppedProgressBar
import SwiftyDrop
import Photos
import AVKit
import DKImagePickerController
import SKRadioButton
import GoogleMaps
import GooglePlaces
import SVProgressHUD
import Alamofire
import SwiftyJSON
import DropDown
import PMSuperButton
import CoreLocation
import PMSuperButton
import Localize_Swift


class EditPropertyVC: UIViewController, FlexibleSteppedProgressBarDelegate,UIImagePickerControllerDelegate , UINavigationControllerDelegate, GMSMapViewDelegate  {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    // Second Screen
    let loginVc = SignInViewController()
    let languageVC = TestLocaVC()
    
    var locationManager:CLLocationManager!
          var currentLocation = CLLocationCoordinate2D(latitude: 24.7440459, longitude:  46.733871)
       var userLocationMarker = GMSMarker()

    var selectedID:String!
    @IBOutlet weak var txt_price: UITextField!
    @IBOutlet weak var txt_details: UITextView!
    @IBOutlet weak var mapView: GMSMapView!
    var location: CLLocationCoordinate2D?
    @IBOutlet weak var txt_Place: UITextField!
    @IBOutlet weak var btn_Property_Sub: PMSuperButton!
    @IBOutlet weak var btn_Property_type: PMSuperButton!
    @IBOutlet weak var btn_rent_Selected: PMSuperButton!
    @IBOutlet weak var btn_purchases: PMSuperButton!
    @IBOutlet weak var btn_duration: PMSuperButton!
    @IBOutlet weak var btn_Empty: PMSuperButton!
    @IBOutlet weak var btn_Rented: PMSuperButton!
    @IBOutlet weak var btn_HomeOwner: PMSuperButton!
    
    
    let drop_choseDuration = DropDown()
    let drop_choseProperty = DropDown()
    let drop_chosePropertyType = DropDown()
    var Arr_Lease: [JSON] = []
    var Arr_Property: [JSON] = []
    var Arr_Property_Type: [JSON] = []
    var Arr_property_Type_Commercial: [JSON] = []
    var Arr_Property_Type_Residential: [JSON] = []
    // Third Screen
    @IBOutlet weak var propertyFirstStackView: UIStackView!
    
    @IBOutlet weak var maintitle1: UILabel!
    @IBOutlet weak var subtitle1: UILabel!
    @IBOutlet weak var maintitle2: UILabel!
    @IBOutlet weak var subtitle2: UILabel!
    @IBOutlet weak var maintitle3: UILabel!
    @IBOutlet weak var subtitle3: UILabel!
    @IBOutlet weak var maintitle4: UILabel!
    @IBOutlet weak var subtitle4: UILabel!
    @IBOutlet weak var maintitle5: UILabel!
    @IBOutlet weak var subtitle5: UILabel!
    @IBOutlet weak var maintitle6: UILabel!
    @IBOutlet weak var subtitle6: UILabel!
    @IBOutlet weak var lbl_datails: UILabel!
    
    @IBOutlet weak var propcat1: UILabel!
    @IBOutlet weak var propcat2: UILabel!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var spacelbl: UILabel!
    @IBOutlet weak var ownerlbl: UILabel!
    @IBOutlet weak var propstatuslbl: UILabel!
    @IBOutlet weak var propagelbl: UILabel!
    @IBOutlet weak var profloorlbl: UILabel!
    @IBOutlet weak var procurrentfloorlbl: UILabel!
    @IBOutlet weak var proroomslbl: UILabel!
    @IBOutlet weak var probathroomslbl: UILabel!
    @IBOutlet weak var heatinglbl: UILabel!
    @IBOutlet weak var heatingtyle1lbl: UILabel!
    @IBOutlet weak var heatingtyle2lbl: UILabel!
    @IBOutlet weak var furniturelbl: UILabel!
    @IBOutlet weak var elivatorlbl: UILabel!
    @IBOutlet weak var poollbl: UILabel!
    @IBOutlet weak var balconaaaalbl: UILabel!
    @IBOutlet weak var cleaninglbl: UILabel!
    @IBOutlet weak var internetlbl: UILabel!
    @IBOutlet weak var hallllbl: UILabel!
    @IBOutlet weak var entertaymentssslbl: UILabel!
    @IBOutlet weak var parkinglbl: UILabel!
    @IBOutlet weak var countrylbl: UILabel!
    @IBOutlet weak var citylbl: UILabel!
    @IBOutlet weak var lblCurency: UILabel!
    @IBOutlet weak var lblSpaceunit: UILabel!
    
    
    
    @IBOutlet weak var letscontinue: UIButton!
    @IBOutlet weak var next1: UIButton!
    @IBOutlet weak var back1: UIButton!
    @IBOutlet weak var next2: UIButton!
    @IBOutlet weak var back2: UIButton!
    @IBOutlet weak var next3: UIButton!
    @IBOutlet weak var back3: UIButton!
    @IBOutlet weak var next4: UIButton!
    @IBOutlet weak var back4: UIButton!
    @IBOutlet weak var finishhhh: UIButton!
    @IBOutlet weak var back5: UIButton!
    //    @IBOutlet weak var owner_radio1: UIButton!
    //    @IBOutlet weak var owner_radio2: UIButton!
    //    @IBOutlet weak var owner_radio3: UIButton!
    //    @IBOutlet weak var owner_radio4: UIButton!
    
    
    
    
    
    @IBOutlet weak var btn_priceCurrency: PMSuperButton!
    @IBOutlet weak var btn_spaceUnit: PMSuperButton!
    
    @IBOutlet weak var btn_first_Owner: SKRadioButton!
    @IBOutlet weak var btn_Second_Owner: SKRadioButton!
    @IBOutlet weak var btn_third_Owner: SKRadioButton!
    @IBOutlet weak var btn_Forth_Owner: SKRadioButton!
    
    @IBOutlet weak var btn_Building: PMSuperButton!
    @IBOutlet weak var btn_Floors: PMSuperButton!
    @IBOutlet weak var btn_Current_Floors: PMSuperButton!
    @IBOutlet weak var btn_Rooms: PMSuperButton!
    @IBOutlet weak var btn_BathRooms: PMSuperButton!
    
    let drop_choseBulidingAge = DropDown()
    let drop_choseFloors = DropDown()
    let drop_choseCurrentFloor = DropDown()
    let drop_choseRooms = DropDown()
    let drop_choseBathRooms = DropDown()
    let drop_choseHeatingType = DropDown()
    let drop_choseHeatingDistribution = DropDown()
    let drop_priceCurrency = DropDown()
    let drop_spaceUnit = DropDown()
    var Arr_BulidingAge: [JSON] = []
    var Arr_floor: [JSON] = []
    var Arr_CurrentFloor: [JSON] = []
    var Arr_Rooms: [JSON] = []
    var Arr_bathRoom: [JSON] = []
    var Arr_Owner: [JSON] = []
    var Arr_priceCurrency: [JSON] = []
    var Arr_spaceUnit: [JSON] = []
    
    
    // fifth Screen
    @IBOutlet weak var btn_Country: PMSuperButton!
    @IBOutlet weak var btn_City: PMSuperButton!
    let drop_choseCountry = DropDown()
    let drop_choseCity = DropDown()
    var Arr_Country: [JSON] = []
    var Arr_City: [JSON] = []
    @IBOutlet weak var navItem: UINavigationItem!
    
    @IBOutlet weak var ImportPhotosFrom_btn_view: UIButton!
    @IBOutlet weak var StackView: UIStackView!
    // six Screen
    @IBOutlet weak var featureStack: UIStackView!
    var Arr_usageStatus: [JSON] = []
    var Arr_heating: [JSON] = []
    var Arr_heatingType: [JSON] = []
    var Arr_heatingDistribution: [JSON] = []
    var Arr_porch: [JSON] = []
    var Arr_attributeID: [JSON] = []
    
    var Arr_furniture: [JSON] = []
    @IBOutlet weak var btn_heating_type: PMSuperButton!
    @IBOutlet weak var btn_heating_Distrbution: PMSuperButton!
    @IBOutlet weak var switch_Heating : UISwitch!
    @IBOutlet weak var switch_furniture : UISwitch!
    @IBOutlet weak var switch_porch : UISwitch!
    @IBOutlet weak var switch_pool : UISwitch!
    @IBOutlet weak var switch_Elevator : UISwitch!
    @IBOutlet weak var switch_Cleaning : UISwitch!
    @IBOutlet weak var switch_Room : UISwitch!
    @IBOutlet weak var switch_fun : UISwitch!
    @IBOutlet weak var switch_Internet : UISwitch!
    @IBOutlet weak var switch_parking : UISwitch!
    @IBOutlet weak var lbl_pool : UILabel!
    @IBOutlet weak var lbl_Elevator : UILabel!
    @IBOutlet weak var lbl_Cleaning : UILabel!
    @IBOutlet weak var lbl_Room : UILabel!
    @IBOutlet weak var lbl_fun : UILabel!
    @IBOutlet weak var lbl_Internet : UILabel!
    @IBOutlet weak var lbl_parking : UILabel!
    var assets: [DKAsset]?
    var Arr_image: [UIImage] = []
    var Arr_image_id = [String]()


    var property_Data: JSON?
    var maxIndex = -1
    var exportManually = false
    @IBOutlet var previewView: UICollectionView?
    var parameters:[String: String] = [:]
     @IBOutlet weak var SteppedView: UIView!
    var progressBarWithDifferentDimensions: FlexibleSteppedProgressBar!

    
    
    var backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
    var progressColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
    var textColorHere = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
    var StrockColor = #colorLiteral(red: 0.6700431108, green: 0.4938179851, blue: 0.08864554018, alpha: 1)
    
    
    var city: String?
    var country: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        //loginVc.getDeviceLanguage()
        languageVC.getCurrentSelectedLang()

        loadPropertyData()
        setupProgressBarWithDifferentDimensions()
        showViewByTag(view:1)
        
        let lang = languageVC.lang
        if lang == "ar"{
            self.txt_price.textAlignment = .right
            self.txt_Place.textAlignment = .right
            self.txt_details.textAlignment = .right


            
            
        }
        
        // Configure Location Manager
                     configureLocationManager()
                     
                     print("MapViewController")
                     
                     mapView.delegate = self
        
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
        appearance.textFont = UIFont(name:"Tajawal-Regular",size:12)!
        
        self.btn_first_Owner.titleText = "Owner".localized();
        
        self.btn_Second_Owner.titleText = "Office of Amlak".localized();
        self.btn_third_Owner.titleText = "The bank".localized();
        self.btn_Forth_Owner.titleText = "Building company".localized();
        self.setText()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: NSNotification.Name( LCLLanguageChangeNotification), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
              
                       
               let camera = GMSCameraPosition.camera(withLatitude: currentLocation.latitude, longitude: currentLocation.longitude, zoom: 14.0)
              
              self.mapView?.camera = camera
              
              
           
           
           
       }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func setText(){
        
        maintitle1.text = "Add property pictures".localized();
        subtitle1.text = "Add to to 20 pictures".localized();
        maintitle2.text = "Add property details 1".localized();
        subtitle2.text = "Please select property details 1".localized();
        maintitle3.text = "Add property details 2".localized();
        subtitle3.text = "Please select property details 2".localized();
        maintitle4.text = "Add property features".localized();
        subtitle4.text = "Please select property features".localized();
        maintitle5.text = "Add property location".localized();
        subtitle5.text = "Please select property location".localized();
        maintitle6.text = "We are almost done!".localized();
        subtitle6.text = "You have done with add properity".localized();
        propcat1.text = "Type".localized();
        propcat2.text = "Sub type".localized();
        pricelbl.text = "Price".localized();
        spacelbl.text = "Space".localized();
        ownerlbl.text = "Owner".localized();
        propstatuslbl.text = "Status".localized();
        propagelbl.text = "Property age".localized();
        profloorlbl.text = "Floors".localized();
        procurrentfloorlbl.text = "Current floor".localized();
        proroomslbl.text = "Rooms".localized();
        probathroomslbl.text = "Bathrooms".localized();
        heatinglbl.text = "Heating".localized();
        heatingtyle1lbl.text = "Heating type".localized();
        heatingtyle2lbl.text = "Heating distribution".localized();
        furniturelbl.text = "Furniture".localized();
        elivatorlbl.text = "Elivator".localized();
        poollbl.text = "Pool".localized();
        balconaaaalbl.text = "Balacon".localized();
        cleaninglbl.text = "Cleaning".localized();
        internetlbl.text = "Internet".localized();
        hallllbl.text = "Hall".localized();
        entertaymentssslbl.text = "Entertaiments".localized();
        parkinglbl.text = "Parking".localized();
//        countrylbl.text = "Country".localized();
//        citylbl.text = "City".localized();
        lblCurency.text = "Price currency".localized();
        lblSpaceunit.text = "Space unit".localized();
        lbl_datails.text = "Properity Details".localized();
        
        
        
        let letscontinueNS = NSAttributedString(string: "Let's Continue".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        
        letscontinue.setAttributedTitle(letscontinueNS, for: .normal)
        //////////
        let next1NS = NSAttributedString(string: "Next".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        
        next1.setAttributedTitle(next1NS, for: .normal)
        
        /////////
        let next2NS = NSAttributedString(string: "Next".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        next2.setAttributedTitle(next2NS, for: .normal)
        /////////
        
        let next3NS = NSAttributedString(string: "Next".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        
        next3.setAttributedTitle(next3NS, for: .normal)
        /////////
        let next4NS = NSAttributedString(string: "Next".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        
        next4.setAttributedTitle(next4NS, for: .normal)
        ////////
        let finishNS = NSAttributedString(string: "Finish".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        finishhhh.setAttributedTitle(finishNS, for: .normal)
        
        ////////
        let back1NS = NSAttributedString(string: "Back".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray])
        back1.setAttributedTitle(back1NS, for: .normal)
        
        ////////
        let back2NS = NSAttributedString(string: "Back".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray])
        back2.setAttributedTitle(back2NS, for: .normal)
        
        ////////
        let back3NS = NSAttributedString(string: "Back".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray])
        back3.setAttributedTitle(back3NS, for: .normal)
        
        ////////
        let back4NS = NSAttributedString(string: "Back".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray])
        back4.setAttributedTitle(back4NS, for: .normal)
        
        
        ////////
        let back5NS = NSAttributedString(string: "Back".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray])
        back5.setAttributedTitle(back5NS, for: .normal)
        
        
        let btnpurchasearrtibutedstr = NSAttributedString(string: "Purchase".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        
        
        btn_purchases.setAttributedTitle(btnpurchasearrtibutedstr, for: .normal)
        
        
        
        let btnrentarrtibutedstr = NSAttributedString(string: "Rent".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray])
        
        
        btn_rent_Selected.setAttributedTitle(btnrentarrtibutedstr, for: .normal)
        
        
        
        let embtyarrtibutedstr = NSAttributedString(string: "Empty".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        btn_Empty.setAttributedTitle(embtyarrtibutedstr, for: .normal)
        
        let rentedarrtibutedstr = NSAttributedString(string: "Rented".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray])
        btn_Rented.setAttributedTitle(rentedarrtibutedstr, for: .normal)
        
        let homeownerarrtibutedstr = NSAttributedString(string: "Home owner".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray])
        btn_HomeOwner.setAttributedTitle(homeownerarrtibutedstr, for: .normal)
        
        
        
        
        
        
        
        
        self.navItem.title = "Edit Property".localized();
        
        
        
        
        
        
    }

    
    
    func setupProgressBarWithDifferentDimensions() {
        progressBarWithDifferentDimensions = FlexibleSteppedProgressBar()
        progressBarWithDifferentDimensions.translatesAutoresizingMaskIntoConstraints = false
        SteppedView.addSubview(progressBarWithDifferentDimensions)
        
        // iOS9+ auto layout code
        let horizontalConstraint = progressBarWithDifferentDimensions.centerXAnchor.constraint(equalTo: self.SteppedView.centerXAnchor)
        let verticalConstraint = progressBarWithDifferentDimensions.topAnchor.constraint(
            equalTo: SteppedView.topAnchor
        )
        let widthConstraint = progressBarWithDifferentDimensions.widthAnchor.constraint(equalToConstant: 340)
        let heightConstraint = progressBarWithDifferentDimensions.heightAnchor.constraint(equalToConstant: 55)
        NSLayoutConstraint.activate([horizontalConstraint,widthConstraint,  verticalConstraint, heightConstraint])
        
        
        progressBarWithDifferentDimensions.selectedBackgoundColor = StrockColor
        progressBarWithDifferentDimensions.selectedOuterCircleStrokeColor = StrockColor
        
        progressBarWithDifferentDimensions.currentSelectedCenterColor = StrockColor
        progressBarWithDifferentDimensions.stepTextColor = textColorHere
        progressBarWithDifferentDimensions.currentSelectedTextColor = StrockColor
        progressBarWithDifferentDimensions.completedTillIndex = 0
        
        progressBarWithDifferentDimensions.numberOfPoints = 6
        progressBarWithDifferentDimensions.lineHeight = 8
        progressBarWithDifferentDimensions.radius = 6
        progressBarWithDifferentDimensions.progressRadius = 10
        progressBarWithDifferentDimensions.progressLineHeight = 4
        progressBarWithDifferentDimensions.delegate = self
        progressBarWithDifferentDimensions.stepTextFont = UIFont(name:"Tajawal-Bold",size:13)!
        
        
        
    }

        
        
        
        
        func progressBar(_ progressBar: FlexibleSteppedProgressBar,
                         didSelectItemAtIndex index: Int) {
            progressBar.currentIndex = index
            if index > maxIndex {
                maxIndex = index
                progressBar.completedTillIndex = maxIndex
            }
        }
        
        //    func progressBar(_ progressBar: FlexibleSteppedProgressBar,
        //                     canSelectItemAtIndex index: Int) -> Bool {
        //        return true
        //    }
        
        func progressBar(_ progressBar: FlexibleSteppedProgressBar,
                         textAtIndex index: Int, position: FlexibleSteppedProgressBarTextLocation) -> String {
            if progressBar == progressBarWithDifferentDimensions {
                if position == FlexibleSteppedProgressBarTextLocation.bottom {
                    switch index {
                        
                    case 0: return "Start".localized();
                    case 1: return "Step 1".localized();
                    case 2: return "Step 2".localized();
                    case 3: return "Step 3".localized();
                    case 4: return "Step 4".localized();
                    case 5: return "Finish".localized();
                    default: return "Date".localized();
                        
                    }
                }
            }
            return ""
        }
    
    
    func setupUserMarker() {
           mapView.clear()
           userLocationMarker.map = mapView
           userLocationMarker.userData = -1
           userLocationMarker.icon =  #imageLiteral(resourceName: "Group 85")
           userLocationMarker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
    
           
           
           
       }
       
       var userLat = ""
       var userLng = ""
       
       func configureLocationManager() {
           
           locationManager = CLLocationManager()
           locationManager.delegate = self
           locationManager.requestWhenInUseAuthorization()
           
           if locationManager.location?.coordinate != nil {
               self.currentLocation = locationManager.location!.coordinate
               print (self.currentLocation)
           }
           
           
           
       }
    
    
    @IBOutlet weak var viewMyLoction: UIView!
              {
              didSet {
                  
                  let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewMyLoctionPreesed))
                  viewMyLoction.addGestureRecognizer(tapGesture)
                  viewMyLoction.isUserInteractionEnabled = true
                  
              }
          }
          
          @objc func viewMyLoctionPreesed(gesture: UIGestureRecognizer) {
           
              let camera = GMSCameraUpdate.setTarget(currentLocation, zoom: 14)
              mapView.animate(with: camera)
              
          }
       
     
          func getAddressFromLatLong(){
           let url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(self.userLat),\(self.userLng)&key=AIzaSyBXcb6dk3opzm8gnejGxWKCvg9LCTWUtsc"
           SVProgressHUD.show()
           
           print("urlurlurlurl\(url)")

                 Alamofire.request(url).validate().responseJSON { response in
                     switch response.result {
                     case .success:

                         let responseJson = response.result.value! as! NSDictionary

                         if let results = responseJson.object(forKey: "results")! as? [NSDictionary] {
                             if results.count > 0 {
                                 if let addressComponents = results[0]["address_components"]! as? [NSDictionary] {
                                     let address = results[0]["formatted_address"] as? String
                                     for component in addressComponents {
                                         if let temp = component.object(forKey: "types") as? [String] {
                                             if (temp[0] == "postal_code") {
                                                 let pincode = component["long_name"] as? String
                                               print("my pincode is\(String(describing: pincode))")

                                             }
                                             if (temp[0] == "locality") {
                                               self.city = component["long_name"] as? String
                                               print("my city is\(String(describing: self.city))")
                                               


                                             }
                                             if (temp[0] == "administrative_area_level_1") {
                                                 let state = component["long_name"] as? String
                                               print("my state is\(String(describing: state))")
                                                

                                                  self.parameters["City"] = component["long_name"] as? String
                                                
                                                
                                               
                                             
                                             }
                                             if (temp[0] == "country") {
                                               self.country = component["long_name"] as? String
                                               print("my country is\(String(describing: self.country))")
                                               
                                               self.parameters["Country"] = component["long_name"] as? String
                                             }
                                         }
                                     }
                                 }
                             }
                         }
                       SVProgressHUD.dismiss()

                     case .failure(let error):
                         print(error)
                     }
                 }
       }
        
    @IBAction func btn_return_first(_ sender: Any) {
        showViewByTag(view: 1)
    }
    @IBAction func btn_return_second(_ sender: Any) {
        showViewByTag(view: 2)
    }
    
    @IBAction func btn_return_last(_ sender: Any) {
        showViewByTag(view: 5)
    }
    @IBAction func btn_return_third(_ sender: Any) {
        showViewByTag(view: 3)
    }
    @IBAction func btn_return_forth(_ sender: Any) {
        showViewByTag(view: 4)
    }
    
    
    @IBAction func btn_dismiss(_ sender:Any){
//        self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)

    }
    
    
    
    
    
    
    
    
    
    @IBAction func btn_Curency_Pressed(_ sender: Any) {
        self.drop_priceCurrency.show()
        
        
    }
    
    @IBAction func btn_SpaceUnit_Pressed(_ sender: Any) {
        self.drop_spaceUnit.show()
        
    }
    
    // fifth Screen
    
    @IBAction func btn_Country_Pressed(_ sender: Any) {
        self.drop_choseCountry.show()
    }
    @IBAction func btn_City_Pressed(_ sender: Any) {
        self.drop_choseCity.show()
    }
    @IBOutlet weak var btn_finish: UIView!
    
    @IBAction func btn_finish_Pressed(_ sender: Any) {
        self.parameters["notes"] = self.txt_details.text!

       SVProgressHUD.show()
        let token = UserDefaults.standard.value(forKey: "access_token")
        parameters["ID"] = selectedID
        let url = "https://www.wasataa.com/api/RealEstate/EditRealEstate"
        let header = ["Content-Type":"application/x-www-form-urlencoded ",
                      "Authorization": token
            ] as! [String : String]
       
        Alamofire.request(url,method: .post,parameters: parameters,headers:header)
            .responseJSON { response in
                switch response.result {
                case .success:
                    let responseResult = JSON(response.result.value!)
                    var errors:String!
                    if let error = responseResult["errors"].array{
                        for i in error{
                            errors = errors ?? "" + i.stringValue
                        }
                        self.showMessageOnSelf(title: "Error".localized(), Message: errors, okComplition: nil, onDissmissComplition: nil)
                    }else{
                        self.view.makeToast("Your Property was successfully added!".localized(), duration: 3.0, position: .bottom)
                        
                        sleep(1)
                                       DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                            
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
                                                                                self.navigationController?.popViewController(animated: true)



                                                        }
                                            
                                            
                                            
                                            

                        //                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "my_prop") as! MypropTableViewController
                        //                        self.navigationController?.pushViewController(vc, animated: true)

                                                }

                    
                    }
                    
                    SVProgressHUD.dismiss()
                    
                    
                case .failure(let error):
                    print("******** \(error.localizedDescription) *******")
                    
                }
        }
    }
    
    
    func showViewByTag(view:Int){
        switch view {
        case 1:
            StackView.viewWithTag(10)?.isHidden = false
            StackView.viewWithTag(2)?.isHidden = true
            StackView.viewWithTag(3)?.isHidden = true
            StackView.viewWithTag(4)?.isHidden = true
            StackView.viewWithTag(5)?.isHidden = true
            StackView.viewWithTag(6)?.isHidden = true
            progressBarWithDifferentDimensions.currentIndex = 0
            break
        case 2:
            StackView.viewWithTag(10)?.isHidden = true
            StackView.viewWithTag(2)?.isHidden = false
            StackView.viewWithTag(3)?.isHidden = true
            StackView.viewWithTag(4)?.isHidden = true
            StackView.viewWithTag(5)?.isHidden = true
            StackView.viewWithTag(6)?.isHidden = true
            progressBarWithDifferentDimensions.currentIndex = 1
            break
        case 3:
            StackView.viewWithTag(10)?.isHidden = true
            StackView.viewWithTag(2)?.isHidden = true
            StackView.viewWithTag(3)?.isHidden = false
            StackView.viewWithTag(4)?.isHidden = true
            StackView.viewWithTag(5)?.isHidden = true
            StackView.viewWithTag(6)?.isHidden = true
            progressBarWithDifferentDimensions.currentIndex = 2
            break
        case 4:
            StackView.viewWithTag(10)?.isHidden = true
            StackView.viewWithTag(2)?.isHidden = true
            StackView.viewWithTag(3)?.isHidden = true
            StackView.viewWithTag(4)?.isHidden = false
            StackView.viewWithTag(5)?.isHidden = true
            StackView.viewWithTag(6)?.isHidden = true
            progressBarWithDifferentDimensions.currentIndex = 3
            break
        case 5:
            StackView.viewWithTag(10)?.isHidden = true
            StackView.viewWithTag(2)?.isHidden = true
            StackView.viewWithTag(3)?.isHidden = true
            StackView.viewWithTag(4)?.isHidden = true
            StackView.viewWithTag(5)?.isHidden = false
            StackView.viewWithTag(6)?.isHidden = true
            progressBarWithDifferentDimensions.currentIndex = 4
            break
        case 6:
            StackView.viewWithTag(10)?.isHidden = true
            StackView.viewWithTag(2)?.isHidden = true
            StackView.viewWithTag(3)?.isHidden = true
            StackView.viewWithTag(4)?.isHidden = true
            StackView.viewWithTag(5)?.isHidden = true
            StackView.viewWithTag(6)?.isHidden = false
            progressBarWithDifferentDimensions.currentIndex = 5
            break
        default:
            StackView.viewWithTag(10)?.isHidden = true
            StackView.viewWithTag(2)?.isHidden = true
            StackView.viewWithTag(3)?.isHidden = true
            StackView.viewWithTag(4)?.isHidden = true
            StackView.viewWithTag(5)?.isHidden = true
            StackView.viewWithTag(6)?.isHidden = true
        }
    }
    

    @IBAction func btn_First_Add_Property_Pressed(_ sender: Any) {
        SVProgressHUD.show()
//        guard self.first_validate() else {
//            return
//        }
        var env64string:String! = ""
        for (index, element) in Arr_image.enumerated() {
            print("Item \(index): \(element)")
                let data = UIImageJPEGRepresentation(element, 0.85)
                env64string = data?.base64EncodedString(options: .lineLength64Characters)
                let name = "ArrayImage[\(index)]"
            self.parameters[name] = env64string 
            
        }
        
        print(parameters)
         SVProgressHUD.dismiss()
        showViewByTag(view:2)
    }
    @IBAction func btn_Second_Add_Property_Pressed(_ sender: Any) {
        SVProgressHUD.show()
        guard self.Second_validate() else {
            return
        }
        parameters["price"] = self.txt_price.text!
        parameters["SizeBuild"] = self.txt_Place.text!
        SVProgressHUD.dismiss()
        print(parameters)
        showViewByTag(view:3)
    }
    @IBAction func btn_third_Add_Property_Pressed(_ sender: Any) {
        showViewByTag(view:4)
    }
    @IBAction func btn_Forth_Add_Property_Pressed(_ sender: Any) {
        parameters["LatMap"] = location?.latitude.description
        parameters["LngMap"] = location?.longitude.description
        showViewByTag(view:5)
    }
    @IBAction func btn_Fifth_Add_Property_Pressed(_ sender: Any) {
        showViewByTag(view:6)
    }

    // first View Controller
    @IBAction func ImportPhotosFrom_btn(_ sender: Any) {
        print("ImportPhotosFrom_btn")
        
        showImagePicker()
        ImportPhotosFrom_btn_view.isHidden = true
    }
    // Second Screen
    @IBAction func btn_Property_Pressed(_ sender: Any) {
        self.drop_choseProperty.show()
    }
    @IBAction func btn_Property_Type_Pressed(_ sender: Any) {
        self.drop_chosePropertyType.show()
    }
    @IBAction func btn_duration_Pressed(_ sender: Any) {
        self.drop_choseDuration.show()
    }
    @IBAction func btn_Rent(_ sender:Any){
        propertySelected(Selceted: 2)
    }
    @IBAction func btn_purchase(_ sender:Any){
        propertySelected(Selceted: 1)
        
    }
    
    func propertySelected(Selceted:Int){
        switch Selceted {
        case 1:
            btn_purchases.backgroundColor = #colorLiteral(red: 0.6431372549, green: 0.5019607843, blue: 0.262745098, alpha: 1)
            btn_purchases.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            let btnpurchasearrtibutedstr = NSAttributedString(string: "Purchase".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
            
            
            btn_purchases.setAttributedTitle(btnpurchasearrtibutedstr, for: .normal)
            
            
            
            let btnrentarrtibutedstr = NSAttributedString(string: "Rent".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray])
            
            
            btn_rent_Selected.setAttributedTitle(btnrentarrtibutedstr, for: .normal)
            btn_rent_Selected.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            btn_rent_Selected.setTitleColor(#colorLiteral(red: 0.2901960784, green: 0.2823529412, blue: 0.2823529412, alpha: 1), for: .normal)
            propertyFirstStackView.viewWithTag(12)?.isHidden = true
            self.parameters["PropertyClass"] = self.Arr_Property_Type[0]["id"].stringValue
            self.parameters.removeValue(forKey: "LeaseTerm")
            break
        case 2:
            btn_purchases.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            btn_purchases.setTitleColor(#colorLiteral(red: 0.2901960784, green: 0.2823529412, blue: 0.2823529412, alpha: 1), for: .normal)
            btn_rent_Selected.backgroundColor = #colorLiteral(red: 0.6431372549, green: 0.5019607843, blue: 0.262745098, alpha: 1)
            btn_rent_Selected.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            propertyFirstStackView.viewWithTag(12)?.isHidden = false
            self.parameters["LeaseTerm"] = self.Arr_Lease[0]["id"].stringValue
            self.parameters["PropertyClass"] = self.Arr_Property_Type[1]["id"].stringValue
            
            let btnpurchasearrtibutedstr = NSAttributedString(string: "Purchase".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray])
            
            
            btn_purchases.setAttributedTitle(btnpurchasearrtibutedstr, for: .normal)
            
            
            
            let btnrentarrtibutedstr = NSAttributedString(string: "Rent".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
            
            
            btn_rent_Selected.setAttributedTitle(btnrentarrtibutedstr, for: .normal)
            break
        default:
            break
        }
    }

    // third screen
    @IBAction func btn_Empty(_ sender:Any){
        propertyStatus(Selceted: 1)
    }
    @IBAction func btn_Rented(_ sender:Any){
        propertyStatus(Selceted: 2)
        
    }
    @IBAction func btn_Owner(_ sender:Any){
        propertyStatus(Selceted: 3)
    }
   
    func propertyStatus(Selceted:Int){
        switch Selceted {
        case 1:
            btn_Empty.backgroundColor = #colorLiteral(red: 0.6431372549, green: 0.5019607843, blue: 0.262745098, alpha: 1)
            btn_Empty.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            let embtyarrtibutedstr = NSAttributedString(string: "Empty".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
            btn_Empty.setAttributedTitle(embtyarrtibutedstr, for: .normal)
            
            let rentedarrtibutedstr = NSAttributedString(string: "Rented".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray])
            btn_Rented.setAttributedTitle(rentedarrtibutedstr, for: .normal)
            
            let homeownerarrtibutedstr = NSAttributedString(string: "Home owner".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray])
            btn_HomeOwner.setAttributedTitle(homeownerarrtibutedstr, for: .normal)
            btn_Rented.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            btn_Rented.setTitleColor(#colorLiteral(red: 0.2901960784, green: 0.2823529412, blue: 0.2823529412, alpha: 1), for: .normal)
            btn_HomeOwner.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            btn_HomeOwner.setTitleColor(#colorLiteral(red: 0.2901960784, green: 0.2823529412, blue: 0.2823529412, alpha: 1), for: .normal)
            parameters["usageStatus"] = self.Arr_usageStatus[0]["id"].stringValue
            
            break
        case 2:
            btn_Empty.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            btn_Empty.setTitleColor(#colorLiteral(red: 0.2901960784, green: 0.2823529412, blue: 0.2823529412, alpha: 1), for: .normal)
            btn_Rented.backgroundColor = #colorLiteral(red: 0.6431372549, green: 0.5019607843, blue: 0.262745098, alpha: 1)
            btn_Rented.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            btn_HomeOwner.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            btn_HomeOwner.setTitleColor(#colorLiteral(red: 0.2901960784, green: 0.2823529412, blue: 0.2823529412, alpha: 1), for: .normal)
            parameters["usageStatus"] = self.Arr_usageStatus[1]["id"].stringValue
            
            let embtyarrtibutedstr = NSAttributedString(string: "Empty".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray])
            btn_Empty.setAttributedTitle(embtyarrtibutedstr, for: .normal)
            
            let rentedarrtibutedstr = NSAttributedString(string: "Rented".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
            btn_Rented.setAttributedTitle(rentedarrtibutedstr, for: .normal)
            
            let homeownerarrtibutedstr = NSAttributedString(string: "Home owner".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray])
            btn_HomeOwner.setAttributedTitle(homeownerarrtibutedstr, for: .normal)
            
            break
        case 3:
            btn_Empty.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            btn_Empty.setTitleColor(#colorLiteral(red: 0.2901960784, green: 0.2823529412, blue: 0.2823529412, alpha: 1), for: .normal)
            btn_Rented.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            btn_Rented.setTitleColor(#colorLiteral(red: 0.2901960784, green: 0.2823529412, blue: 0.2823529412, alpha: 1), for: .normal)
            btn_HomeOwner.backgroundColor = #colorLiteral(red: 0.6431372549, green: 0.5019607843, blue: 0.262745098, alpha: 1)
            btn_HomeOwner.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            parameters["usageStatus"] = self.Arr_usageStatus[2]["id"].stringValue
            let embtyarrtibutedstr = NSAttributedString(string: "Empty".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray])
            btn_Empty.setAttributedTitle(embtyarrtibutedstr, for: .normal)
            
            let rentedarrtibutedstr = NSAttributedString(string: "Rented".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray])
            btn_Rented.setAttributedTitle(rentedarrtibutedstr, for: .normal)
            
            let homeownerarrtibutedstr = NSAttributedString(string: "Home owner".localized(),attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
            btn_HomeOwner.setAttributedTitle(homeownerarrtibutedstr, for: .normal)
            
            break
        default:
            break
        }
    }

    
    
    @IBAction func btn_Building_Pressed(_ sender: Any) {
        self.drop_choseBulidingAge.show()
    }
    @IBAction func btn_Floors_Pressed(_ sender: Any) {
        self.drop_choseFloors.show()
    }
    @IBAction func btn_Current_Floor_Pressed(_ sender: Any) {
        self.drop_choseCurrentFloor.show()
    }
    @IBAction func btn_Rooms_Pressed(_ sender: Any) {
        self.drop_choseRooms.show()
    }
    @IBAction func btn_Bathrooms_Pressed(_ sender: Any) {
        self.drop_choseBathRooms.show()
    }
    @IBAction func btn_first_Pressed(_ sender: Any) {
        OwnerSelected(Selceted: 1)
    }
    @IBAction func btn_Second_Pressed(_ sender: Any) {
        OwnerSelected(Selceted: 2)
    }
    @IBAction func btn_Third_Pressed(_ sender: Any) {
        OwnerSelected(Selceted: 3)
    }
    @IBAction func btn_forth_Pressed(_ sender: Any) {
        OwnerSelected(Selceted: 4)
    }
    func OwnerSelected(Selceted:Int){
        switch Selceted {
        case 1:
            btn_first_Owner.isSelected = true
            btn_Second_Owner.isSelected = false
            btn_third_Owner.isSelected = false
            btn_Forth_Owner.isSelected = false
            self.parameters["WhoOwnerAds"] = self.Arr_Owner[0]["id"].stringValue
            break
        case 2:
            btn_first_Owner.isSelected = false
            btn_Second_Owner.isSelected = true
            btn_third_Owner.isSelected = false
            btn_Forth_Owner.isSelected = false
            self.parameters["WhoOwnerAds"] = self.Arr_Owner[1]["id"].stringValue
            break
        case 3:
            btn_first_Owner.isSelected = false
            btn_Second_Owner.isSelected = false
            btn_third_Owner.isSelected = true
            btn_Forth_Owner.isSelected = false
            self.parameters["WhoOwnerAds"] = self.Arr_Owner[2]["id"].stringValue
            break
        case 4:
            btn_first_Owner.isSelected = false
            btn_Second_Owner.isSelected = false
            btn_third_Owner.isSelected = false
            btn_Forth_Owner.isSelected = true
            self.parameters["WhoOwnerAds"] = self.Arr_Owner[3]["id"].stringValue
            break
        default:
            break
        }
    }
    
    
    // First Screen
    func showImagePicker() {
        if self.exportManually {
            DKImageAssetExporter.sharedInstance.add(observer: self)
        }
        
        let pickerController = DKImagePickerController()
        pickerController.assetType = .allPhotos
        pickerController.maxSelectableCount = 20 - self.Arr_image.count
        
        pickerController.exportStatusChanged = { status in
            switch status {
            case .exporting:
                print("exporting")
            case .none:
                print("none")
            }
        }
        
        
        pickerController.didSelectAssets = { [unowned self] (assets: [DKAsset]) in
            self.updateAssets(assets: assets)
        }
        
        if UI_USER_INTERFACE_IDIOM() == .pad {
            pickerController.modalPresentationStyle = .formSheet
        }
            
        else {
            self.present(pickerController, animated: true) {}
        }
    }
    
    
    // update Assest
    func updateAssets(assets: [DKAsset]) {
        print("didSelectAssets")
        self.assets?.removeAll()
        self.assets = assets
        let layout = previewView?.collectionViewLayout as! UICollectionViewFlowLayout
        for i in assets {
            i.fetchImage(with: layout.itemSize.toPixel(), completeBlock: { image, info in
                self.Arr_image.append(image!)
            })
        }
        if self.Arr_image.count == 20 {
            self.ImportPhotosFrom_btn_view.isHidden = true
        }else{
            self.ImportPhotosFrom_btn_view.isHidden = false
        }
        self.previewView?.reloadData()
        
        
        //        if pickerController.exportsWhenCompleted {
        //            for asset in assets {
        //                if let error = asset.error {
        //                    print("exporterDidEndExporting with error:\(error.localizedDescription)")
        //                } else {
        //                    print("exporterDidEndExporting:\(asset.localTemporaryPath!)")
        //                }
        //            }
        //        }
        
        if self.exportManually {
            DKImageAssetExporter.sharedInstance.exportAssetsAsynchronously(assets: assets, completion: nil)
        }
    }
    
    
    // six Screen
    @IBAction func btn_heatingDistribution(_ sender: Any) {
        drop_choseHeatingDistribution.show()
    }
    @IBAction func btn_heatingType(_ sender: Any) {
        drop_choseHeatingType.show()
    }
    
    @IBAction func checkHeating(_ sender: UISwitch) {
        if (sender.isOn == true)
        {
            self.parameters["Heating"] = self.Arr_heating[0]["id"].stringValue
           
            switch_Heating.setOn(true, animated: true)
            featureStack.viewWithTag(1)?.isHidden = false
            
        }else{
            self.parameters["Heating"] = self.Arr_heating[1]["id"].stringValue
//            switch_Heating.isOn = false
            switch_Heating.setOn(false, animated: true)

            featureStack.viewWithTag(1)?.isHidden = true
        }
        
    }
    @IBAction func checkfurniture(_ sender: UISwitch) {
        if (sender.isOn == true)
        {
            self.parameters["Furniture"] = self.Arr_furniture[0]["id"].stringValue
           
//            switch_furniture.isOn = true
            switch_furniture.setOn(true, animated: true)
            

        }
        if (sender.isOn == false)
        {
            self.parameters["Furniture"] = self.Arr_furniture[1]["id"].stringValue
//            switch_furniture.isOn = false
            switch_furniture.setOn(false, animated: true)

            
        }
    }
    @IBAction func checkPorch(_ sender: UISwitch) {
        if (sender.isOn == true)
        {
             self.parameters["Porch"] = self.Arr_porch[0]["id"].stringValue
        
//            switch_porch.isOn = true
            switch_porch.setOn(true, animated: true)

        }else{
             self.parameters["Porch"] = self.Arr_porch[1]["id"].stringValue
            
//            switch_porch.isOn = false
            switch_porch.setOn(false, animated: true)

        }
        
    }
    @IBAction func checkPool(_ sender: UISwitch) {
        if (sender.isOn == true)
        {
           
            self.parameters["Pool"] = "true"
          
//            switch_pool.isOn = true
            switch_pool.setOn(true, animated: true)

        }else{
            self.parameters["Pool"] = "false"
            
//            switch_pool.isOn = false
            switch_pool.setOn(false, animated: true)

        }
       
    }
    @IBAction func checkCleaning(_ sender: UISwitch) {
        if (sender.isOn == true)
        {
            
            self.parameters["Cleaning"] = "true"
           
//            switch_Cleaning.isOn = true
            switch_Cleaning.setOn(true, animated: true)

        }else{
            self.parameters["Cleaning"] = "false"
//            switch_Cleaning.isOn = false
            switch_Cleaning.setOn(false, animated: true)

        }
        
    }
    @IBAction func checkElevator(_ sender: UISwitch) {
        if (sender.isOn == true)
        {
           
            self.parameters["Elevator"] = "true"
            
//            switch_Elevator.isOn = true
            switch_Elevator.setOn(true, animated: true)

        }else{
            self.parameters["Elevator"] = "false"
//            switch_Elevator.isOn = false
            switch_Elevator.setOn(false, animated: true)

        }
        
    }
    @IBAction func checkInternet(_ sender: UISwitch) {
        if (sender.isOn == true)
        {
            self.parameters["Internet"] = "true"
           
//            switch_Internet.isOn = true
            switch_Internet.setOn(true, animated: true)

        }else{
            self.parameters["Internet"] = "false"
//            switch_Internet.isOn = false
            switch_Internet.setOn(false, animated: true)

        }
        
    }
    @IBAction func checkParking(_ sender: UISwitch) {
        if (sender.isOn == true)
        {
            
            self.parameters["Parking"] = "true"
          
//            switch_parking.isOn = true
            switch_parking.setOn(true, animated: true)

        }else{
            self.parameters["Parking"] = "false"
//            switch_parking.isOn = false
            switch_parking.setOn(false, animated: true)

        }
        
    }
    @IBAction func checkFun(_ sender: UISwitch) {
        if (sender.isOn == true)
        {
          
            self.parameters["Entertainment"] = "true"
//            switch_fun.isOn = true
            switch_fun.setOn(true, animated: true)

        }else{
            self.parameters["Entertainment"] = "false"
//            switch_fun.isOn = false
            switch_fun.setOn(false, animated: true)

        }
       
    }
    @IBAction func checkRoom(_ sender: UISwitch) {
        if (sender.isOn == false)
        {
            
            self.parameters["Hall"] = "true"
            switch_Room.setOn(true, animated: true)

            
//            switch_Room.isOn = true
        }else{
            self.parameters["Hall"] = "false"
//            switch_Room.isOn = false
            switch_Room.setOn(false, animated: true)

        }
        
    }
}
extension EditPropertyVC:UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.Arr_image.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let asset = self.Arr_image[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellImage", for: indexPath) as! ImageCollectionCell
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true

        cell.img_selected.image = asset
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
extension EditPropertyVC : ImageCollectionCellDelegate{
    func deleteTapped(_ cell: ImageCollectionCell) {
        let index = previewView?.indexPath(for: cell)
        var image_id_final = ""
        switch index?.row {
                      case 0:
                       print("image 1")
                       
                       image_id_final = self.Arr_image_id[0]
                       
                       print("image_id_finalimage_id_finalimage_id_final \(image_id_final)")
                       
                       SVProgressHUD.show()
                       let token = UserDefaults.standard.value(forKey: "access_token")
                             let url = "https://www.wasataa.com/api/RealEstate/RemoveImage"
                             
                             let parameterss = ["id":image_id_final] as [String : Any]
                             let header = ["Content-Type":"application/x-www-form-urlencoded ",
                                           "Authorization":token
                                 ] as! [String : String]
                             Alamofire.request(url,method: .get,parameters: parameterss,headers:header)
                                 .responseJSON { response in
                                    switch response.result {
                               case .success:
                                   let responseResult = JSON(response.result.value!)
                                   if let data = responseResult.dictionary{
                                    
                                    print("datadatadata \(data)")
                                       

                                   SVProgressHUD.dismiss()

                               }
                               case .failure(let error):
                                   print("******** \(error.localizedDescription) *******")

                               }
                       }
                       
                       break
                      case 1:
                       print("image 2")
                       
                       image_id_final = self.Arr_image_id[1]
                                             
                                             print("image_id_finalimage_id_finalimage_id_final \(image_id_final)")
                                             
                                             SVProgressHUD.show()
                                             let token = UserDefaults.standard.value(forKey: "access_token")
                                                   let url = "https://www.wasataa.com/api/RealEstate/RemoveImage"
                                                   
                                                   let parameterss = ["id":image_id_final] as [String : Any]
                                                   let header = ["Content-Type":"application/x-www-form-urlencoded ",
                                                                 "Authorization":token
                                                       ] as! [String : String]
                                                   Alamofire.request(url,method: .get,parameters: parameterss,headers:header)
                                                       .responseJSON { response in
                                                          switch response.result {
                                                     case .success:
                                                         let responseResult = JSON(response.result.value!)
                                                         if let data = responseResult.dictionary{
                                                          
                                                          print("datadatadata \(data)")
                                                             

                                                         SVProgressHUD.dismiss()

                                                     }
                                                     case .failure(let error):
                                                         print("******** \(error.localizedDescription) *******")

                                                     }
                                             }

                       break
                       case 2:
                        print("image 3")
                        
                        image_id_final = self.Arr_image_id[2]
                                              
                                              print("image_id_finalimage_id_finalimage_id_final \(image_id_final)")
                                              
                                              SVProgressHUD.show()
                                              let token = UserDefaults.standard.value(forKey: "access_token")
                                                    let url = "https://www.wasataa.com/api/RealEstate/RemoveImage"
                                                    
                                                    let parameterss = ["id":image_id_final] as [String : Any]
                                                    let header = ["Content-Type":"application/x-www-form-urlencoded ",
                                                                  "Authorization":token
                                                        ] as! [String : String]
                                                    Alamofire.request(url,method: .get,parameters: parameterss,headers:header)
                                                        .responseJSON { response in
                                                           switch response.result {
                                                      case .success:
                                                          let responseResult = JSON(response.result.value!)
                                                          if let data = responseResult.dictionary{
                                                           
                                                           print("datadatadata \(data)")
                                                              

                                                          SVProgressHUD.dismiss()

                                                      }
                                                      case .failure(let error):
                                                          print("******** \(error.localizedDescription) *******")

                                                      }
                                              }

                       break
                       case 3:
                        print("image 4")
                        
                        image_id_final = self.Arr_image_id[3]
                                              
                                              print("image_id_finalimage_id_finalimage_id_final \(image_id_final)")
                                              
                                              SVProgressHUD.show()
                                              let token = UserDefaults.standard.value(forKey: "access_token")
                                                    let url = "https://www.wasataa.com/api/RealEstate/RemoveImage"
                                                    
                                                    let parameterss = ["id":image_id_final] as [String : Any]
                                                    let header = ["Content-Type":"application/x-www-form-urlencoded ",
                                                                  "Authorization":token
                                                        ] as! [String : String]
                                                    Alamofire.request(url,method: .get,parameters: parameterss,headers:header)
                                                        .responseJSON { response in
                                                           switch response.result {
                                                      case .success:
                                                          let responseResult = JSON(response.result.value!)
                                                          if let data = responseResult.dictionary{
                                                           
                                                           print("datadatadata \(data)")
                                                              

                                                          SVProgressHUD.dismiss()

                                                      }
                                                      case .failure(let error):
                                                          print("******** \(error.localizedDescription) *******")

                                                      }
                                              }
                       break
                        
                        case 4:
                         print("image 5")
                         
                         image_id_final = self.Arr_image_id[4]
                                               
                                               print("image_id_finalimage_id_finalimage_id_final \(image_id_final)")
                                               
                                               SVProgressHUD.show()
                                               let token = UserDefaults.standard.value(forKey: "access_token")
                                                     let url = "https://www.wasataa.com/api/RealEstate/RemoveImage"
                                                     
                                                     let parameterss = ["id":image_id_final] as [String : Any]
                                                     let header = ["Content-Type":"application/x-www-form-urlencoded ",
                                                                   "Authorization":token
                                                         ] as! [String : String]
                                                     Alamofire.request(url,method: .get,parameters: parameterss,headers:header)
                                                         .responseJSON { response in
                                                            switch response.result {
                                                       case .success:
                                                           let responseResult = JSON(response.result.value!)
                                                           if let data = responseResult.dictionary{
                                                            
                                                            print("datadatadata \(data)")
                                                               

                                                           SVProgressHUD.dismiss()

                                                       }
                                                       case .failure(let error):
                                                           print("******** \(error.localizedDescription) *******")

                                                       }
                                               }
                        break
                                             
                       default:
                       break
                       }
        if self.Arr_image.count > 0 {
           
            
            self.Arr_image.remove(at: (index?.row)!)


            self.previewView?.reloadData()
            self.ImportPhotosFrom_btn_view.isHidden = false
          

        }
        
    }
}
extension EditPropertyVC{
    fileprivate func first_validate() -> Bool {
        if self.Arr_image.count == 0 {
            self.showMessageOnSelf(title: "Error", Message:
                "Please Select Image", okComplition: nil, onDissmissComplition: nil)
            SVProgressHUD.dismiss()
            return false
            
        
        } else {
            return true
        }
    }
    fileprivate func Second_validate() -> Bool {
        if self.txt_price.text?.count == 0 {
            self.showMessageOnSelf(title: "Error".localized(), Message:
                "Please Enter Price".localized(), okComplition: nil, onDissmissComplition: nil)
            SVProgressHUD.dismiss()
            return false
        }else if self.txt_Place.text?.count == 0 {
                 self.showMessageOnSelf(title: "Error".localized(), Message: "Please Enter Space".localized(), okComplition: nil, onDissmissComplition: nil)
                SVProgressHUD.dismiss()
                return false
            
        } else {
            return true
        }
    }
    
    func loadPropertyData(){
        SVProgressHUD.show()
        let url = "https://www.wasataa.com/api/RealEstate/PropertyRealEstate"
        let langstring = languageVC.lang
        let parameterss = ["Lang":langstring!
            ] as [String : Any]
        Alamofire.request(url,method: .get,parameters: parameterss)
            .responseJSON { response in
                switch response.result {
                case .success:
                    let responseResult = JSON(response.result.value!)
                    if let data = responseResult.dictionary{
//                        if let country = data["country"]?.array{
//                            self.Arr_Country = country
//                            self.btn_Country.setTitle(country[0]["name"].stringValue, for: .normal)
//                            self.parameters["Country"] = self.Arr_Country[0]["id"].stringValue
//                            self.loadCityData(id: self.Arr_Country[0]["id"].stringValue)
//                        }
                        if let country = data["leaseTerm"]?.array{
                            self.Arr_Lease = country
                            self.btn_duration.setTitle(country[0]["name"].stringValue, for: .normal)
                            
                        }
                        if let country = data["floorsNumber"]?.array{
                            self.Arr_CurrentFloor = country
                            
                        }
                        if let country = data["bathRoom"]?.array{
                            self.Arr_bathRoom = country
                        }
                        if let country = data["buildAge"]?.array{
                            self.Arr_BulidingAge = country
                        }
                        if let country = data["room"]?.array{
                            self.Arr_Rooms = country
                        }
                        if let country = data["floor"]?.array{
                            self.Arr_floor = country
                        }
                        if let country = data["whoOwnerAds"]?.array{
                            self.Arr_Owner = country
                            //                            self.btn_first_Owner.titleText = self.Arr_Owner[0]["name"].stringValue
                            //                            self.btn_Second_Owner.titleText = self.Arr_Owner[1]["name"].stringValue
                            //                            self.btn_third_Owner.titleText = self.Arr_Owner[2]["name"].stringValue
                            //                            self.btn_Forth_Owner.titleText = self.Arr_Owner[3]["name"].stringValue
                            
                            
                            //   let ownerstr = "Owner".localized();
                            //                        ownerstr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange)
                            //                            let myAttribute = [NSAttributedString.Key.foregroundColor: UIColor.blue]
                            //                            let myAttrString = NSAttributedString(string: ownerstr, attributes: myAttribute)
                            
                            //   self.btn_Second_Owner.titleText = ownerstr
                            
                            
                            
                            // set attributed text on a UILabel
                            
                            self.btn_first_Owner.titleText = "Owner".localized();
                            
                            self.btn_Second_Owner.titleText = "Office of Amlak".localized();
                            self.btn_third_Owner.titleText = "The bank".localized();
                            self.btn_Forth_Owner.titleText = "Building company".localized();
                            
                            self.OwnerSelected(Selceted: 1)
                            self.parameters["WhoOwnerAds"] = self.Arr_Owner[0]["id"].stringValue
                            
                        }
                        
                        
                        
                        if let country = data["propertyTypeCommercial"]?.array{
                            self.Arr_property_Type_Commercial = country
                        }
                        

                        if let country = data["propertyTypeResidential"]?.array{
                            self.Arr_Property_Type_Residential = country
                        }
                        if let country = data["propertyClass"]?.array{
                            self.Arr_Property_Type = country
                            self.propertySelected(Selceted: 1)
                            //                           self.btn_purchases.setTitle(self.Arr_Property_Type[0]["name"].stringValue, for: .normal)
                            //                            self.btn_rent_Selected.setTitle(self.Arr_Property_Type[1]["name"].stringValue, for: .normal)
                            
                        }
                        if let country = data["propertyType"]?.array{
                            self.Arr_Property = country
                            self.setupProperty_TypeDrop(data:(self.Arr_Property_Type_Residential))
                            self.setupPropertyDrop()
                        }
                        
                        if let country = data["usageStatus"]?.array{
                            self.Arr_usageStatus = country
                            self.propertyStatus(Selceted:1)
                            //                            self.btn_Empty.setTitle(self.Arr_usageStatus[0]["name"].stringValue, for: .normal)
                            //                            self.btn_Rented.setTitle(self.Arr_usageStatus[1]["name"].stringValue, for: .normal)
                            //                            self.btn_HomeOwner.setTitle(self.Arr_usageStatus[2]["name"].stringValue, for: .normal)
                            
                            
                            
                        }
                        if let country = data["heating"]?.array{
                            self.Arr_heating = country
                            
                        }
                        if let currency = data["priceType"]?.array{
                            self.Arr_priceCurrency = currency
                            
                        }
                        if let SpaceUnit = data["unitArea"]?.array{
                            self.Arr_spaceUnit = SpaceUnit
                            
                        }
                        if let country = data["heatingType"]?.array{
                            self.Arr_heatingType = country
                            self.setupHeatingTypeDrop()
                            
                        }
                        if let country = data["heatingDistribution"]?.array{
                            self.Arr_heatingDistribution = country
                            self.setupDistributionDrop()
                        }
                        if let country = data["porch"]?.array{
                            self.Arr_porch = country
                        }
                        if let country = data["furniture"]?.array{
                            self.Arr_furniture = country
                        }
                        if let country = data["attributeID"]?.array{
                            self.Arr_attributeID = country
                            
                            //                            self.lbl_pool.text =  self.Arr_attributeID[3]["name"].stringValue
                            //                            self.lbl_Elevator.text =  self.Arr_attributeID[2]["name"].stringValue
                            //                            self.lbl_Cleaning.text = self.Arr_attributeID[1]["name"].stringValue
                            //                            self.lbl_Room.text = self.Arr_attributeID[5]["name"].stringValue
                            //                            self.lbl_fun.text = self.Arr_attributeID[6]["name"].stringValue
                            //                            self.lbl_Internet.text = self.Arr_attributeID[0]["name"].stringValue
                            //                            self.lbl_parking.text = self.Arr_attributeID[4]["name"].stringValue
                            self.parameters["Internet"] = "false"
                            self.parameters["Cleaning"] = "false"
                            self.parameters["Elevator"] = "false"
                            self.parameters["Pool"] = "false"
                            self.parameters["Parking"] = "false"
                            self.parameters["Hall"] = "false"
                            self.parameters["Entertainment"] = "false"
                        }
                        
                        
                        
//                        self.setupCoutryDrop()
                        // self.setupCitiesDrop()
                        self.setupfloorDrop()
                        self.setupRoomsDrop()
                        self.setupBuildingDrop()
                        self.setupCurrentFloorDrop()
                        self.setupBathRoomsDrop()
                        self.setupDurationDrop()
                        self.setupCurrencyDrop()
                        self.setupSpaceUnitDrop()
                        self.loadData(id:self.selectedID)

                    }
                    
                    SVProgressHUD.dismiss()
                    
                    
                case .failure(let error):
                    print("******** \(error.localizedDescription) *******")
                    
                }
        }
    }

    

//    func loadCityData(id:String){
//        SVProgressHUD.show()
//        let url = "https://www.wasataa.com/api/RealEstate/GetCity"
//        let langstring = languageVC.lang
//        let parameterss = ["Country":id,
//                           "lang": langstring!
//            ] as [String : Any]
//        Alamofire.request(url,method: .get,parameters: parameterss)
//            .responseJSON { response in
//                switch response.result {
//                case .success:
//                    let responseResult = JSON(response.result.value!)
//                    if let data = responseResult.dictionary{
//                        if let city = data["data"]?.array{
//                            self.Arr_City = city
//                            self.setupCitiesDrop()
//
//                        }
//
//                    SVProgressHUD.dismiss()
//
//                }
//                case .failure(let error):
//                    print("******** \(error.localizedDescription) *******")
//
//                }
//        }
//    }
    
    func loadData(id:String){
    
        let token = UserDefaults.standard.value(forKey: "access_token")
        let url = "https://www.wasataa.com/api/RealEstate/EditRealEstate"
        
        let parameterss = ["id":id
                  
            ] as [String : Any]
        let header = ["Content-Type":"application/x-www-form-urlencoded ",
                      "Authorization":token
            ] as! [String : String]
        Alamofire.request(url,method: .get,parameters: parameterss,headers:header)
            .responseJSON { response in
                switch response.result {
                case .success:
                    let responseResult = JSON(response.result.value!)
                    if let data = responseResult.dictionary{
                        
                        if let mainImageURL = data["mainImageURL"]?.array {
                            
                            for i in mainImageURL{
                                let url = "http://" + (i["name"].stringValue)
                                let urls = URL(string:url)
                                let image_id = i["id"].stringValue
                                self.Arr_image_id.append(image_id)
                                if let data = try? Data(contentsOf: urls!)
                                {
                                    self.Arr_image.append(UIImage(data: data)!)
                                }
                                
                               
                                
                            }
                            if self.Arr_image.count == 5 {
                              self.ImportPhotosFrom_btn_view.isHidden = true
                            }else{
                                self.ImportPhotosFrom_btn_view.isHidden = false
                            }
                            SVProgressHUD.dismiss()
                            self.previewView?.reloadData()

                            
                        }else{
                            SVProgressHUD.dismiss()
                        }
                        
                        // النوع الفرعي
                        if let propertyType = data["propertyType"]?.intValue {
                            switch propertyType{
                            case 21:
                                self.parameters["PropertyType"] = self.Arr_property_Type_Commercial[0]["id"].stringValue
                                self.btn_Property_Sub.setTitle(self.Arr_property_Type_Commercial[0]["name"].stringValue, for: .normal)
                                
                                break
                            case 22:
                                self.parameters["PropertyType"] = self.Arr_property_Type_Commercial[1]["id"].stringValue
                                self.btn_Property_Sub.setTitle(self.Arr_property_Type_Commercial[1]["name"].stringValue, for: .normal)
                                break
                            case 23:
                                self.parameters["PropertyType"] = self.Arr_property_Type_Commercial[2]["id"].stringValue
                                self.btn_Property_Sub.setTitle(self.Arr_property_Type_Commercial[2]["name"].stringValue, for: .normal)
                                break
                            case 1263:
                                self.parameters["PropertyType"] = self.Arr_property_Type_Commercial[3]["id"].stringValue
                                self.btn_Property_Sub.setTitle(self.Arr_property_Type_Commercial[3]["name"].stringValue, for: .normal)
                                break
                                case 1264:
                                     self.parameters["PropertyType"] = self.Arr_property_Type_Commercial[4]["id"].stringValue
                                     self.btn_Property_Sub.setTitle(self.Arr_property_Type_Commercial[4]["name"].stringValue, for: .normal)
                                     break
                                
                                case 1265:
                                     self.parameters["PropertyType"] = self.Arr_property_Type_Commercial[5]["id"].stringValue
                                     self.btn_Property_Sub.setTitle(self.Arr_property_Type_Commercial[5]["name"].stringValue, for: .normal)
                                     break
                                
                                case 1266:
                                     self.parameters["PropertyType"] = self.Arr_property_Type_Commercial[6]["id"].stringValue
                                     self.btn_Property_Sub.setTitle(self.Arr_property_Type_Commercial[6]["name"].stringValue, for: .normal)
                                     break
                                
                                case 1267:
                                     self.parameters["PropertyType"] = self.Arr_property_Type_Commercial[7]["id"].stringValue
                                     self.btn_Property_Sub.setTitle(self.Arr_property_Type_Commercial[7]["name"].stringValue, for: .normal)
                                     break
                         
                            case 18:
                                self.parameters["PropertyType"] = self.Arr_Property_Type_Residential[0]["id"].stringValue
                                self.btn_Property_Sub.setTitle(self.Arr_Property_Type_Residential[0]["name"].stringValue, for: .normal)
                                break
                            case 19:
                                self.parameters["PropertyType"] = self.Arr_Property_Type_Residential[1]["id"].stringValue
                                self.btn_Property_Sub.setTitle(self.Arr_Property_Type_Residential[1]["name"].stringValue, for: .normal)
                                break
                            case 20:
                                self.parameters["PropertyType"] = self.Arr_Property_Type_Residential[2]["id"].stringValue
                                self.btn_Property_Sub.setTitle(self.Arr_Property_Type_Residential[2]["name"].stringValue, for: .normal)
                                break
                                case 1257:
                                    self.parameters["PropertyType"] = self.Arr_Property_Type_Residential[3]["id"].stringValue
                                    self.btn_Property_Sub.setTitle(self.Arr_Property_Type_Residential[3]["name"].stringValue, for: .normal)
                                    break
                                case 1258:
                                    self.parameters["PropertyType"] = self.Arr_Property_Type_Residential[4]["id"].stringValue
                                    self.btn_Property_Sub.setTitle(self.Arr_Property_Type_Residential[4]["name"].stringValue, for: .normal)
                                    break
                                
                                case 1259:
                                    self.parameters["PropertyType"] = self.Arr_Property_Type_Residential[5]["id"].stringValue
                                    self.btn_Property_Sub.setTitle(self.Arr_Property_Type_Residential[5]["name"].stringValue, for: .normal)
                                    break
                                
                                case 1260:
                                    self.parameters["PropertyType"] = self.Arr_Property_Type_Residential[6]["id"].stringValue
                                    self.btn_Property_Sub.setTitle(self.Arr_Property_Type_Residential[6]["name"].stringValue, for: .normal)
                                    break
                                
                                case 1261:
                                    self.parameters["PropertyType"] = self.Arr_Property_Type_Residential[7]["id"].stringValue
                                    self.btn_Property_Sub.setTitle(self.Arr_Property_Type_Residential[7]["name"].stringValue, for: .normal)
                                    break
                                
                                case 1262:
                                    self.parameters["PropertyType"] = self.Arr_Property_Type_Residential[8]["id"].stringValue
                                    self.btn_Property_Sub.setTitle(self.Arr_Property_Type_Residential[8]["name"].stringValue, for: .normal)
                                    break
                                
                            default:
                                break
                            }
                           
                        }
                        
                        self.parameters["SleepingRoom"] = "1"

                        if let mainPropertyType = data["mainPropertyType"]?.intValue {
                            switch mainPropertyType{
                            case 15:
                                self.parameters["PropertyType"] = self.Arr_Property[0]["id"].stringValue
                                self.btn_Property_Sub.setTitle(self.Arr_Property[0]["name"].stringValue, for: .normal)
                                  self.setupProperty_TypeDrop(data:(self.Arr_Property_Type_Residential))
                                break
                            case 16:
                                self.parameters["PropertyType"] = self.Arr_Property[1]["id"].stringValue
                                self.btn_Property_Sub.setTitle(self.Arr_Property[1]["name"].stringValue, for: .normal)
                                  self.setupProperty_TypeDrop(data:(self.Arr_property_Type_Commercial))
                                break
                                
                                case 1269:
                                     self.parameters["PropertyType"] = self.Arr_Property[2]["id"].stringValue
                                     self.btn_Property_Sub.setTitle(self.Arr_Property[2]["name"].stringValue, for: .normal)

                                     break
                                
                                case 1273:
                                    self.parameters["PropertyType"] = self.Arr_Property[3]["id"].stringValue
                                    self.btn_Property_Sub.setTitle(self.Arr_Property[3]["name"].stringValue, for: .normal)

                                                                   break
                                
                            default:
                                break
                            }
                        }
                        if let lat = data["latMap"]?.stringValue {
                            if let lng = data["lngMap"]?.stringValue {
                                let location = GMSCameraPosition.camera(withLatitude: Double(lat) ?? 0.0, longitude: Double(lng) ?? 0.0, zoom: 17.0)
                                
                                self.mapView.camera = location
                            }
                        }
                        if let propertyClass = data["propertyClass"]?.intValue {
                            switch propertyClass{
                            case 26:
                                
                                //self.parameters["PropertyClass"] = self.Arr_Property_Type[0]["id"].stringValue
                                self.btn_Property_type.setTitle( self.Arr_Property_Type[0]["name"].stringValue, for: .normal)
                                self.propertySelected(Selceted: 1)
                               
                                break
                            case 27:
                              //  self.parameters["PropertyClass"] = self.Arr_Property_Type[1]["id"].stringValue
                               self.btn_Property_type.setTitle( self.Arr_Property_Type[1]["name"].stringValue, for: .normal)
                                
                                self.propertySelected(Selceted: 2)
                                break
                                
                            default:
                                break
                            }
                        }
                        if let leaseTerm = data["leaseTerm"]?.intValue {
                            switch leaseTerm{
                            case 64:
                                
                                self.parameters["LeaseTerm"] = self.Arr_Lease[0]["id"].stringValue
                                self.btn_duration.setTitle(self.Arr_Lease[0]["name"].stringValue, for: .normal)
                                
                                break
                            case 65:
                                self.parameters["LeaseTerm"] = self.Arr_Lease[1]["id"].stringValue
                                self.btn_duration.setTitle(self.Arr_Lease[1]["name"].stringValue, for: .normal)
                                break
                            case 66:
                                self.parameters["LeaseTerm"] = self.Arr_Lease[2]["id"].stringValue
                                self.btn_duration.setTitle(self.Arr_Lease[2]["name"].stringValue, for: .normal)
                                break
                            case 67:
                                self.parameters["LeaseTerm"] = self.Arr_Lease[3]["id"].stringValue
                                self.btn_duration.setTitle(self.Arr_Lease[3]["name"].stringValue, for: .normal)
                                break
                            case 68:
                                self.parameters["LeaseTerm"] = self.Arr_Lease[4]["id"].stringValue
                                self.btn_duration.setTitle(self.Arr_Lease[4]["name"].stringValue, for: .normal)
                                break
                                
                            default:
                                break
                            }
                            
                        }
//                        if let country = data["country"]?.intValue {
//                            let index = self.Arr_Country.index { (element) -> Bool in
//                                return element["id"].stringValue == country.description
//                            }
//                            if index != nil{
//                                self.btn_Country.setTitle(self.Arr_Country[index ?? 0]["name"].stringValue
//, for: .normal)
//                                self.parameters["Country"] = self.Arr_Country[index ?? 0]["id"].stringValue
//
//
//                                self.loadCityData(id: self.Arr_Country[index ?? 0]["id"].stringValue)
//                                if let city = data["city"]?.intValue {
//                                    let index = self.Arr_City.index { (element) -> Bool in
//                                        return element["id"].stringValue == city.description
//                                    }
//                                    if index != nil{
//                                        self.btn_City.setTitle(self.Arr_City[index ?? 0]["name"].stringValue
//                                            , for: .normal)
//                                        self.parameters["City"] = self.Arr_City[index ?? 0]["id"].stringValue
//                                    }
//                                }
//                            }
//                        }
                       
                        if let room = data["room"]?.intValue {
                            switch room{
                            case 1:
                                self.parameters["Room"] = self.Arr_Rooms[0]["id"].stringValue
                                self.btn_Rooms.setTitle(self.Arr_Rooms[0]["name"].stringValue, for: .normal)
                               
                                break
                            case 2:
                                self.parameters["Room"] = self.Arr_Rooms[1]["id"].stringValue
                                self.btn_Rooms.setTitle(self.Arr_Rooms[1]["name"].stringValue, for: .normal)
                                break
                            case 3:
                                self.parameters["Room"] = self.Arr_Rooms[2]["id"].stringValue
                                self.btn_Rooms.setTitle(self.Arr_Rooms[2]["name"].stringValue, for: .normal)
                                break
                            case 4:
                                self.parameters["Room"] = self.Arr_Rooms[3]["id"].stringValue
                                self.btn_Rooms.setTitle(self.Arr_Rooms[3]["name"].stringValue, for: .normal)
                                break
                            case 5:
                                self.parameters["Room"] = self.Arr_Rooms[4]["id"].stringValue
                                self.btn_Rooms.setTitle(self.Arr_Rooms[4]["name"].stringValue, for: .normal)
                                break
                            default:
                                break
                            }
                        }
                        if let bathRoom = data["bathRoom"]?.intValue {
                            switch bathRoom{
                            case 1:
                                self.parameters["BathRoom"] = self.Arr_bathRoom[0]["id"].stringValue
                                self.btn_BathRooms.setTitle(self.Arr_bathRoom[0]["name"].stringValue, for: .normal)
                                break
                            case 2:
                                self.parameters["BathRoom"] = self.Arr_bathRoom[1]["id"].stringValue
                                self.btn_BathRooms.setTitle(self.Arr_bathRoom[1]["name"].stringValue, for: .normal)
                                break
                            case 3:
                                self.parameters["BathRoom"] = self.Arr_bathRoom[2]["id"].stringValue
                                self.btn_BathRooms.setTitle(self.Arr_bathRoom[2]["name"].stringValue, for: .normal)
                                break
                            case 4:
                                self.parameters["BathRoom"] = self.Arr_bathRoom[3]["id"].stringValue
                                self.btn_BathRooms.setTitle(self.Arr_bathRoom[3]["name"].stringValue, for: .normal)
                                break
                            case 5:
                                self.parameters["BathRoom"] = self.Arr_bathRoom[4]["id"].stringValue
                                self.btn_BathRooms.setTitle(self.Arr_bathRoom[4]["name"].stringValue, for: .normal)
                                break
                            default:
                                break
                            }
                        }
                        
                        if let notes = data["notes"]?.stringValue{
                            self.txt_details.text = notes
                        }
                        
                        
                        if let price = data["price"]?.intValue {
                            self.txt_price.text = price.description
                        }
                        if let sizeBuild = data["sizeBuild"]?.intValue {
                            self.txt_Place.text = sizeBuild.description
                        }
                        if let floorsNumber = data["floorsNumber"]?.intValue {
                            switch floorsNumber{
                            case 1:
                                self.parameters["floorsNumber"] = self.Arr_CurrentFloor[0]["id"].stringValue
                                self.btn_Current_Floors.setTitle(self.Arr_CurrentFloor[0]["name"].stringValue, for: .normal)
                                break
                            case 2:
                                self.parameters["floorsNumber"] = self.Arr_CurrentFloor[1]["id"].stringValue
                                self.btn_Current_Floors.setTitle(self.Arr_CurrentFloor[1]["name"].stringValue, for: .normal)
                                break
                            case 3:
                                self.parameters["floorsNumber"] = self.Arr_CurrentFloor[2]["id"].stringValue
                                self.btn_Current_Floors.setTitle(self.Arr_CurrentFloor[2]["name"].stringValue, for: .normal)
                                break
                            case 4:
                                self.parameters["floorsNumber"] = self.Arr_CurrentFloor[3]["id"].stringValue
                                self.btn_Current_Floors.setTitle(self.Arr_CurrentFloor[3]["name"].stringValue, for: .normal)
                                break
                            case 5:
                                self.parameters["floorsNumber"] = self.Arr_CurrentFloor[4]["id"].stringValue
                                self.btn_Current_Floors.setTitle(self.Arr_CurrentFloor[4]["name"].stringValue, for: .normal)
                                break
                            default:
                                break
                            }
                        }
                        if let floor = data["floor"]?.intValue {
                            switch floor{
                            case 36:
                                
                                self.parameters["floor"] = self.Arr_floor[0]["id"].stringValue
                                self.btn_Floors.setTitle(self.Arr_floor[0]["name"].stringValue, for: .normal)
                                break
                            case 37:
                                self.parameters["floor"] = self.Arr_floor[1]["id"].stringValue
                                self.btn_Floors.setTitle(self.Arr_floor[1]["name"].stringValue, for: .normal)
                                break
                            case 38:
                                self.parameters["floor"] = self.Arr_floor[2]["id"].stringValue
                                self.btn_Floors.setTitle(self.Arr_floor[2]["name"].stringValue, for: .normal)
                                break
                            case 39:
                                self.parameters["floor"] = self.Arr_floor[3]["id"].stringValue
                                self.btn_Floors.setTitle(self.Arr_floor[3]["name"].stringValue, for: .normal)
                                break
                            case 40:
                                self.parameters["floor"] = self.Arr_floor[4]["id"].stringValue
                                self.btn_Floors.setTitle(self.Arr_floor[4]["name"].stringValue, for: .normal)
                                break
                            case 41:
                                self.parameters["floor"] = self.Arr_floor[5]["id"].stringValue
                                self.btn_Floors.setTitle(self.Arr_floor[5]["name"].stringValue, for: .normal)
                                break
                            case 42:
                                self.parameters["floor"] = self.Arr_floor[6]["id"].stringValue
                                self.btn_Floors.setTitle(self.Arr_floor[6]["name"].stringValue, for: .normal)
                                break
                            case 43:
                                self.parameters["floor"] = self.Arr_floor[7]["id"].stringValue
                                self.btn_Floors.setTitle(self.Arr_floor[7]["name"].stringValue, for: .normal)
                                break
                            case 44:
                                self.parameters["floor"] = self.Arr_floor[8]["id"].stringValue
                                self.btn_Floors.setTitle(self.Arr_floor[8]["name"].stringValue, for: .normal)
                                break
                                case 257:
                                  self.parameters["floor"] = self.Arr_floor[9]["id"].stringValue
                                self.btn_Floors.setTitle(self.Arr_floor[9]["name"].stringValue, for: .normal)
                                    break
                            default:
                                break
                            }
                        }
                        if let buildAge = data["buildAge"]?.intValue {
                            switch buildAge{
                            case 28:
                                self.parameters["BuildAge"] = self.Arr_BulidingAge[0]["id"].stringValue
                                self.btn_Building.setTitle(self.Arr_BulidingAge[0]["name"].stringValue, for: .normal)
                                break
                            case 29:
                                self.parameters["BuildAge"] = self.Arr_BulidingAge[1]["id"].stringValue
                                self.btn_Building.setTitle(self.Arr_BulidingAge[1]["name"].stringValue, for: .normal)
                                break
                            case 30:
                                self.parameters["BuildAge"] = self.Arr_BulidingAge[2]["id"].stringValue
                                self.btn_Building.setTitle(self.Arr_BulidingAge[2]["name"].stringValue, for: .normal)
                                break
                            default:
                                break
                            }
                        }
                        
                        
                        if let priceCurrency = data["priceType"]?.intValue {
                            let index = self.Arr_priceCurrency.index { (element) -> Bool in
                                return element["id"].stringValue == priceCurrency.description
                            }
                            if index != nil{
                                self.btn_priceCurrency.setTitle(self.Arr_priceCurrency[index ?? 0]["name"].stringValue
                                    , for: .normal)
                                self.parameters["priceType"] = self.Arr_priceCurrency[index ?? 0]["id"].stringValue
                                
                                }
                            }
                        
                        
                        
                        
                        if let spaceUnit = data["unitArea"]?.intValue {
                            let index = self.Arr_spaceUnit.index { (element) -> Bool in
                                return element["id"].stringValue == spaceUnit.description
                            }
                            if index != nil{
                                self.btn_spaceUnit.setTitle(self.Arr_spaceUnit[index ?? 0]["name"].stringValue
                                    , for: .normal)
                                self.parameters["unitArea"] = self.Arr_spaceUnit[index ?? 0]["id"].stringValue
                                
                            }
                        }
                    
                       

                        if let furniture = data["furniture"]?.intValue {
                            if furniture == 52{
                                
                                self.parameters["furniture"] = "52"
                                
                                self.switch_furniture.isOn = true
                                
                                
                            }else{
                                self.parameters["furniture"] = "53"
                                
                                self.switch_furniture.isOn = false
                            }
                            
                        }
                        if let heating = data["heating"]?.intValue {
                            if heating == 45{
                                
                                self.parameters["heating"] = "45"
                                
                                self.switch_Heating.isOn = false
                                
                                
                            }else{
                                self.parameters["heating"] = "46"
                                
                                self.switch_Heating.isOn = true
                            }
                            
                      
                        }
                        if let heatingDistribution = data["heatingDistribution"]?.intValue {
                            if heatingDistribution == 47{
                                
                                self.parameters["heating"] = "47"
                                self.btn_heating_Distrbution.setTitle(self.Arr_heatingDistribution[0]["name"].stringValue, for: .normal)
                                self.parameters["HeatingDistribution"] = "47"
                                
                                
                                
                            }else{
                                self.parameters["heating"] = "48"
                                self.btn_heating_Distrbution.setTitle(self.Arr_heatingDistribution[1]["name"].stringValue, for: .normal)
                                self.parameters["HeatingDistribution"] = "48"
                                
                            }
                        }
                        if let heatingType = data["heatingType"]?.intValue {
                            if heatingType == 49{
                                
                                self.parameters["heating"] = "47"
                                self.btn_heating_type.setTitle(self.Arr_heatingType[0]["name"].stringValue, for: .normal)
                                self.parameters["HeatingDistribution"] = "47"
                                
                                
                                
                            }else if heatingType == 50{
                                self.parameters["heating"] = "50"
                                self.btn_heating_type.setTitle(self.Arr_heatingType[1]["name"].stringValue, for: .normal)
                                self.parameters["HeatingDistribution"] = "50"
                                
                            }else{
                                self.parameters["heating"] = "51"
                                self.btn_heating_type.setTitle(self.Arr_heatingType[2]["name"].stringValue, for: .normal)
                                self.parameters["HeatingDistribution"] = "51"
                            }
                        }
                        if let porch = data["porch"]?.intValue {
                            if porch == 54{
                                
                                self.parameters["porch"] = "54"
                                
                                self.switch_porch.isOn = true
                                
                                
                            }else{
                                self.parameters["porch"] = "55"
                                
                                self.switch_porch.isOn = false
                            }
                        }
                        if let usageStatus = data["usageStatus"]?.intValue {
                            switch usageStatus{
                            case 56:
                                self.propertyStatus(Selceted: 1)
                                break
                            case 57:
                                self.propertyStatus(Selceted: 2)
                                break
                            case 58 :
                                self.propertyStatus(Selceted: 3)
                                break
                            default:
                                break
                            }
                            
                        }
                        if let whoOwnerAds = data["whoOwnerAds"]?.intValue {
                            switch whoOwnerAds{
                            case 59:
                                self.OwnerSelected(Selceted: 1)
                                break
                            case 60:
                                self.OwnerSelected(Selceted: 2)
                                break
                            case 61 :
                                self.OwnerSelected(Selceted: 3)
                                break
                            case 62 :
                                self.OwnerSelected(Selceted: 4)
                                break
                            default:
                                break
                            }
                        }
                        if let internet = data["internet"]?.boolValue {
                            if internet == false{
                                
                                self.parameters["internet"] = "false"
                                
                                self.switch_Internet.isOn = false
                                
                                
                            }else{
                                self.parameters["internet"] = "true"
                                
                                self.switch_Internet.isOn = true
                            }
                        }
                        if let cleaning = data["cleaning"]?.boolValue {
                            if cleaning == false{
                                
                                self.parameters["Cleaning"] = "false"
                                
                                self.switch_Cleaning.isOn = false
                                
                                
                            }else{
                                self.parameters["Cleaning"] = "true"
                                
                                self.switch_Cleaning.isOn = true
                            }
                        }
                        if let pool = data["pool"]?.boolValue {
                            if pool == false{
                                
                                self.parameters["Pool"] = "false"
                                
                                self.switch_pool.isOn = false
                                
                                
                            }else{
                                self.parameters["Pool"] = "true"
                                
                                self.switch_pool.isOn = true
                            }
                        }
                        if let elevator = data["elevator"]?.boolValue {
                            if elevator == false{
                                
                                self.parameters["Elevator"] = "false"
                                
                                self.switch_Elevator.isOn = false
                                
                                
                            }else{
                                self.parameters["Elevator"] = "true"
                                
                                self.switch_Elevator.isOn = true
                            }
                        }
                        if let parking = data["parking"]?.boolValue {
                            if parking == false{
                                self.parameters["Parking"] = "false"
                                
                                self.switch_parking.isOn = false
                            
                            }else{
                                self.parameters["Parking"] = "true"
                                self.switch_parking.isOn = true
                            }
                        }
                        if let entertainment = data["entertainment"]?.boolValue
                        {
                            if entertainment == false{
                                self.parameters["Entertainment"] = "false"
                                self.switch_fun.isOn = false
                            }else{
                                self.parameters["Entertainment"] = "true"
                                self.switch_fun.isOn = true
                            }
                           
                        }
                        if let hall = data["hall"]?.boolValue {
                            
                            if hall == false{
                            self.parameters["hall"] = "false"
                            self.switch_fun.isOn = false
                            }else{
                            self.parameters["hall"] = "true"
                            self.switch_fun.isOn = true
                            }
                            
                        }
                      
                        
                        
                        
                    }
                case .failure(let error):
                    print("******** \(error.localizedDescription) *******")
                    
                }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    func setupCurrencyDrop() {
        
        drop_priceCurrency.anchorView = btn_priceCurrency
        
        let lang = languageVC.lang
        if lang == "ar"{
            drop_priceCurrency.anchorView = txt_price
            drop_priceCurrency.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }
            
            
        }
        
        
        drop_priceCurrency.bottomOffset = CGPoint(x: 0, y: btn_priceCurrency.bounds.height)
        
        
        var BranchNames = [String]()
        for item in Arr_priceCurrency {
            
            BranchNames.append("\(item["name"].stringValue )")
            
        }
        drop_priceCurrency.dataSource = BranchNames
        
        
        drop_priceCurrency.selectionAction = { [weak self] (index, item) in
            self?.parameters["priceType"] = self?.Arr_priceCurrency[index]["id"].stringValue
            self?.btn_priceCurrency.setTitle(item, for: .normal)
            
        }
        
        
    }
    
    func setupSpaceUnitDrop() {
        
        drop_spaceUnit.anchorView = btn_spaceUnit
        
        let lang = languageVC.lang
        if lang == "ar"{
            drop_spaceUnit.anchorView = txt_Place
            drop_spaceUnit.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }
            
            
        }
        
        
        drop_spaceUnit.bottomOffset = CGPoint(x: 0, y: btn_spaceUnit.bounds.height)
        
        
        var BranchNames = [String]()
        for item in Arr_spaceUnit {
            
            BranchNames.append("\(item["name"].stringValue )")
            
        }
        
        drop_spaceUnit.dataSource = BranchNames
        
        
        
        drop_spaceUnit.selectionAction = { [weak self] (index, item) in
            self?.parameters["unitArea"] = self?.Arr_spaceUnit[index]["id"].stringValue
            self?.btn_spaceUnit.setTitle(item, for: .normal)
            
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

    func setupDurationDrop() {
        
        
        drop_choseDuration.anchorView = btn_duration
        
        
        drop_choseDuration.bottomOffset = CGPoint(x: 0, y: btn_duration.bounds.height)
        let lang = languageVC.lang

        if lang == "ar"{
            drop_choseDuration.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }

        }
        
        
        var BranchNames = [String]()
        for item in Arr_Lease {
            
            BranchNames.append("\(item["name"] )")
            
        }
//        self.parameters["LeaseTerm"] = self.Arr_Lease[0]["id"].stringValue
//        self.btn_duration.setTitle(BranchNames[0], for: .normal)
        drop_choseDuration.dataSource = BranchNames
        
        
        drop_choseDuration.selectionAction = { [weak self] (index, item) in
            
            self?.parameters["LeaseTerm"] = self?.Arr_Lease[index]["id"].stringValue
            self?.btn_duration.setTitle(item, for: .normal)
            
        }
        
        
    }
       
    //    new
        
        
          func setupPropertyDrop() {
                drop_choseProperty.anchorView = btn_Property_type
        let lang = languageVC.lang
                if lang == "ar"{
                    drop_choseProperty.anchorView = btn_Property_Sub
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
        
        
        //new
     
            func setupProperty_TypeDrop(data:[JSON]) {

                drop_chosePropertyType.anchorView = btn_Property_Sub
                let lang = languageVC.lang
                if lang == "ar"{
                    drop_chosePropertyType.anchorView = btn_Property_type
                    drop_chosePropertyType.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }
                }

                drop_chosePropertyType.bottomOffset = CGPoint(x: 0, y: btn_Property_Sub.bounds.height)


                var BranchNames = [String]()
                for item in data {

                    BranchNames.append("\(item["name"].stringValue )")

                }
                self.parameters["PropertyType"] = data[0]["id"].stringValue
                self.btn_Property_Sub.setTitle(BranchNames[0], for: .normal)
                drop_chosePropertyType.dataSource = BranchNames


                drop_chosePropertyType.selectionAction = { [weak self] (index, item) in
                    self?.parameters["PropertyType"] = data[index]["id"].stringValue
                    self?.btn_Property_Sub.setTitle(item, for: .normal)

                }


            }
    
    // Second Screen
    func setupBuildingDrop() {
        
        
        drop_choseBulidingAge.anchorView = btn_Building
        
        
        drop_choseBulidingAge.bottomOffset = CGPoint(x: 0, y: btn_Building.bounds.height)
        let lang = languageVC.lang

        if lang == "ar"{
            drop_choseBulidingAge.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }

        }
        
        var BranchNames = [String]()
        for item in Arr_BulidingAge {
            
            BranchNames.append("\(item["name"].stringValue )")
            
        }
       
        drop_choseBulidingAge.dataSource = BranchNames
        
        
        drop_choseBulidingAge.selectionAction = { [weak self] (index, item) in
            self?.parameters["BuildAge"] = self?.Arr_BulidingAge[index]["id"].stringValue
            self?.btn_Building.setTitle(item, for: .normal)
           
            
        }
        
        
    }
    
    

    func setupfloorDrop() {
        
        
        drop_choseFloors.anchorView = btn_Floors
        
        let lang = languageVC.lang
        if lang == "ar"{
            drop_choseFloors.anchorView = btn_Current_Floors
            drop_choseFloors.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }

            
        }
        
        
        drop_choseFloors.bottomOffset = CGPoint(x: 0, y: btn_Floors.bounds.height)
        
        
        var BranchNames = [String]()
        for item in Arr_floor {
            
            BranchNames.append("\(item["name"].stringValue )")
            
        }
//        self.parameters["FloorsNumber"] = self.Arr_CurrentFloor[0]["id"].stringValue
//        self.btn_Floors.setTitle(BranchNames[0], for: .normal)
        drop_choseFloors.dataSource = BranchNames
        
        
        drop_choseFloors.selectionAction = { [weak self] (index, item) in
            self?.parameters["floor"] = self?.Arr_floor[index]["id"].stringValue
            self?.btn_Floors.setTitle(item, for: .normal)
            
            
        }
        
        
    }
    func setupCurrentFloorDrop() {
        
        drop_choseCurrentFloor.anchorView = btn_Current_Floors
        
        let lang = languageVC.lang
        if lang == "ar"{
            drop_choseCurrentFloor.anchorView  = btn_Floors
            drop_choseCurrentFloor.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }

            
        }
        
        
        drop_choseCurrentFloor.bottomOffset = CGPoint(x: 0, y: btn_Current_Floors.bounds.height)
        
        
        var BranchNames = [String]()
        for item in Arr_CurrentFloor {
            
            BranchNames.append("\(item["name"].stringValue )")
            
        }
        
//        self.parameters["Floor"] = self.Arr_CurrentFloor[0]["id"].stringValue
//        self.btn_Current_Floors.setTitle(BranchNames[0], for: .normal)
        drop_choseCurrentFloor.dataSource = BranchNames
        
        
        drop_choseCurrentFloor.selectionAction = { [weak self] (index, item) in
            self?.parameters["floorsNumber"] = self?.Arr_CurrentFloor[index]["id"].stringValue
            self?.btn_Current_Floors.setTitle(item, for: .normal)
            
        }
        
        
    }
    func setupRoomsDrop() {
        
        
        drop_choseRooms.anchorView = btn_Rooms
        
        let lang = languageVC.lang
        if lang == "ar"{
            drop_choseRooms.anchorView  = btn_BathRooms
            drop_choseRooms.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }

            
        }
        
        
        drop_choseRooms.bottomOffset = CGPoint(x: 0, y: btn_Rooms.bounds.height)
        
        
        var BranchNames = [String]()
        for item in Arr_Rooms {
            
            BranchNames.append("\(item["name"].stringValue )")
            
        }
//        self.parameters["Room"] = self.Arr_Rooms[0]["id"].stringValue
//        self.btn_Rooms.setTitle(BranchNames[0], for: .normal)
        drop_choseRooms.dataSource = BranchNames
        
        
        drop_choseRooms.selectionAction = { [weak self] (index, item) in
            
            self?.btn_Rooms.setTitle(item, for: .normal)
            self?.parameters["Room"] = self?.Arr_Rooms[index]["id"].stringValue
            
        }
        
        
    }
    func setupBathRoomsDrop() {
        
        drop_choseBathRooms.anchorView = btn_BathRooms
        
        let lang = languageVC.lang
        if lang == "ar"{
            drop_choseBathRooms.anchorView = btn_Rooms
            drop_choseBathRooms.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }

            
        }
        
        
        drop_choseBathRooms.bottomOffset = CGPoint(x: 0, y: btn_BathRooms.bounds.height)
        
        
        var BranchNames = [String]()
        for item in Arr_bathRoom {
            
            BranchNames.append("\(item["name"].stringValue )")
            
        }
      
        drop_choseBathRooms.dataSource = BranchNames
        
        
        drop_choseBathRooms.selectionAction = { [weak self] (index, item) in
            
            self?.btn_BathRooms.setTitle(item, for: .normal)
            self?.parameters["BathRoom"] = self?.Arr_bathRoom[index]["id"].stringValue
            
            
        }
        
        
    }
    func setupDistributionDrop() {
        
        
        drop_choseHeatingDistribution.anchorView = btn_heating_Distrbution
        
        let lang = languageVC.lang
        if lang == "ar"{
            drop_choseHeatingDistribution.anchorView = btn_heating_type
            drop_choseHeatingDistribution.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }

            
        }
        
        drop_choseHeatingDistribution.bottomOffset = CGPoint(x: 0, y: btn_heating_Distrbution.bounds.height)
        
        
        var BranchNames = [String]()
        for item in Arr_heatingDistribution {
            
            BranchNames.append("\(item["name"].stringValue )")
            
        }
        
        drop_choseHeatingDistribution.dataSource = BranchNames
        
        
        drop_choseHeatingDistribution.selectionAction = { [weak self] (index, item) in
            
            self?.btn_heating_Distrbution.setTitle(item, for: .normal)
            self?.parameters["HeatingDistribution"] = self?.Arr_heatingDistribution[index]["id"].stringValue
            
            
        }
        
        
    }
    func setupHeatingTypeDrop() {
        
        

        drop_choseHeatingType.anchorView = btn_heating_type
        let lang = languageVC.lang
        if lang == "ar"{
            drop_choseHeatingType.anchorView = btn_heating_Distrbution
            drop_choseHeatingType.customCellConfiguration = {(index, item, cell: DropDownCell) -> Void in cell.optionLabel.textAlignment = .right }

            
        }
        
        drop_choseHeatingType.bottomOffset = CGPoint(x: 0, y: btn_heating_type.bounds.height)
        
        
        var BranchNames = [String]()
        for item in Arr_heatingType {
            
            BranchNames.append("\(item["name"].stringValue )")
            
        }
//        self.parameters["HeatingType"] = self.Arr_heatingType[0]["id"].stringValue
//        self.btn_heating_type.setTitle(BranchNames[0], for: .normal)
        drop_choseHeatingType.dataSource = BranchNames
        
        
        drop_choseHeatingType.selectionAction = { [weak self] (index, item) in
            
            self?.btn_heating_type.setTitle(item, for: .normal)
            self?.parameters["HeatingType"] = self?.Arr_heatingType[index]["id"].stringValue
            
            
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
//extension EditPropertyVC: GMSMapViewDelegate {
//
//    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
//        self.location = mapView.camera.target
//    }
//}



extension  EditPropertyVC : CLLocationManagerDelegate {
    
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
            
            print("111111")
            //        let camera = GMSCameraPosition.camera(withTarget: marker.position, zoom: 12)
            //        guard let markerData = marker.userData as? BMarker else {return false}
            //        guard let branch = markerData.branch else {return false}
            //        mapView.animate(to: camera)
            //        print(branch.merchant)
            //        //  addMerchantDetailView(merchant: branch.merchant)
            //        // v1.2.7
            //        let vc = sh()
            //        vc.merchant = branch.merchant
            //        if  branch.merchant.isLoyal != true {
            //            // to hide thanks you
            //            vc.merchant_isLoyal = true
            //        }
            //        self.navigationController?.pushViewController( vc, animated: true)
            //        //        //self.present(vc, animated: true , completion: nil )
            //
            return true
        }
        
        func mapView(_ mapView: GMSMapView, didCloseInfoWindowOf marker: GMSMarker) {
            print("closed")
        }
        
        func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
            
            mapView.clear()
            
            let position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
            let london = GMSMarker(position: position)
            london.title = "موقع الحاضنة"
            london.icon = UIImage(named: "Group 277")
            london.map = mapView
            
            let currZoom = self.mapView.camera.zoom
                    print("currZoomcurrZoom\(currZoom)")

            
            self.userLat = coordinate.latitude.description
            self.userLng = coordinate.longitude.description
            
            self.parameters["LatMap"] = coordinate.latitude.description
            self.parameters["LngMap"] = coordinate.longitude.description
            self.parameters["Zoom"] = NSString(format: "%.0f", currZoom) as String

            //view.endEditing(true)
            
            getAddressFromLatLong()
        }
        
        
        func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
            print(123)
            
            
            //   centerLocator.transform = CGAffineTransform(rotationAngle: 45)
            // showAcoordingBranches()
            
            
        }
        
        
        func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
            print (position)
    //        self.userLat =  position.target.latitude.description
    //        self.userLng = position.target.longitude.description
    //
            //   self.storePageEndPostion(lat:  position.target.latitude.description, lng: position.target.longitude.description)
            
        }
    
    

    
    
      func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
          
          let camera = GMSCameraUpdate.setTarget(currentLocation, zoom: 14)
          mapView.animate(with: camera)
          
          return true
      }
      
      func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
          switch status {
          case .authorizedAlways:
              print("always")
              locationManager.startUpdatingLocation()
          case .authorizedWhenInUse:
              print("authorizedWhenInUse")
              
              locationManager.startUpdatingLocation()
          case .denied:
              print("denied")
              
              //   aleartStting()
              
          case .notDetermined:
              print("notDetermined")
              locationManager.requestAlwaysAuthorization()
          case .restricted:
              return
              //   let cancelAction = UIAlertAction(title:  KOLocalizedString("KeyCancel"), style: .default, handler: nil)
              //      alert(message: KOLocalizedString("KeyYouredeviceIsRestricted"), title: KOLocalizedString("KeyLocationNeeded"), actions: [cancelAction])
          }
          
      }
      
      
      func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
          guard let newLocation = locations.last else {return}
          self.currentLocation = newLocation.coordinate
          userLocationMarker.position = currentLocation
          
          //        if !isUserLocationSet {
          //            let camera = GMSCameraUpdate.setTarget(self.currentLocation)
          //            mapView.animate(with: camera)
          //            isUserLocationSet = true
          //        }
          
      }
      
      
      
      
      func locationManager(_ manager: CLLocationManager, didFailWithError error: Swift.Error) {
          print("Location Manager failed with the following error: \(error)")
      }
    

    
}


extension Array {
    func canSupport(index: Int ) -> Bool {
        return index >= startIndex && index < endIndex
    }
}
