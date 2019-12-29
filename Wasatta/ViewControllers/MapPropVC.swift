//
//  MapPropVC.swift
//  Wasatta
//
//  Created by Said Abdulla on 11/1/19.
//  Copyright © 2019 Said Abdulla. All rights reserved.
//

import UIKit
import MapViewPlus
import CoreLocation
import MapKit
import SVProgressHUD
import SwiftyJSON
import Alamofire
import Localize_Swift

class MapPropVC: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let locationManager = CLLocationManager()

    
    @IBOutlet weak var mapView: MapViewPlus!
    @IBOutlet weak var navItem: UINavigationItem!

    let languageVC = TestLocaVC()
    let loginVc = SignInViewController()
    
    
    var objects:[[String:JSON]] = []
    var data:JSON!
    var realestateDetails = RealEstateDetailsObject()
    






    override func viewDidLoad() {
        super.viewDidLoad()
        languageVC.getCurrentSelectedLang()
        self.navigationController?.setNavigationBarHidden(true, animated: false)


        self.loadData()
//        let initialLocation = CLLocation(latitude: 28.5761897, longitude: 77.172080)
//        self.centerMapOnLocation(location: initialLocation)
//        zoomMapaFitAnnotations()
//        mapView.showAnnotations(mapView.annotations, animated: true)

//
//        mapView.setVisibleMapRect(
//            mapView.annotations.reduce(MKMapRectNull) { result, next in
//                let point = MKMapPointForCoordinate(next.coordinate)
//                let rect = MKMapRectMake(point.x, point.y, 0, 0)
//                guard !MKMapRectIsNull(result) else { return rect }
//                return MKMapRectUnion(result, rect)
//            },
//            edgePadding: UIEdgeInsetsMake(20, 20, 40, 20),
//            animated: true
//        )
        


        
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
           
           navItem.title = "Map properties".localized();
        
    }
    
      @IBAction func dismissb(_ sender: Any) {
            navigationController?.popViewController(animated: true)
    //
    //        dismiss(animated: true, completion: nil)
            
          
    
        }
    
 
    
    
    func zoomMapaFitAnnotations() {

        var zoomRect = MKMapRectNull
        for annotation in mapView.annotations {

            let annotationPoint = MKMapPointForCoordinate(annotation.coordinate)

            let pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0)

            if (MKMapRectIsNull(zoomRect)) {
                zoomRect = pointRect
            } else {
                zoomRect = MKMapRectUnion(zoomRect, pointRect)
            }
        }
        self.mapView.setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsetsMake(50, 50, 50, 50), animated: true)

    }
    
    
    

       func loadData(){
        SVProgressHUD.show()
                      
         
        let url = "http://wasataa.com/api/RealEstate/RealEstateMap"
        let langstring = languageVC.lang

        
        let parameters = ["Lang":langstring!] as [String : Any]
        Alamofire.request(url,method: .get,parameters: parameters)
            .responseJSON { response in
                switch response.result {
                case .success:
                    let responseResult = JSON(response.result.value!)
                    if let data = responseResult.array {
                            for i in data{
                              self.objects.append(i.dictionary!)

                                              
                                }
                                 self.data = responseResult
                                                     
                                  self.fillData()
                                 SVProgressHUD.dismiss()

                                      }
               
                        
                    
                case .failure(let error):
                    print("******** \(error.localizedDescription) *******")
                    
                }
        }
            
        
    }
    
    
    
    
        func fillData(){

            if let objc = data.array{
                
                for i in objc{
                    
                    let id = i["id"].stringValue
                    let latMap = i["lat"].doubleValue
                    let lngMap = i["lng"].doubleValue
                    let propertyClass = i["propertyClass"].stringValue
                    let propertyType = i["propertyType"].stringValue
                    let price = i["price"].stringValue
                    let priceType = i["priceType"].stringValue
                    let image = "http://" + (i["image"].stringValue)

                    
                  mapView.delegate = self

                      let annotation = AnnotationPlus(viewModel: DefaultCalloutViewModel.init(title: propertyType + " " + propertyClass , subtitle: price + " " + priceType , imageType: .downloadable(imageURL: URL.init(string: image)!, placeholder: #imageLiteral(resourceName: "PlaceholderLight")), theme: .light, detailButtonType: .info), coordinate: CLLocationCoordinate2DMake(latMap, lngMap))
                   

                      var annotations: [AnnotationPlus] = []
                      annotations.append(annotation)

                      mapView.setup(withAnnotations: annotations)
                    
                    
  
            }
                    
                
            
                
         
         
   
        }
            
        }



}



extension MapPropVC: MapViewPlusDelegate {
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

extension MapPropVC: DefaultCalloutViewDelegate {
    func buttonDetailTapped(with viewModel: DefaultCalloutViewModelProtocol, buttonType: DefaultCalloutViewButtonType) {
        let data = objects[0]
              let vc = storyboard?.instantiateViewController(withIdentifier: "RSDetailsViewController") as? RSDetailsViewController
        vc?.objects = data
              self.present(vc!, animated: true, completion: nil)
        

    }
}





extension MKMapView {
    func fitAllAnnotations() {
        var zoomRect = MKMapRectNull;
        for annotation in annotations {
            let annotationPoint = MKMapPointForCoordinate(annotation.coordinate)
            let pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
            zoomRect = MKMapRectUnion(zoomRect, pointRect);
        }
        setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50), animated: true)
    }
}



