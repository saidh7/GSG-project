//
//  RSDetailsViewController.swift
//  Wasatta
//
//  Created by Said Abdulla on 11/15/18.
//  Copyright © 2018 Said Abdulla. All rights reserved.
//

import UIKit
import ImageSlideshow
import MapViewPlus
import CoreLocation
import MapKit
import Floaty
import SVProgressHUD
import Kingfisher
import SwiftyJSON
import Alamofire
import MessageUI
import Localize_Swift




class RSDetailsViewController: UIViewController, FloatyDelegate, MFMailComposeViewControllerDelegate {
    let loginVc = SignInViewController()
    let languageVC = TestLocaVC()

    @IBOutlet weak var collectionView: UICollectionView!
    var floaty = Floaty()
    var objects:[String:JSON]!
    var data:JSON!
    var Features:[Feature] = []
    var imageData:[AlamofireSource] = []
    @IBOutlet weak var navItem: UINavigationItem!


    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    @IBOutlet weak var cleaningView: UIView!
    @IBOutlet weak var furnitureView: UIView!
    @IBOutlet weak var poolView: UIView!
    @IBOutlet weak var elevator: UIView!
    @IBOutlet weak var wifi: UIView!
    @IBOutlet weak var balcona: UIView!
    @IBOutlet weak var Heating: UIView!
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var Images: ImageSlideshow!
    
    @IBOutlet weak var rentLBL: UILabel!
    @IBOutlet weak var initialView: UIView!
    @IBOutlet weak var TitleTextView: UILabel!
    @IBOutlet weak var priceTextView: UILabel!
    @IBOutlet weak var txt_details: UITextView!
    @IBOutlet weak var txt_details_lbl: UILabel!

    @IBOutlet weak var RentDays: UILabel!
    @IBOutlet weak var RoomTextView: UILabel!
    @IBOutlet weak var bathroomTextView: UILabel!
    @IBOutlet weak var spaceTextView: UILabel!
    @IBOutlet weak var floorTextView: UILabel!
    @IBOutlet weak var ownerTextView: UILabel!
    @IBOutlet weak var featureslblLeft: UILabel!
    @IBOutlet weak var usageTextView: UILabel!
    @IBOutlet weak var buildingAgeTextView: UILabel!
    @IBOutlet weak var FloatBtnsView: UIView!
    @IBOutlet weak var mapView: MapViewPlus!
    var realestateDetails = RealEstateDetailsObject()
    
    @IBOutlet weak var rentforlbl: UILabel!
    @IBOutlet weak var roomslbl: UILabel!
    @IBOutlet weak var bathslbl: UILabel!
    @IBOutlet weak var spacelbl: UILabel!
    @IBOutlet weak var floorslbl: UILabel!
    @IBOutlet weak var ownershiplbl: UILabel!
    @IBOutlet weak var usagelbl: UILabel!
    @IBOutlet weak var apppagelbl: UILabel!
    @IBOutlet weak var featureslbl: UILabel!
    @IBOutlet weak var heatinglbl: UILabel!
    @IBOutlet weak var balconylbl: UILabel!
    @IBOutlet weak var wifilbl: UILabel!
    @IBOutlet weak var elivatorlbl: UILabel!
    @IBOutlet weak var furnitureslbl: UILabel!
    @IBOutlet weak var poollbl: UILabel!
    @IBOutlet weak var cleanlbl: UILabel!
    @IBOutlet weak var halllbl: UILabel!
    @IBOutlet weak var funlbl: UILabel!
    @IBOutlet weak var parkinglbl: UILabel!




    

    

    
     let alamofireSource = [AlamofireSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!, AlamofireSource(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!, AlamofireSource(urlString: "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080")!]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // layoutFAB()
      //  loginVc.getDeviceLanguage()
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        setupCollectionView()
        languageVC.getCurrentSelectedLang()


         loadData()
        
        
        

        // Do any additional setup after loading the view.
        Images.slideshowInterval = 5.0
        Images.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        pageControl.pageIndicatorTintColor = UIColor.white
        Images.pageIndicator = pageControl
        
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        Images.activityIndicator = DefaultActivityIndicator()
        Images.currentPageChanged = { page in
            print("current page:", page)
        }
   
        
        
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(RSDetailsViewController.didTap))
        Images.addGestureRecognizer(recognizer)
        
