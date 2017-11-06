//
//  BaseViewController.swift
//  Zup
//
//  Created by Victor de Paula on 02/11/17.
//  Copyright © 2017 Victor de Paula. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

class BaseViewController : UIViewController, NVActivityIndicatorViewable {
    
    var statusBarFade: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkConection()
        self.configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.configureNavigationBar()
    }
    
    func showLoading() {
      
        statusBarFade.frame = UIApplication.shared.statusBarView?.bounds ?? CGRect(x: 0, y: 0, width: 0, height: 0)
        statusBarFade.backgroundColor = .black
        statusBarFade.alpha = 0.5
        if UIApplication.shared.statusBarView?.backgroundColor != nil {
            UIApplication.shared.statusBarView?.addSubview(statusBarFade)
        }
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    func dismissLoading() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        self.statusBarFade.removeFromSuperview()
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    // local loading not full screen
    // pass the frame with screen relative position
    // after just use activityIndicator.startAnimating() or activityIndicator.stopAnimating()
    func setupLocalLoading(_ activityIndicator: inout NVActivityIndicatorView, frame: CGRect, view: UIView) {
        activityIndicator = NVActivityIndicatorView(frame: frame,
                                                    type: .ballSpinFadeLoader)
        view.addSubview(activityIndicator)
    }
    
    func checkConection(){
        if Reachability.isConnectedToNetwork() != true
        {
            let alert = UIAlertController(title: "Erro", message: "É necessário conexão com a internet para consultar novos filmes.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func checkConnectionBeforeSearch() -> Bool {
        return Reachability.isConnectedToNetwork()
    }
    

    
    func configureNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -4, right: 0)
        
        let alignedImage: UIImage = UIImage(named: "icon-back-default")?.withAlignmentRectInsets(insets) ?? UIImage()
        
        self.navigationController?.navigationBar.backIndicatorImage = alignedImage
        
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = alignedImage
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        self.navigationController?.navigationBar.tintColor = UIColor().getColorIconWhiteDefault()
        
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15),
                                                            NSForegroundColorAttributeName: UIColor().getColorIconWhiteDefault()]
        
        UINavigationBar.appearance().backgroundColor = UIColor(hexString: "424242")
    }
}

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}

