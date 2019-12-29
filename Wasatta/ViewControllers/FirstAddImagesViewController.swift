//
//  FirstAddImagesViewController.swift
//  Wasatta
//
//  Created by Said Abdulla on 11/25/18.
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




class FirstAddImagesViewController: UIViewController, FlexibleSteppedProgressBarDelegate,
DKImageAssetExporterObserver {

    @IBOutlet weak var MapperView: UIView!
    @IBOutlet weak var heatingBtn: UIButton!
    
    @IBOutlet var firstOwner: [SKRadioButton]!
    @IBOutlet var secondOwner: [SKRadioButton]!
    @IBOutlet var thirdOwner: [SKRadioButton]!
    @IBOutlet var forthOwner: [SKRadioButton]!

    
    @IBOutlet weak var spaceTextField: UITextField!
    
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var rentDurationView: UIView!
    
    @IBOutlet weak var propertySubTypeDrop: UIButton!
    @IBOutlet weak var propertyTypeDrop: UIButton!
    @IBOutlet weak var rentDurationDrop: UIButton!
    @IBOutlet weak var purchaseBtn: UIButton!
    
    @IBOutlet weak var rentBtn: UIButton!
    var pickerController: DKImagePickerController!

    var exportManually = false
    
    @IBOutlet weak var FirstView: UIView!
    @IBOutlet weak var SecondView: UIView!
    @IBOutlet var previewView: UICollectionView?
    var assets: [DKAsset]?
    
    deinit {
        DKImagePickerControllerResource.customLocalizationBlock = nil
        DKImagePickerControllerResource.customImageBlock = nil
        
        DKImageExtensionController.unregisterExtension(for: .camera)
        DKImageExtensionController.unregisterExtension(for: .inlineCamera)
        
        DKImageAssetExporter.sharedInstance.remove(observer: self)
    }
    @IBAction func firstOwnerbtnTapped(_ sender: SKRadioButton) {
        firstOwner.forEach { (button) in
            button.isSelected = false
        }
        sender.isSelected = true
    }
    
    @IBAction func secondOwnerbtnTapped(_ sender: SKRadioButton) {
        secondOwner.forEach { (button) in
            button.isSelected = false
        }
        sender.isSelected = true
    }
    @IBAction func thirdOwnerbtnTapped(_ sender: SKRadioButton) {
        thirdOwner.forEach { (button) in
            button.isSelected = false
        }
        sender.isSelected = true
    }
    
    @IBAction func forthOwnerbtnTapped(_ sender: SKRadioButton) {
        forthOwner.forEach { (button) in
            button.isSelected = false
        }
        sender.isSelected = true
    }
    @IBAction func LetsContinueBtn(_ sender: Any) {
        print("hellllllo")
        progressBarWithDifferentDimensions = FlexibleSteppedProgressBar()
        progressBarWithDifferentDimensions.completedTillIndex = 2
        progressBarWithDifferentDimensions.delegate = self
        
        
        UIView.animate(withDuration: 0.3){
            self.FirstView.isHidden = true
            self.SecondView.isHidden = false

        }
    }
    
    @IBAction func rentBtnTapped(_ sender: Any) {
    }
    @IBAction func purchaseBtnTapped(_ sender: Any) {
    }
    @IBOutlet weak var StepSubTitleLbl: UILabel!
    @IBOutlet weak var StepTitleLbl: UILabel!
    @IBOutlet weak var SteppedView: UIView!
    var progressBarWithDifferentDimensions: FlexibleSteppedProgressBar!
    
    var backgroundColor = UIColor(red: 233 / 255.0, green: 218.0 / 255.0, blue: 218.0 / 255.0, alpha: 1.0)
    var progressColor = UIColor(red: 164 / 255.0, green: 128 / 255.0, blue: 67 / 255.0, alpha: 1.0)
    var textColorHere = UIColor(red: 153.0 / 255.0, green: 153.0 / 255.0, blue: 153.0 / 255.0, alpha: 1.0)
      var StrockColor = UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    
    var maxIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        
        setupProgressBarWithDifferentDimensions()
        navigationController?.isNavigationBarHidden = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(FirstAddImagesViewController.upAllDrops(_:)))
        view.addGestureRecognizer(tapRecognizer)
        


        // Do any additional setup after loading the view.
    }
    

    
    @IBOutlet weak var ImportPhotosFrom_btn_view: UIButton!
    @IBAction func ImportPhotosFrom_btn(_ sender: Any) {
        print("ImportPhotosFrom_btn")
        
        showImagePicker()
        ImportPhotosFrom_btn_view.isHidden = true
    }
    
    func showImagePicker() {
        if self.exportManually {
            DKImageAssetExporter.sharedInstance.add(observer: self)
        }
        
        let pickerController = DKImagePickerController()
        pickerController.assetType = .allPhotos
        
        
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
    
    
    fileprivate func imageOnlyAssetFetchOptions() -> PHFetchOptions {
        let assetFetchOptions = PHFetchOptions()
        assetFetchOptions.predicate = NSPredicate(format: "mediaType == %d", PHAssetMediaType.image.rawValue)
        return assetFetchOptions
    }
    
    func updateAssets(assets: [DKAsset]) {
        print("didSelectAssets")
        
        self.assets = assets
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
    
    
    
    @IBAction func firstBackBtnTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.3){
            self.SecondView.isHidden = true
            self.FirstView.isHidden = false

        }
    }
    
    @IBAction func firstNextBtnTapped(_ sender: Any) {
    }
    // MARK: - UICollectionViewDataSource, UICollectionViewDelegate
    
    
    
    
    
    func updateDoneButtonTitle(_ doneButton: UIButton) {
        doneButton.setTitle("Done(\(self.pickerController.selectedAssets.count))", for: .normal)
    }
    
    @objc func done() {
        self.updateAssets(assets: self.pickerController.selectedAssets)
    }
    
    @objc func showAlbum() {
        let pickerController = DKImagePickerController()
        pickerController.maxSelectableCount = self.pickerController.maxSelectableCount
        pickerController.select(assets: self.pickerController.selectedAssets)
        pickerController.didSelectAssets = { [unowned self] (assets: [DKAsset]) in
            self.updateAssets(assets: assets)
            self.pickerController.setSelectedAssets(assets: assets)
        }
        
        self.present(pickerController, animated: true, completion: nil)
    }
    
    // MARK: - DKImageAssetExporterObserver
    
    func exporterWillBeginExporting(exporter: DKImageAssetExporter, asset: DKAsset) {
        if let index = self.assets?.index(of: asset) {
            if let cell = self.previewView?.cellForItem(at: IndexPath(item: index, section: 0)) {
                if let maskView = cell.contentView.viewWithTag(2) {
                    maskView.frame = CGRect(x: maskView.frame.minX,
                                            y: maskView.frame.minY,
                                            width: maskView.frame.width,
                                            height: maskView.frame.width)
                }
            }
        }
        
        print("exporterWillBeginExporting")
    }
    
    func exporterDidUpdateProgress(exporter: DKImageAssetExporter, asset: DKAsset) {
        if let index = self.assets?.index(of: asset) {
            if let cell = self.previewView?.cellForItem(at: IndexPath(item: index, section: 0)) {
                if let maskView = cell.contentView.viewWithTag(2) {
                    maskView.frame = CGRect(x: maskView.frame.minX,
                                            y: maskView.frame.minY,
                                            width: maskView.frame.width,
                                            height: maskView.frame.width * (1 - CGFloat(asset.progress)))
                }
            }
            
            print("exporterDidUpdateProgress with \(asset.progress)")
        }
    }
    
    func exporterDidEndExporting(exporter: DKImageAssetExporter, asset: DKAsset) {
        if let index = self.assets?.index(of: asset) {
            if let cell = self.previewView?.cellForItem(at: IndexPath(item: index, section: 0)) {
                if let maskView = cell.contentView.viewWithTag(2) {
                    maskView.isHidden = true
                }
            }
            
            if let error = asset.error {
                print("exporterDidEndExporting with error:\(error.localizedDescription)")
            } else {
                print("exporterDidEndExporting:\(asset.localTemporaryPath!)")
            }
        }
    }
    
   

    func showAlert(_ controller: UIAlertController, sourceView: UIView? = nil) {
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
            if let sourceView = sourceView {
                let rect = sourceView.convert(sourceView.bounds, to: view)
                controller.popoverPresentationController?.sourceView = view
                controller.popoverPresentationController?.sourceRect = rect
            }
        }

        present(controller, animated: true, completion: nil)
    }
    
    @objc func upAllDrops(_ sender: AnyObject) {
        if let hidden = navigationController?.isNavigationBarHidden {
            navigationController?.setNavigationBarHidden(!hidden, animated: true)
        }

        Drop.upAll()
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
        
        
        progressBarWithDifferentDimensions.numberOfPoints = 6
        progressBarWithDifferentDimensions.lineHeight = 8
        progressBarWithDifferentDimensions.radius = 12
        progressBarWithDifferentDimensions.progressRadius = 10
        progressBarWithDifferentDimensions.progressLineHeight = 8
        progressBarWithDifferentDimensions.delegate = self
        progressBarWithDifferentDimensions.useLastState = true
        progressBarWithDifferentDimensions.lastStateCenterColor = progressColor
        progressBarWithDifferentDimensions.selectedBackgoundColor = progressColor
        progressBarWithDifferentDimensions.selectedOuterCircleStrokeColor = StrockColor
        progressBarWithDifferentDimensions.lastStateOuterCircleStrokeColor = StrockColor
        progressBarWithDifferentDimensions.currentSelectedCenterColor = progressColor
        progressBarWithDifferentDimensions.stepTextColor = textColorHere
        progressBarWithDifferentDimensions.currentSelectedTextColor = progressColor
        progressBarWithDifferentDimensions.completedTillIndex = 0
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
                    
                case 0: return "Start"
                case 1: return "Step 1"
                case 2: return "Step 2"
                case 3: return "Step 3"
                case 4: return "Step 4"
                case 5: return "Finish"
                default: return "Date"
                    
                }
            }
        }
        return ""
    }
    

    func setupButtons(){
        //heatingBtn.alignContentVerticallyByCenter(offset: 10)
//        heatingBtn.imageView?.contentMode = .scaleAspectFill
      


        
    }

}