        self.setText()

        
    }
    
    
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            NotificationCenter.default.addObserver(self, selector: #selector(setText), name: NSNotification.Name( LCLLanguageChangeNotification), object: nil)
            self.navigationController?.setNavigationBarHidden(true, animated: false)


            
            
        }
        
        override func viewDidAppear(_ animated: Bool) {
       
            self.navigationController?.setNavigationBarHidden(true, animated: false)

        }
    
    @objc func setText(){
       
        rentforlbl.text = "Rent for".localized();
        roomslbl.text = "Rooms".localized();
        bathslbl.text = "Bathrooms".localized();
        spacelbl.text = "Space".localized();
        floorslbl.text = "Floors".localized();
        ownershiplbl.text = "Owner".localized();
        usagelbl.text = "Usage status".localized();
        apppagelbl.text = "Building Age".localized();
        featureslblLeft.text = "Features".localized();
        txt_details_lbl.text = "Properity Details".localized();
//        heatinglbl.text = "Heating".localized();
//        balconylbl.text = "Balcony".localized();
//        wifilbl.text = "Internet".localized();
//        wifilbl.text = "Furnitures".localized();
//        wifilbl.text = "Pool".localized();
//        wifilbl.text = "Cleaning".localized();
//
//        elivatorlbl.text = "Elevator".localized();


        
        self.navItem.title = "Property details".localized();
        
        
        
    }
    
    func loadData(){
        SVProgressHUD.show()
      
            if let id = objects["id"]?.stringValue{
                
         
        let url = "https://www.wasataa.com/api/RealEstate/RealEstateDetails"
        let langstring = languageVC.lang

        
        let parameters = ["Lang":langstring!,
                          "id": id
            ] as [String : Any]
        Alamofire.request(url,method: .get,parameters: parameters)
            .responseJSON { response in
                switch response.result {
                case .success:
                    let responseResult = JSON(response.result.value!)
                     self.data = responseResult
                        self.fillData()
                   self.initialView.isHidden = true
                        SVProgressHUD.dismiss()
                        
                    
                case .failure(let error):
                    print("******** \(error.localizedDescription) *******")
                    
                }
        }
            }
            
        
    }
    
   
    @IBAction func dismiss(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
    }
    
    func fillData(){

        Features.removeAll()
        if let objc = data.dictionary{
            
            
            if let propertyType = objc["propertyType"]?.stringValue, propertyType != nil, let propertyClass = objc["propertyClass"]?.stringValue, propertyClass != nil {
                self.TitleTextView.text  = propertyType + " " + propertyClass
            }
            let priceCurrency = objc["priceType"]?.stringValue

            if let price = objc["price"]?.stringValue, price != nil{
                self.priceTextView.text  = price + " " + priceCurrency!

            }
            
            if let details = objc["notes"]?.stringValue, details != nil{
                let langstring = languageVC.lang

                if langstring == "ar" {
                    self.txt_details.textAlignment = .right

                }
                self.txt_details.text  = details

                     }
            
           
            
            let RentDays = objc["leaseTerm"]!.stringValue
            
            switch RentDays {
            case "":
                self.rentLBL.isHidden = true
                self.RentDays.isHidden = true
            case nil:
                self.rentLBL.isHidden = true
                self.RentDays.isHidden = true

                
            default:
                self.rentLBL.isHidden = false
                self.RentDays.text = RentDays
                
            }
            
            if let room = objc["room"]?.stringValue, room != nil{
                self.RoomTextView.text  = room

            }
            
            if let bathRoom = objc["bathRoom"]?.stringValue, bathRoom != nil{
                self.bathroomTextView.text  = bathRoom
                
            }
            
            if let sizeBuild = objc["sizeBuild"]?.stringValue, sizeBuild != nil{
                self.spaceTextView.text  = sizeBuild
                
            }
            
            if let spaceUnit = objc["unitArea"]?.stringValue, spaceUnit != nil{
                self.spacelbl.text  = spaceUnit
            }
            
            if let floorsNumber = objc["floorsNumber"]?.stringValue, floorsNumber != nil{
                self.floorTextView.text  = floorsNumber
                
            }
            
            if let whoOwnerAds = objc["whoOwnerAds"]?.stringValue, whoOwnerAds != nil{
                self.ownerTextView.text  = whoOwnerAds
                
            }
            
            if let usageStatus = objc["usageStatus"]?.stringValue, usageStatus != nil{
                self.usageTextView.text  = usageStatus
                
            }
            
            if let buildAge = objc["buildAge"]?.stringValue, buildAge != nil{
                self.buildingAgeTextView.text  = buildAge
                
            }
            
            if let latMap = objc["latMap"]?.doubleValue, latMap != nil, let lngMap = objc["lngMap"]?.doubleValue, lngMap != nil, let country = objc["country"]?.stringValue, country != nil, let city = objc["city"]?.stringValue, city != nil {
                
                print("latMap\(latMap)")
                print("lngMap\(lngMap)")

                
                let annotations = [
                    AnnotationPlus.init(viewModel: DefaultCalloutViewModel.init(title: country + ", " + city), coordinate: CLLocationCoordinate2DMake(latMap,lngMap))]
                
                
                mapView.delegate = self // Must conform to this to make it work.
                mapView.setup(withAnnotations: annotations)
            }
            
            if let phone = objc["phone"]?.url, phone != nil, let email = objc["email"]?.stringValue, email != nil {
                
                let phoneItem = FloatyItem()
                let emailItem = FloatyItem()
                
                phoneItem.hasShadow = true
                //phoneItem.size = 50
                phoneItem.buttonColor = #colorLiteral(red: 0.2, green: 0.3254901961, blue: 0.5176470588, alpha: 1)
                phoneItem.circleShadowColor = UIColor.black
                // item.titleShadowColor = #colorLiteral(red: 0.6196078431, green: 0.4666666667, blue: 0.2156862745, alpha: 1)
                //item.titleLabelPosition = .left
                phoneItem.icon = UIImage(named:"phone-call-2")
                //   item.title = "titlePosition right"
                //Floaty.global.rtlMode = true
                
                phoneItem.handler = { item in


                    let url: NSURL = URL(string: "TEL://\(phone)")! as NSURL

                    UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
               
                    
                }
                
                emailItem.hasShadow = true
                //emailItem.size = 50
                emailItem.buttonColor = #colorLiteral(red: 0.2, green: 0.3254901961, blue: 0.5176470588, alpha: 1)
                emailItem.circleShadowColor = UIColor.black
                emailItem.icon = UIImage(named:"envelope")
                
                emailItem.handler = { item in
                    let email = email
                    let subject = "subject"
                    let bodyText = "Please provide information that will help us to serve you better"
                    if MFMailComposeViewController.canSendMail() {
                        let mailComposerVC = MFMailComposeViewController()
                        mailComposerVC.mailComposeDelegate = self
                        mailComposerVC.setToRecipients([email])
                        mailComposerVC.setSubject(subject)
                        mailComposerVC.setMessageBody(bodyText, isHTML: true)
                        self.present(mailComposerVC, animated: true, completion: nil)
                    } else {
                        let coded = "mailto:\(email)?subject=\(subject)&body=\(bodyText)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                        if let emailURL = URL(string: coded!)
                        {
                            if UIApplication.shared.canOpenURL(emailURL)
                            {
                                UIApplication.shared.open(emailURL, options: [:], completionHandler: { (result) in
                                    if !result {
                                        // show some Toast or error alert
                                        ("Your device is not currently configured to send mail.")
                                    }
                                })
                            }
                        }
                    }
                    
                }
                
                
                floaty.hasShadow = true
                floaty.buttonColor = #colorLiteral(red: 0.6196078431, green: 0.4666666667, blue: 0.2156862745, alpha: 1)
                floaty.plusColor = UIColor.white
                
                floaty.addItem(item: phoneItem)
                floaty.addItem(item: emailItem)
                floaty.fabDelegate = self
                
                self.view.addSubview(floaty)
                
            }

            if let imageDatas = objc["mainImageURL"]?.array{
                for i in imageDatas{
                    if let obj = i.dictionary{
                        let name = "http://" + (obj["name"]?.stringValue)!
                        imageData.append(AlamofireSource(urlString: name ?? "")!)
                    }
                }
                Images.setImageInputs(imageData)
            }
            
            
            let heating:  Bool  = (objc["heating"]?.boolValue)!
            
            if heating == true{
//                Heating.isHidden = false
                self.Features.append(Feature(name: "Heating".localized(), image: UIImage(named: "air-conditioner")!))
            }else{
//                Heating.isHidden = true
            }
            
            let balcony:  Bool  = (objc["porch"]?.boolValue)!
            
            if balcony == true{
                //balcona.isHidden = false
                 self.Features.append(Feature(name: "Balcony".localized(), image: UIImage(named: "balcony")!))
            }else{
//                balcona.isHidden = true
            }
            
            let internet:  Bool  = (objc["internet"]?.boolValue)!
            
            if internet == true{
               // wifi.isHidden = false
                 self.Features.append(Feature(name: "Internet".localized(), image: UIImage(named: "wifi")!))
            }else{
               // wifi.isHidden = true
            }
            
            
            let elevatorObj:  Bool  = (objc["elevator"]?.boolValue)!
            
            if elevatorObj == true{
               // elevator.isHidden = false
                self.Features.append(Feature(name: "Elevator".localized(), image: UIImage(named: "elevator")!))
            }else{
               // elevator.isHidden = true
            }
            
            let poolObj:  Bool  = (objc["pool"]?.boolValue)!
            
            if poolObj == true{
                 self.Features.append(Feature(name: "Pool".localized(), image: UIImage(named: "pool")!))
                
            }else{
               // poolView.isHidden = true
            }
            
            let furnitureObj:  Bool  = (objc["furniture"]?.boolValue)!
            
            if furnitureObj == true{
                self.Features.append(Feature(name: "Furniture".localized(), image: UIImage(named: "sofa")!))
                
            }else{
//                furnitureView.isHidden = true
            }
            
            let cleaningObj:  Bool  = (objc["cleaning"]?.boolValue)!
            
            if cleaningObj == true{
               self.Features.append(Feature(name: "Cleaning".localized(), image: UIImage(named: "floor")!))
                
            }else{
//                cleaningView.isHidden = true
            }
            
            
            let parkingObj:  Bool  = (objc["parking"]?.boolValue)!
            
            if parkingObj == true{
                self.Features.append(Feature(name: "Parking".localized(), image: UIImage(named: "parkingg")!))
                
            }else{
               
            }
            
            let entertainmentObj:  Bool  = (objc["entertainment"]?.boolValue)!
            
            if entertainmentObj == true{
                self.Features.append(Feature(name: "Fun".localized(), image: UIImage(named: "fun")!))
                
            }else{
               
            }
            
            
            let hallObj:  Bool  = (objc["hall"]?.boolValue)!
            
            if hallObj == true{
                self.Features.append(Feature(name: "Hall".localized(), image: UIImage(named: "hall")!))
                
            }else{
                
            }
           self.collectionView.reloadData()
            
    }
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }

    
   
    
 
    
    // MARK: - Floaty Delegate Methods
    func floatyWillOpen(_ floaty: Floaty) {
        print("Floaty Will Open")
    }
    
    func floatyDidOpen(_ floaty: Floaty) {
        print("Floaty Did Open")
    }
    
    func floatyWillClose(_ floaty: Floaty) {
        print("Floaty Will Close")
    }
    
    func floatyDidClose(_ floaty: Floaty) {
        print("Floaty Did Close")
    }
    
    @objc func didTap() {
        let fullScreenController = Images.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    

    


}

