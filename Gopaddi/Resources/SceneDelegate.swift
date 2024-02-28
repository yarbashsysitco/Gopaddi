import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var userSubscription: UserSubscription?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window

        // Check UserDefaults values
        let finished = UserDefaults.standard.string(forKey: "finished")
        let logKey = UserDefaults.standard.string(forKey: "logkey")
        let isInterest = UserDefaults.standard.string(forKey: "isInterest")
        let personal = UserDefaults.standard.string(forKey: "personal")
        let mainTabBarController = UserDefaults.standard.string(forKey: "MainTabBarController")
        let loginTrue = UserDefaults.standard.string(forKey: "LoginTrue")

//      let vc = HotelBookedInfoViewController()
//      let nav = UINavigationController(rootViewController: vc)
//      nav.modalPresentationStyle = .fullScreen
//      window.rootViewController = vc

        if ((logKey?.isEmpty) ?? true ){
            if loginTrue == "true" {
                navigateToSignInVC()
            }else{
                if finished == "true" {
                    navigateToSignInVC()
                } else {
                    displayOnboardingVC()
                }
            }
        } else {
            if loginTrue == "true" {
                if personal == "true" {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        if let vc = storyboard.instantiateViewController(withIdentifier: "PersonalDetailsViewController") as? PersonalDetailsViewController {
                            vc.user = logKey!
                            window.rootViewController = vc
                    }
                } else if isInterest == "true" {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let vc = storyboard.instantiateViewController(withIdentifier: "InterestsViewController") as? InterestsViewController {
                        window.rootViewController = vc
                    }
                } else {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let vc = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController {
                        vc.modalPresentationStyle = .fullScreen
                        window.rootViewController = vc
                    }
                }
            }else{
                if finished == "true" {
                    navigateToSignInVC()
                } else {
                    displayOnboardingVC()
                }
        }
        }







        if loginTrue == "true" {
            if isInterest == "true" {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let vc = storyboard.instantiateViewController(withIdentifier: "InterestsViewController") as? InterestsViewController {
                    window.rootViewController = vc
                }
            } else if personal == "true" {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let vc = storyboard.instantiateViewController(withIdentifier: "PersonalDetailsViewController") as? PersonalDetailsViewController {
                    vc.user = logKey!
                    window.rootViewController = vc
                }
            } else if mainTabBarController == "true" {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let vc = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController {
                    vc.modalPresentationStyle = .fullScreen
                    window.rootViewController = vc
                }
            }
        } else {
            if finished == "true" {
                navigateToSignInVC()
            } else {
                displayOnboardingVC()
            }
        }

        window.makeKeyAndVisible()
    }
    
    func navigateToSignInVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "SignInVC") as? SignInVC {
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
        }
    }
    
    func displayOnboardingVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController") as? OnboardingViewController {
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
        }
    }
}
