//
//  HotelWebViewController.swift
//  Gopaddi
//
//  Created by jizan k on 19/05/23.
//

import UIKit
import WebKit
class HotelWebViewController: UIViewController, WKNavigationDelegate {


    var url = String()
    var webView = WKWebView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.showLoading()
        view.backgroundColor = .systemBackground
        webView = WKWebView(frame: view.bounds)
        webView.navigationDelegate = self
        view.addSubview(webView)
        loadUrl()
    }
    func loadUrl(){
        if let url = URL(string: self.url) {
            self.webView.load(URLRequest(url: url))
            view.stopLoading()
        }
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        webView.evaluateJavaScript("document.body.innerHTML;"){result, error in
            guard let html = result  as? String , error  == nil else {
                print("Error")
                return
            }
            guard let jsonData = html.data(using: .utf8) else {
                fatalError("Failed to convert JSON string to Data.")
            }
            
            do {
                let response = try JSONDecoder().decode(HotelBookingWeb.self, from: jsonData)
                if response.code == "200" {
                    
                    print(String(response.key ?? 0))
                    
                    let vc = HotelBookedInfoViewController()
                    vc.key = String(response.key ?? 0)
                    let nav = UINavigationController(rootViewController: vc)
                    nav.modalPresentationStyle = .fullScreen
                    self.present(nav, animated: true)
                    
                }
                else {
                    let alert = UIAlertController(title: "Sorry!", message: response.message, preferredStyle: .alert)
                    let alertOk = UIAlertAction(title: "OK", style: .cancel){_ in
                        alert.dismiss(animated: true)
                        self.dismiss(animated: true)
                    }
                    alert.addAction(alertOk)
                    self.present(alert, animated: true)
                    
                }
            } catch {
                print("Failed to parse JSON:", error)
            }
            
            print(html)
        }
    }
    
}


    
//
//            var url = String()
//            var webView = WKWebView()
//            override func viewDidLoad() {
//                super.viewDidLoad()
//                view.backgroundColor = .systemBackground
//                webView = WKWebView(frame: view.bounds)
//                webView.navigationDelegate = self
//                view.addSubview(webView)
//                loadUrl()
//
//
//            }
//            func loadUrl(){
//                if let url = URL(string: self.url) {
//                    self.webView.load(URLRequest(url: url))
//
//                }
//            }
//            func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//
//                webView.evaluateJavaScript("document.body.innerHTML;"){result, error in
//                    guard let html = result  as? String , error  == nil else {
//                        print("Error")
//                        return
//                    }
//                    guard let jsonData = html.data(using: .utf8) else {
//                        fatalError("Failed to convert JSON string to Data.")
//                    }
//
//                    do {
//                        let response = try JSONDecoder().decode(ActivityBookingOnline.self, from: jsonData)
//                        if response.code == "200" {
//                            let vc = HotelBookedInfoViewController()
//                            vc.key = response.key ?? ""
//                            let nav = UINavigationController(rootViewController: vc)
//                            self.present(nav, animated: true)
//
//                        }
//                        else {
//                            let alert = UIAlertController(title: "Sorry!", message: response.message, preferredStyle: .alert)
//                            let alertOk = UIAlertAction(title: "OK", style: .cancel){_ in
//                                alert.dismiss(animated: true)
//                                self.dismiss(animated: true)
//                            }
//                            alert.addAction(alertOk)
//                            self.present(alert, animated: true)
//
//                        }
//                    } catch {
//                        print("Failed to parse JSON:", error)
//                    }
//
//                    print(html)
//                }
//            }
//
//        }