extension RSDetailsViewController: MapViewPlusDelegate {
    func mapView(_ mapView: MapViewPlus, imageFor annotation: AnnotationPlus) -> UIImage {
        return #imageLiteral(resourceName: "AnnotationImage")
    }
    
    func mapView(_ mapView: MapViewPlus, calloutViewFor annotationView: AnnotationViewPlus) -> CalloutViewPlus{
        let calloutView = MapViewPlusTemplateHelper.defaultCalloutView
        
        // Below two are:
        // Required if DefaultCalloutView is being used
        // Optional if you are using your own callout view
        mapView.calloutViewCustomizerDelegate = calloutView
        mapView.anchorViewCustomizerDelegate = calloutView
        
        //Optional. Conform to this if you want button click delegate method to be called.
        calloutView.delegate = self
        
        return calloutView
    }
    
    // Optional
    func mapView(_ mapView: MapViewPlus, didAddAnnotations annotations: [AnnotationPlus]) {
        mapView.showAnnotations(annotations, animated: true)
    }
    
    // Optional. Just to show that delegate forwarding is actually working.
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print("This method is being forwarded to you by MapViewPlusDelegate")
    }
}
extension RSDetailsViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func setupCollectionView(){
        let cellTypeText = UINib(nibName: "FeatureCollectionViewCell", bundle: nil)
        collectionView.register(cellTypeText, forCellWithReuseIdentifier: "FeatureCollectionViewCell")
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Features.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureCollectionViewCell", for: indexPath) as! FeatureCollectionViewCell
        let data = Features[indexPath.row]
        cell.lbl_name.text = data.name
        cell.img_featur.image = data.image
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 50)
    }
    
    
}


extension RSDetailsViewController: DefaultCalloutViewDelegate {
    func buttonDetailTapped(with viewModel: DefaultCalloutViewModelProtocol, buttonType: DefaultCalloutViewButtonType) {
        let alert = UIAlertController(title: buttonType == .background ? "Background Tapped" : "Detail Button Tapped", message: viewModel.title + "  " + (viewModel.subtitle ?? ""), preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(confirmAction)
        self.present(alert, animated: true, completion: nil)
    }
}

struct Feature {
    var name:String!
    var image:UIImage!
    init(name:String,image:UIImage){
        self.name = name
        self.image = image
    }
}
