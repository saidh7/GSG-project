//
//  RealEstateTableViewCell.swift
//  Wasatta
//
//  Created by Said Abdulla on 10/8/18.
//  Copyright © 2018 Said Abdulla. All rights reserved.
//

import UIKit
import Kingfisher
import Localize_Swift

@objc protocol RealEstateTableViewCellDelegate {
    @objc optional func EditTapped (_ cell:RealEstateTableViewCell)
    @objc optional func deleteTapped (_ cell:RealEstateTableViewCell)
}
class RealEstateTableViewCell: UITableViewCell {
    
    var delegate : RealEstateTableViewCellDelegate?
    @IBOutlet weak var imgUI: UIView!
    @IBOutlet weak var propIMG: UIImageView!
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var lblPhonee: UILabel!
    @IBOutlet weak var lblAdress: UILabel!
    @IBOutlet weak var mainv: UIView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var LBLstatus: UILabel!
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var lblSSpace: UILabel!
    @IBOutlet weak var lblFloor: UILabel!
    @IBOutlet weak var lblSpaceUnit: UILabel!
    @IBOutlet weak var lblfloorTXT: UILabel!
    @IBOutlet weak var lblbathTXT: UILabel!
    @IBOutlet weak var lblroomsTXT: UILabel!


    @IBOutlet weak var lblBath: UILabel!
    @IBOutlet weak var lblRooms: UILabel!
    var realestate = RealEstateObject()


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
      //  propIMG.transform = CGAffineTransform(scaleX: 200,y: 150);
        
        // The subview inside the collection view cell
        mainv.layer.cornerRadius = 13
        mainv.layer.shadowColor = UIColor.gray.cgColor
        mainv.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        mainv.layer.shadowRadius = 8
        mainv.layer.borderWidth = 0.4
        mainv.layer.borderColor = UIColor.lightGray.cgColor

        mainv.layer.shadowOpacity = 0.2

        propIMG.clipsToBounds = true
        propIMG.layer.cornerRadius = 13
        propIMG.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.setText()

    }

    
    // Add an observer for LCLLanguageChangeNotification on viewWillAppear. This is posted whenever a language changes and allows the viewcontroller to make the necessary UI updated. Very useful for places in your app when a language change might happen.
    func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: NSNotification.Name( LCLLanguageChangeNotification), object: nil)
    }
    
    // Remove the LCLLanguageChangeNotification on viewWillDisappear
     func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func setText(){
        
        lblroomsTXT.text = "Room".localized();
        lblbathTXT.text = "Bathroom".localized();
        lblSSpace.text = "Space".localized();
        lblfloorTXT.text = "Floors".localized();
       
    
        
    }
    
    
    @IBAction func btn_Edit(_ sender:Any){
        delegate?.EditTapped?(self)
    }
    @IBAction func btn_Delete(_ sender:Any){
        delegate?.deleteTapped?(self)
    }
  

}
