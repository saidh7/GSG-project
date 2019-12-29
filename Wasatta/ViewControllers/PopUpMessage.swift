//
//  PopUpMessage.swift
//  myOffer
//
//  Created by Momen A. Shaheen on 4/15/18.
//  Copyright © 2018 NewLine. All rights reserved.
//

import UIKit

class PopUpMessage: UIViewController {
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblMeesage: UILabel!
    
    
    @IBOutlet weak var btnOk: UIButton!
    
    @IBOutlet weak var btnClose: UIButton!
    
    @IBOutlet weak var btnCloseTheme: UIButton!
    
   
    
    
//    init(title : String? = "", Message : String?="", okComplition : ((()->())?)) {
//        super.init(nibName: nil, bundle: nil)
//
//        self.lblTitle.text = title
//        self.lblMeesage.text = Message
//        self.btnOk.addTargetClosure { (button) in
//
//
//            if okComplition != nil {
//
//        okComplition?()
//
//            }
//            else{
//
//                self.dismiss(animated: true, completion: nil)
//            }
//
//
//        }
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func initMessage(title : String? = "", Message : String?="", okComplition : ((()->())?), onDissmissComplition : ((()->())?)) {
   // super.init(nibName: nil, bundle: nil)
    
    self.lblTitle.text = title
    self.lblMeesage.text = Message
    self.btnOk.addTargetClosure { (button) in
   
    
    if okComplition != nil {
    
    okComplition?()
    self.dismiss(animated: true, completion: nil)
    }
    else{
    onDissmissComplition?()
    self.dismiss(animated: true, completion: nil)
    }
    }
        
        self.btnClose.addTargetClosure { (button) in
            
            onDissmissComplition?()
            self.dismiss(animated: true, completion: nil)
        }
        self.btnCloseTheme.addTargetClosure { (button) in
            
            onDissmissComplition?()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        btnOk.setTitle("Popup_Ok".localize, for: UIControlState.normal)
//        btnClose.setTitle("Popup_Cancel".localize, for: UIControlState.normal)
        
        btnOk.setTitle("Ok".localized(), for: UIControl.State.normal)
        btnClose.setTitle("Cancle".localized(), for: UIControl.State.normal)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



import UIKit

typealias UIButtonTargetClosure = (UIButton) -> ()

class ClosureWrapper: NSObject {
    let closure: UIButtonTargetClosure
    init(_ closure: @escaping UIButtonTargetClosure) {
        self.closure = closure
    }
}

extension UIButton {
    
    private struct AssociatedKeys {
        static var targetClosure = "targetClosure"
    }
    
    private var targetClosure: UIButtonTargetClosure? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? ClosureWrapper else { return nil }
            return closureWrapper.closure
        }
        set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, ClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func addTargetClosure(closure: @escaping UIButtonTargetClosure) {
        targetClosure = closure
        addTarget(self, action: #selector(UIButton.closureAction), for: .touchUpInside)
    }
    
    @objc func closureAction() {
        guard let targetClosure = targetClosure else { return }
        targetClosure(self)
    }
}


extension UIViewController {
    
    func  showMessage(title : String? = "", Message : String?="", okComplition : (()->())?, onDissmissComplition: (()->())?){
       
        if let vc = Bundle.main.loadNibNamed("PopUpMessage", owner: nil, options: nil)?.first as? PopUpMessage {
            vc.initMessage(title: title, Message: Message, okComplition: okComplition, onDissmissComplition: onDissmissComplition)
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window!.rootViewController?.present(vc, animated: true, completion: nil)
           // self.present(vc, animated: true, completion: nil)
        }
       
//        let vc = PopUpMessage(nibName: "PopUpMessage", bundle: nil) as! PopUpMessage
//
//
//           vc.initMessage(title: title, Message: Message, okComplition: okComplition)
//
//        self.present(vc, animated: true, completion: nil)
        
        
    }
    func  showMessageOnSelf(title : String? = "", Message : String?="", okComplition : (()->())?, onDissmissComplition: (()->())?){
        
        if let vc = Bundle.main.loadNibNamed("PopUpMessage", owner: nil, options: nil)?.first as? PopUpMessage {
            vc.initMessage(title: title, Message: Message, okComplition: okComplition, onDissmissComplition: onDissmissComplition)
            
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.window!.rootViewController?.present(vc, animated: true, completion: nil)
             self.present(vc, animated: true, completion: nil)
        }
    
    
    
}
}
