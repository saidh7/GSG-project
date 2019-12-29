//
//  SearchResultsTableViewCell.swift
//  Wasatta
//
//  Created by Said Abdulla on 12/13/18.
//  Copyright © 2018 Said Abdulla. All rights reserved.
//

import UIKit
import Kingfisher


class SearchResultsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgUI: UIView!
    @IBOutlet weak var propIMG: UIImageView!
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var lblPhonee: UILabel!
    @IBOutlet weak var lblAdress: UILabel!
    @IBOutlet weak var mainv: UIView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var LBLstatus: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var lblSpaceUnit: UILabel!
    @IBOutlet weak var lblfloorTXT: UILabel!
    @IBOutlet weak var lblbathTXT: UILabel!
    @IBOutlet weak var lblroomsTXT: UILabel!

    @IBOutlet weak var lblSSpace: UILabel!
    @IBOutlet weak var lblFloor: UILabel!
    
    @IBOutlet weak var lblBath: UILabel!
    @IBOutlet weak var lblRooms: UILabel!
    var realestate = RealEstateObject()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func setText(){
        
        lblroomsTXT.text = "Room".localized();
        lblbathTXT.text = "Bathroom".localized();
        lblSSpace.text = "Space".localized();
        lblfloorTXT.text = "Floors".localized();
        
        
        
    }

}
