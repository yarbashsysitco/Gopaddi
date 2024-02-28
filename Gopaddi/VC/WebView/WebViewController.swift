//
//  WebViewController.swift
//  Gopaddi
//
//  Created by jizan k on 16/12/22.
//

import UIKit
import WebKit
import SwiftSoup

class WebViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var webView: WKWebView!
  
    var redirect = String()
    var url : String?
    let reachability = try! Reachability()
    var netStatus = true
    let popup = NetworkErrorViewController()
    override func viewDidLoad() {
        let prefs = WKPreferences()
        let config = WKWebViewConfiguration()
        config.preferences = prefs
        super.viewDidLoad()
        webView.navigationDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.reachability.whenReachable = { reachability in
                if reachability.connection == .wifi {
                    
                    if !self.netStatus{
                        self.dismiss()
                    }
                    self.showWeb()
                    print("Reachable via WiFi")
                } else {
                    if !self.netStatus{
                        self.dismiss()
                    }
                    self.showWeb()
                
                    print("Reachable via Cellular")
                }
            }
            self.reachability.whenUnreachable = { _ in
                print("Not reachable")
                self.netStatus = false
                if let networkVC = self.storyboard?.instantiateViewController(withIdentifier: "NetworkErrorViewController") as? NetworkErrorViewController{
                    self.present(networkVC, animated: true)
                    self.popup.appear(sender: self)
                }
            }
            do {
                try self.reachability.startNotifier()
            } catch {
                print("Unable to start not")
            }
        }
    }
    deinit{
        reachability.stopNotifier()
    }
    func dismiss(){
        self.dismiss(animated: true)
    }
    func showWeb(){
//        Webview.isLogin = true
      defaultSet()
       let url = redirect 
        self.webView.load(URLRequest(url: URL(string: url)!))
    }
    func defaultSet(){
//        let udSet = UserDefaults.standard
//        udSet.set(true
//                  , forKey: "isLogin")
        let userDefults = UserDefaults.standard

        userDefults.set(true, forKey: "login_status")

        
    }
    @IBAction func backButton(_ sender: Any) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
}
extension WebViewController : UIWebViewDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        webView.evaluateJavaScript("document.body.getElementsByTagName('code')") { innerHTML, error in
//                print(innerHTML!)
//            }
        webView.evaluateJavaScript("document.body.innerHTML;"){result, error in
                guard let html = result  as? String , error  == nil else {
                print("Error")
                return
            }
            
            print(html)
//            do {
//                let document : Document = try SwiftSoup.parse(html)
//                let link: Element = try document.select("a").first()??! Element
//                guard let body = document.body() else {
//                    return
//                }
//                let linkHref: String = try link.attr("href")
////                let element : String   = try document.getElementsByAttribute("code")
//                print(String(describing: linkHref))
//            }
//            catch{
//                print("Error" + String(describing: error))
//            }
        }
       


            
    }
}
