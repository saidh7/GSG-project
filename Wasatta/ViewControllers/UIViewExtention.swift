//
//  UIViewExtention.swift
//  Wasatta
//
//  Created by Said Abdulla on 11/12/19.
//  Copyright © 2019 Said Abdulla. All rights reserved.
//

import UIKit

@IBDesignable class BorderView : UIView {
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
        layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}