extension UIButton {
    // MARK: - UIButton+Aligment
    func leftImage(image: UIImage, renderMode: UIImage.RenderingMode) {
        self.setImage(image.withRenderingMode(renderMode), for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: image.size.width / 2)
        self.contentHorizontalAlignment = .left
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    
    func alignContentVerticallyByCenter(offset:CGFloat = 10) {
        let buttonSize = frame.size
        
        if let titleLabel = titleLabel,
            let imageView = imageView {
            
            if let buttonTitle = titleLabel.text,
                let image = imageView.image {
                let titleString:NSString = NSString(string: buttonTitle)
                let titleSize = titleString.size(withAttributes: [
                    NSAttributedStringKey.font : titleLabel.font
                    ])
                let buttonImageSize = image.size
                
                let topImageOffset = (buttonSize.height - (titleSize.height + buttonImageSize.height + offset)) / 2
                let leftImageOffset = (buttonSize.width - buttonImageSize.width) / 2
                imageEdgeInsets = UIEdgeInsetsMake(topImageOffset,
                                                   leftImageOffset,
                                                   0,0)
                
                let titleTopOffset = topImageOffset + offset + buttonImageSize.height
                let leftTitleOffset = (buttonSize.width - titleSize.width) / 2 - image.size.width
                
                titleEdgeInsets = UIEdgeInsetsMake(titleTopOffset,
                                                   leftTitleOffset,
                                                   0,0)
            }
        }
    }
}
