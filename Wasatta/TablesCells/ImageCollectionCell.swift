//
//  ImageCollectionCell.swift
//  Wasatta
//
//  Created by Ahmed Alaloul on 12/18/18.
//  Copyright © 2018 Said Abdulla. All rights reserved.
//

import UIKit
@objc protocol ImageCollectionCellDelegate {
    @objc optional func deleteTapped (_ cell:ImageCollectionCell)
}
class ImageCollectionCell: UICollectionViewCell {
    @IBOutlet weak var img_selected:UIImageView!
    var delegate : ImageCollectionCellDelegate?
    @IBAction func btn_delete(_ sender:Any){
        delegate?.deleteTapped?(self)
    }
}
