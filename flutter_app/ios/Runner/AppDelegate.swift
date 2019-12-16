import UIKit
import Flutter


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var splash: GDTSplashAd!
    var flutterViewController: FlutterViewController?


  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    GeneratedPluginRegistrant.register(with: self)

    self.flutterViewController = FlutterViewController()

    window = UIWindow.init(frame: UIScreen.main.bounds)
    let rootViewController = GDTNavigationController.init(rootViewController: self.flutterViewController!)
    rootViewController.navigationBar.isHidden = true
    rootViewController.navigationBar.isTranslucent = true

    window?.rootViewController = rootViewController
    window.makeKeyAndVisible()


    if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone {
        splash = GDTSplashAd.init(appId: Constant.appID, placementId: Constant.placementID)
        splash.delegate = self as? GDTSplashAdDelegate

        var splashImage = UIImage(named: "SplashNormal-swift")
        if Util.isIphoneX() {
            splashImage = UIImage(named: "SplashX-swift")
        } else if Util.isSmallIphone() {
            splashImage = UIImage(named: "SplashSmall-swift")
        }
        splash.backgroundImage = splashImage
        splash.fetchDelay = 3
        splash.loadAndShow(in: window)
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
