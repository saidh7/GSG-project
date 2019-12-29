//
//  TestViewController.swift
//  Wasatta
//
//  Created by Said Abdulla on 11/26/18.
//  Copyright © 2018 Said Abdulla. All rights reserved.
//

import UIKit
import AVKit
import DKImagePickerController


class TestViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, DKImageAssetExporterObserver {
    
    var pickerController: DKImagePickerController!
    @IBOutlet var previewView: UICollectionView?
    var exportManually = false
    var assets: [DKAsset]?

    
    deinit {
        DKImagePickerControllerResource.customLocalizationBlock = nil
        DKImagePickerControllerResource.customImageBlock = nil
        
        DKImageExtensionController.unregisterExtension(for: .camera)
        DKImageExtensionController.unregisterExtension(for: .inlineCamera)
        
        DKImageAssetExporter.sharedInstance.remove(observer: self)
    }
    
    func showImagePicker() {
        if self.exportManually {
            DKImageAssetExporter.sharedInstance.add(observer: self)
        }
        
        if let assets = self.assets {
            pickerController.select(assets: assets)
        }
        
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
    
    func updateAssets(assets: [DKAsset]) {
        print("didSelectAssets")
        
        self.assets = assets
        self.previewView?.reloadData()
        
        if pickerController.exportsWhenCompleted {
            for asset in assets {
                if let error = asset.error {
                    print("exporterDidEndExporting with error:\(error.localizedDescription)")
                } else {
                    print("exporterDidEndExporting:\(asset.localTemporaryPath!)")
                }
            }
        }
        
        if self.exportManually {
            DKImageAssetExporter.sharedInstance.exportAssetsAsynchronously(assets: assets, completion: nil)
        }
    }
    
    func playVideo(_ asset: AVAsset) {
        let avPlayerItem = AVPlayerItem(asset: asset)
        
        let avPlayer = AVPlayer(playerItem: avPlayerItem)
        let player = AVPlayerViewController()
        player.player = avPlayer
        
        avPlayer.play()
        
        self.present(player, animated: true, completion: nil)
    }
    
    // MARK: - UITableViewDataSource, UITableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = "Start"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        showImagePicker()
    }
    
    // MARK: - UICollectionViewDataSource, UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.assets?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let asset = self.assets![indexPath.row]
        var cell: UICollectionViewCell?
        var imageView: UIImageView?
        var maskView: UIView?
        
        if asset.type == .video {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellVideo", for: indexPath)
            imageView = cell?.contentView.viewWithTag(1) as? UIImageView
            maskView = cell?.contentView.viewWithTag(2)
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellImage", for: indexPath)
            imageView = cell?.contentView.viewWithTag(1) as? UIImageView
            maskView = cell?.contentView.viewWithTag(2)
        }
        
        if let cell = cell, let imageView = imageView {
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            let tag = indexPath.row + 1
            cell.tag = tag
            asset.fetchImage(with: layout.itemSize.toPixel(), completeBlock: { image, info in
                if cell.tag == tag {
                    imageView.image = image
                }
            })
        }
        
        maskView?.isHidden = !self.exportManually
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let asset = self.assets![indexPath.row]
        asset.fetchAVAsset { (avAsset, info) in
            DispatchQueue.main.async(execute: { () in
                self.playVideo(avAsset!)
            })
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
