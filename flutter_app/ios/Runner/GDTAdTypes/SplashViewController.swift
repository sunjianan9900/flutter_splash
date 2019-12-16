//
//  SplashViewController.swift
//  GDTMobSample-Swift
//
//  Created by nimomeng on 2018/8/15.
//  Copyright © 2018 Tencent. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController,GDTSplashAdDelegate {

    private var splashAd: GDTSplashAd!
    private var bottomView: UIView!
    @IBOutlet weak var placementIdTextField: UITextField!
    @IBOutlet weak var logoHeightTextField: UITextField!
    @IBOutlet weak var logoDescLabel: UILabel!
    var placeID:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        logoHeightTextField.text = String.init(format:"%.f",UIScreen.main.bounds.height * 0.25)
        logoDescLabel.text = "底部logo高度上限：\n\(UIScreen.main.bounds.height)(屏幕高度) * 25% = \(UIScreen.main.bounds.height * 0.25)"
        self.load()
    }
    
    func load(){
        placeID = placementIdTextField.text!.count > 0 ? placementIdTextField.text:placementIdTextField.placeholder
        splashAd = GDTSplashAd.init(appId: Constant.appID, placementId: placeID)
        splashAd.delegate = self
        splashAd.fetchDelay = 5
        var splashImage = UIImage.init(named: "SplashNormal")
        if Util.isIphoneX() {
            splashImage = UIImage.init(named: "SplashX")
        } else if Util.isSmallIphone() {
            splashImage = UIImage.init(named: "SplashSmall")
        }
        splashAd.backgroundImage = splashImage
        
        let logoHeight = CGFloat(Double(logoHeightTextField.text!)!)
        if (logoHeight > 0 && logoHeight <= UIScreen.main.bounds.height * 0.25) {
            bottomView = UIView.init(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: UIScreen.main.bounds.size.width, height: logoHeight)))
            bottomView.backgroundColor = .white
            let logo = UIImageView.init(image: UIImage.init(named: "SplashLogo-swift"))
            logo.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 311, height: 47))
            logo.center = bottomView.center
            bottomView.addSubview(logo)
            
            let window = UIApplication.shared.keyWindow
            splashAd.loadAndShow(in: window, withBottomView: bottomView, skip: nil)
        }

    }

//    MARK:GDTSplashAdDelegate
    func splashAdSuccessPresentScreen(_ splashAd: GDTSplashAd!) {
        print(#function)
    }
    
    func splashAdFail(toPresent splashAd: GDTSplashAd!, withError error: Error!) {
        print(#function,error)
    }
    
    func splashAdExposured(_ splashAd: GDTSplashAd!) {
        print(#function)
    }
    
    func splashAdClicked(_ splashAd: GDTSplashAd!) {
        print(#function)
    }
    
    func splashAdApplicationWillEnterBackground(_ splashAd: GDTSplashAd!) {
        print(#function)
    }
    
    func splashAdWillClosed(_ splashAd: GDTSplashAd!) {
        print(#function)
        self.splashAd = nil
    }
    
    func splashAdClosed(_ splashAd: GDTSplashAd!) {
        print(#function)
    }
    
    func splashAdDidPresentFullScreenModal(_ splashAd: GDTSplashAd!) {
        print(#function)
    }
    
    func splashAdWillDismissFullScreenModal(_ splashAd: GDTSplashAd!) {
        print(#function)
    }
    
    func splashAdDidDismissFullScreenModal(_ splashAd: GDTSplashAd!) {
        print(#function)
    }
    
    @IBAction func clickLoad(_ sender: Any) {
        self.load()
    }
    
    @IBAction func preloadContractSplashAd(_ sender: Any) {
        GDTSplashAd.preloadSplashOrder(withAppId: Constant.appID, placementId: placeID)
    }
}
