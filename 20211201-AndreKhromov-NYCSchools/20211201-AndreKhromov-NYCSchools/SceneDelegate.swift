import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var schoolStoreVM: SchoolStoreVM!


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        // inject the school view model into the ListViewController
        let listViewController = (window?.rootViewController as! UINavigationController).topViewController as! ListViewController
        listViewController.schoolStoreVM = SchoolStoreVM(webService: WebService())
    }
}

