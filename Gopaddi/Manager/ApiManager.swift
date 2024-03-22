//
//  ApiManager.swift
//  Gopaddi
//
//  Created by jizan k on 04/01/23.
//

import Foundation
import UIKit
import Alamofire
enum NetworkingError: String, Error {
    case badURL
    case badResponse
    case badNetwork = "You will not be able to login because your OTP verification is still pending"
}
class ApiManager{
    static let shared = ApiManager()
    //callRegister
    func usRegistration(fname: String,lname: String ,email: String ,phone: String ,password: String , passconf: String,referral: String , completion: @escaping(Swift.Result<Register, Error>)-> ()) {
            guard let url =  URL(string: register_url)
            else {
                return     }
            let body: [String: Any] =
            [
                "fname" : fname,
                "lname": lname,
                "email": email,
                "phone" : phone,
                "password" : password,
                "passconf"  : passconf,
                "referral"  : referral
            ]
            let finalBody = try? JSONSerialization.data(withJSONObject: body)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = finalBody
            request.allHTTPHeaderFields = ["Token":"gopaddi@v1"]
            URLSession.shared.dataTask(with: request){
                (data , response, error)  in            guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    completion(.failure(error?.localizedDescription as! Error))
                    return
                }
                guard let response = response else {
                    return
                }
                print(response)
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    do {
                        let postBody = try JSONDecoder().decode(Register.self, from: data)
                        completion(.success(postBody))
                    }catch let error{
                        print(error.localizedDescription)
                    }
                    print(responseJSON)
                }
            }.resume()
        }
    
    func fetchCountryData(completion: @escaping (Result<[CountryResult], Error>) -> Void) {
        guard let url = URL(string: country_url) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = ["Token": headerSecond]
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                print(response.statusCode)
            }
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
                return
            }
            guard let data = data else {
                let error = NSError(domain: "YourDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }
            do {
                let result = try JSONDecoder().decode(Countries.self, from: data)
                completion(.success(result.result))
                print(result)
            } catch {
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
        task.resume()
    }

    func callOtpTest(otp: String,email: String,membership: String, completion: @escaping (Result<OtpModel, Error>) -> Void) {
        let param = [
            "otp": otp,
            "email": email,
            "membership": membership
        ]
        
        AF.request(verifyOtp_url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [header: headerSecond]).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let postBody = try JSONDecoder().decode(OtpModel.self, from: data)
                    completion(.success(postBody))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    func resendOTP(email: String, completion: @escaping (Result<OtpModel, Error>) -> Void) {
        let param = [ "email": email]
        AF.request(resendOtp_url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [header:headerSecond]).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(OtpModel.self, from: data)
                    completion(.success(response))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }

    func forgotPassword(email: String, completion: @escaping (Result<ForgotPassword, Error>) -> Void) {
        let param = [ "email": email]
        AF.request(forgotPassword_url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [header:headerSecond]).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(ForgotPassword.self, from: data)
                    completion(.success(response))
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    
    func signIn(useremail: String, password: String, token: String, completion: @escaping (Result<SignInModel, Error>) -> Void) {
        let parameters: [String: Any] = [
            "email": useremail,
            "password": password,
            "token": token
        ]
        
        AF.request(signIn_url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: [header: headerSecond]).response { response in
            switch response.result {
            case .success(let data):
                if let data = data {
                    do {
                        let signInModel = try JSONDecoder().decode(SignInModel.self, from: data)
                        print(signInModel.data)
                        completion(.success(signInModel))
                    } catch {
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Ok", style: .cancel)
                    alert.addAction(alertAction)
                    if let viewController = UIApplication.shared.keyWindow?.rootViewController {
                        viewController.present(alert, animated: true)
                    }
                }
            }
        }
    }

    
//    
//    func signIn(useremail: String, password: String, token: String,completion: @escaping(Result<SignInModel, Error>) -> Void){
//        guard let url =  URL(string: signIn_url)
//        else {
//            return     }
//        let body: [String: Any] =
//        [
//            "email": useremail,
//            "password": password,
//            "token": token
//            
//        ]
//        let finalBody = try? JSONSerialization.data(withJSONObject: body)
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.httpBody = finalBody
//        request.allHTTPHeaderFields = [header:headerSecond]
//        URLSession.shared.dataTask(with: request){
//            (data , response, error)  in
//            guard let data = data, error == nil else {
//                completion(.failure(error?.localizedDescription as! Error))
//                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
//                let alertAction = UIAlertAction(title: "Ok", style: .cancel)
//                alert.addAction(alertAction)
//                let navVC = UINavigationController()
//                navVC.present(alert, animated: true)
//                return
//            }
//            guard let response = response else {
//                return
//            }
//            print(response)
//            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//            if let responseJSON = responseJSON as? [String: Any] {
//                do {
//                    let response = try JSONDecoder().decode(SignInModel.self, from: data)
//                    print(response.user)
//                    completion(.success(response))
//                    
//                }catch {
//                    completion(.failure(error))
//                }
//                print(responseJSON)
//            }
//        }.resume()
//    }
    
    
    
    
    func memebership(completion : @escaping(Result<[ResultData], Error>) -> Void){
        guard let url = URL(string: membership_url) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = [header:headerSecond]
        let task = URLSession.shared.dataTask(with: urlRequest){ data, response, error in
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode){
                print(response.statusCode)
            }
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
            }
            guard let data = data else {
                return
            }
            do {
                let result =   try JSONDecoder().decode(Membership.self, from: data)
                completion(.success(result.result))
                print(result)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    func personalDetails(userKey: String, userName: String, dob: String, gender: String, profilePic : String, completion: @escaping(Result<PersonalDetModel, Error>) -> Void){
        guard let url =  URL(string: personalDet_url)
        else {
            return     }
        let body: [String: Any] =
        [
            "user" : userKey,
            "uname" : userName,
            "dob" : dob,
            "gender" : gender ,
            "picture" : profilePic
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = ["Token":headerSecond]
        URLSession.shared.dataTask(with: request){
            (data , response, error)  in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error?.localizedDescription as! Error))
                return
            }
            guard let response = response else {
                return
            }
            print(response)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(PersonalDetModel.self, from: data)
                    completion(.success(postBody))
                }catch let error{
                    print(error.localizedDescription)
                }
                print(responseJSON)
            }
        }.resume()
    }
    func deleteAccount(user: String, completion: @escaping (Result<DeleteModel, Error>) -> Void) {
        let param = [
            "user" : user]
        AF.request(deleteAccount_url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [header:headerSecond]).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let postBody = try JSONDecoder().decode(DeleteModel.self, from: data)
                    completion(.success(postBody))
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    func intersetDetails(userKey: String, interests: [String], completion: @escaping(Result<InterestModel, Error>) -> Void){
        guard let url =  URL(string: interest_url)
        else {
            return     }
        let body: [String: Any] =
        [
            "user" : userKey,
            "interests" : interests
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = ["Token":headerSecond]
        URLSession.shared.dataTask(with: request){
            (data , response, error)  in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error?.localizedDescription as! Error))
                return
            }
            guard let response = response else {
                return
            }
            print(response)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(InterestModel.self, from: data)
                    completion(.success(postBody))
                }catch let error{
                    print(error.localizedDescription)
                }
                print(responseJSON)
            }
        }.resume()
    }
    func paymentDetails(userKey: String, plan: String, completion: @escaping(Result<PaymentModel, Error>) -> Void) {
        guard let url =  URL(string: payment_url)
        else {
            return     }
        let body: [String: Any] =
        [
            "user" : userKey,
            "plan" : "gold"
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = ["Token":headerSecond]
        URLSession.shared.dataTask(with: request){
            (data , response, error)  in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error?.localizedDescription as! Error))
                return
            }
            guard let response = response else {
                return
            }
            print(response)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(PaymentModel.self, from: data)
                    completion(.success(postBody))
                }catch let error{
                    print(error.localizedDescription)
                }
                print(responseJSON)
            }
        }.resume()
    }
    func feedsDetails(userKey: String, completion: @escaping (Result<[FeedResult], Error>) -> Void){
        guard let url = URL(string: feeds_url) else {
            // Handle the URL error here (e.g., by calling completion with a failure result)
            return
        }
        
        let body: [String: Any] = ["user": userKey]
        
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = ["Token": headerSecond]
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error)) // Pass the error object to the completion
                return
            }
            
            guard let data = data else {
                print("No data")
                // Handle the lack of data error here (e.g., by calling completion with a failure result)
                return
            }
            
            print(response)
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(FeedsModel.self, from: data)
                    completion(.success(postBody.result))
                } catch let error {
                    print(error.localizedDescription)
                    // Handle the JSON decoding error here (e.g., by calling completion with a failure result)
                }
                print(responseJSON)
            }
        }.resume()
    }

    
    func feedsPosts(userKey : String , caption : String , file : String ,completion: @escaping(Result<FeedsCreateModel, Error>) -> Void){
        guard let url =  URL(string: feedsCreate_url)
        else {
            return     }
        let body: [String: Any] =
        [
            "user" : userKey,
            "caption" : caption,
            "file" : file
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = ["Token":headerSecond]
        URLSession.shared.dataTask(with: request){
            (data , response, error)  in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error?.localizedDescription as! Error))
                return
            }
            guard let response = response else {
                return
            }
            print(response)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(FeedsCreateModel.self, from: data)
                    completion(.success(postBody))
                }catch let error{
                    print(error.localizedDescription)
                }
                print(responseJSON)
            }
        }.resume()
    }
    func feedsLikeSave(userKey : String , key : String , promotion : String, action : String ,completion: @escaping(Result<FeedLSModel, Error>) -> Void) {
        guard let url =  URL(string: feedShareLike_url)
        else {
            return     }
        let body: [String: Any] =
        [
            "user" : userKey,
            "key" : key,
            "promotion" : promotion,
            "action" : action
            
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = ["Token":headerSecond]
        URLSession.shared.dataTask(with: request){
            (data , response, error)  in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error?.localizedDescription as! Error))
                return
            }
            guard let response = response else {
                return
            }
            print(response)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(FeedLSModel.self, from: data)
                    completion(.success(postBody))
                }catch let error{
                    print(error.localizedDescription)
                }
                print(responseJSON)
            }
        }.resume()
    }
    
    func feedsCommentLike(userKey : String , key : String , emoji : String, action : String ,completion: @escaping(Result<FeedCommentLike, Error>) -> Void) {
        guard let url =  URL(string: feedCommentLike_url)
        else {
            return     }
        let body: [String: Any] =
        [
            "user" : userKey,
            "key" : key,  // feeds comments lists response fc_id value
            "action" : action,  // like or react
            "emoji" : emoji
            
            
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = ["Token":headerSecond]
        URLSession.shared.dataTask(with: request){
            (data , response, error)  in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error?.localizedDescription as! Error))
                return
            }
            guard let response = response else {
                return
            }
            print(response)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(FeedCommentLike.self, from: data)
                    completion(.success(postBody))
                }catch let error{
                    print(error.localizedDescription)
                }
                print(responseJSON)
            }
        }.resume()
    }
    func feedsEdit(userKey : String , key : String , caption : String, file : String ,completion: @escaping(Result<feedEditModel, Error>) -> Void){
        guard let url =  URL(string: feedEdit_url)
        else {
            return     }
        let body: [String: Any] =
        [
            "user" : userKey    ,
            "key" : key,
            "caption" : caption,
            "file" : file
            
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = ["Token":headerSecond]
        URLSession.shared.dataTask(with: request){
            (data , response, error)  in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error?.localizedDescription as! Error))
                return
            }
            guard let response = response else {
                return
            }
            print(response)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(feedEditModel.self, from: data)
                    completion(.success(postBody))
                }catch let error{
                    print(error.localizedDescription)
                }
                print(responseJSON)
            }
        }.resume()
    }
    func feedsDelete(userKey : String , key : String ,completion: @escaping(Result<feedDeleteModel, Error>) -> Void) {
        guard let url =  URL(string: feedDelete_url)
        else {
            return     }
        let body: [String: Any] =
        [
            "user" : userKey,
            "key" : key
            
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = ["Token":headerSecond]
        URLSession.shared.dataTask(with: request){
            (data , response, error)  in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error?.localizedDescription as! Error))
                return
            }
            guard let response = response else {
                return
            }
            print(response)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(feedDeleteModel.self, from: data)
                    completion(.success(postBody))
                }catch let error{
                    print(error.localizedDescription)
                }
                print(responseJSON)
            }
        }.resume()
    }
    func feedsComment(userKey : String , key : String , parent : String, promotion : String ,msg : String ,completion: @escaping(Result<CommonResponse, Error>) -> Void){
        guard let url =  URL(string: feedComment_url)
        else {
            return     }
        let body: [String: Any] =
        [
            "user" : userKey,
            "key" : key,  // feeds lists response fe_id value
            "parent" : parent,  // feeds comments lists response fc_id value (to reply)
            "promotion" : promotion,   // feeds lists response fe_promotion value
            "comment" : msg
            
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = ["Token":headerSecond]
        URLSession.shared.dataTask(with: request){
            (data , response, error)  in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error?.localizedDescription as! Error))
                return
            }
            guard let response = response else {
                return
            }
            print(response)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(CommonResponse.self, from: data)
                    completion(.success(postBody))
                }catch let error{
                    print(error.localizedDescription)
                }
                print(responseJSON)
            }
        }.resume()
    }
    func feedPostedComment(userKey : String , key : String , promotion : String ,completion: @escaping(Result<CommentReplyModel, Error>) -> Void){
        guard let url =  URL(string: feedCommentsGet_url)
        else {
            return     }
        let body: [String: Any] =
        [
            "user" : userKey,
            "key" : key,  // feeds lists response fe_id value
            "promotion" : promotion,   // feeds lists response fe_promotion value
            
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = ["Token":headerSecond]
        URLSession.shared.dataTask(with: request){
            (data , response, error)  in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error?.localizedDescription as! Error))
                return
            }
            guard let response = response else {
                return
            }
            print(response)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(CommentReplyModel.self, from: data)
                    completion(.success(postBody))
                }catch let error{
                    print(error.localizedDescription)
                }
                print(responseJSON)
            }
        }.resume()
    }
    func feedCommentReply(userKey : String , key : String ,completion: @escaping(Result<FcRepliesDatum, Error>) -> Void) {
        guard let url =  URL(string: feedCommentsReply_url)
        else {
            return     }
        let body: [String: Any] =
        [
            "user" : userKey,
            "key" : key,  // feeds comments response fc_id value
            
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = ["Token":headerSecond]
        URLSession.shared.dataTask(with: request){
            (data , response, error)  in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error?.localizedDescription as! Error))
                return
            }
            guard let response = response else {
                return
            }
            print(response)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(FcRepliesDatum.self, from: data)
                    completion(.success(postBody))
                }catch let error{
                    print(error.localizedDescription)
                }
                print(responseJSON)
            }
        }.resume()
    }
    func profieImageChange(userKey : String , imageUrl : String ,completion: @escaping(Result<profileImgChange, Error>) -> Void) {
        guard let url =  URL(string: profileImageChange_url)
        else {
            return     }
        let body: [String: Any] =
        [
            "user" : userKey,
            "picture" : imageUrl
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = ["Token":headerSecond]
        URLSession.shared.dataTask(with: request){
            (data , response, error)  in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error?.localizedDescription as! Error))
                return
            }
            guard let response = response else {
                return
            }
            print(response)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(profileImgChange.self, from: data)
                    completion(.success(postBody))
                }catch let error{
                    print(error.localizedDescription)
                }
                print(responseJSON)
            }
        }.resume()
    }
    func profieUpdate(userKey : String , fname : String , userid : String , occupation : String, email : String ,phone : String, gender: String, completion: @escaping(Result<CommonResponse, Error>) -> Void) {
        guard let url =  URL(string: profileUpdate_url)
        else {
            return     }
        let body: [String: Any] =
        [
            "user" : userKey,
            "fname" : fname,  // to edit Full name  // or
            "userid" : userid,  // to edit User ID  // or
            "occupation" : occupation, // to edit Occupation  // or
            "email" : email,  // to edit Email  // or
            "phone" : phone, // to edit Phone  // or
            "gender" : gender// to edit Gender
            
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = ["Token":headerSecond]
        URLSession.shared.dataTask(with: request){
            (data , response, error)  in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error?.localizedDescription as! Error))
                return
            }
            guard let response = response else {
                return
            }
            print(response)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(CommonResponse.self, from: data)
                    completion(.success(postBody))
                }catch let error{
                    print(error.localizedDescription)
                }
                print(responseJSON)
            }
        }.resume()
    }
    func userIDSuggestion(userKey : String , userid : String , completion: @escaping(Result<Suggestion, Error>) -> Void) {
        guard let url =  URL(string: userIDSugestion_url)
        else {
            return     }
        let body: [String: Any] =
        [
            "user" : userKey,
            "userid" : userid
            
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = ["Token":headerSecond]
        URLSession.shared.dataTask(with: request){
            (data , response, error)  in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error?.localizedDescription as! Error))
                return
            }
            guard let response = response else {
                return
            }
            print(response)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(Suggestion.self, from: data)
                    completion(.success(postBody))
                }catch let error{
                    print(error.localizedDescription)
                }
                print(responseJSON)
            }
        }.resume()
    }
    
    func subscription(userKey : String , completion: @escaping(Result<UserSubscription, Error>) -> Void) {
        guard let url =  URL(string:  userSubscription_url)
        else {
            return     }
        let body: [String: Any] =
        [
            "user" : userKey
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = ["Token":headerSecond]
        URLSession.shared.dataTask(with: request){
            (data , response, error)  in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error?.localizedDescription as! Error))
                return
            }
            guard let response = response else {
                return
            }
            print(response)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(UserSubscription.self, from: data)
                    completion(.success(postBody))
                }catch let error{
                    print(error.localizedDescription)
                }
                print(responseJSON)
            }
        }.resume()
    }
    
    
    func activityDestination(search: String,  completion: @escaping (Result<[DestinationData], Error>) -> Void) {
        guard let url =  URL(string: activity_Dest_url)
        else {
            return     }
        let body: [String: Any] =
        [
            "search" : search
            
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = [header: headerSecond]
        URLSession.shared.dataTask(with: request){
            (data , response, error)  in
            guard let data = data, error == nil else {
                
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error?.localizedDescription as! Error ))
                return
            }
            guard let response = response else {
                return
            }
            print(response)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(ActivityDestiny.self, from: data)
                    print(postBody)
                    completion(.success(postBody.result))
                }catch let error{
                    print(error.localizedDescription)
                }
                print(responseJSON)
            }
        }.resume()
    }
    func activityList(location: String, date: String,adultNo: String,childNo: String,childAges: [Int], userId: String,completion: @escaping (Result<ActivityListResponse, Error>) -> Void){
        
        guard let url =  URL(string: activity_list_url)
        else {
            return     }
        let body: [String: Any] =
        [
            "location": location,
            "date": date,
            "adultNo": adultNo,
            "childNo": childNo,
            "childAges":childAges,
            "userId": userId
            
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = [header: headerSecond]
        URLSession.shared.dataTask(with: request){
            (data , response, error)  in
            guard let data = data, error == nil else {
                
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error?.localizedDescription as! Error ))
                return
            }
            guard let response = response else {
                return
            }
            print(response)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(ActivityListResponse.self, from: data)
                    print(postBody)
                    completion(.success(postBody))
                }catch let error{
                    print(error.localizedDescription)
                }
                print(responseJSON)
            }
        }.resume()
    }
    func activityDetails(searchId: String, activityCode: String,completion: @escaping (Result<ActivityDetails, Error>) -> Void) {
        
        guard let url =  URL(string: activity_Det_url)
        else {
            return     }
        let body: [String: Any] =
        [
            "searchId": searchId,
            "activityCode": activityCode
            
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = [header: headerSecond]
        URLSession.shared.dataTask(with: request){
            (data , response, error)  in
            guard let data = data, error == nil else {
                
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error?.localizedDescription as! Error ))
                return
            }
            guard let response = response else {
                return
            }
            print(response)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(ActivityDetails.self, from: data)
                    print(postBody)
                    completion(.success(postBody))
                }catch let error{
                    print(error.localizedDescription)
                }
                print(responseJSON)
            }
        }.resume()
    }
    
    func activityBooking(activity : ActivityBookingInput,cancellationP : String, completion: @escaping (Result<ActivityBookingOnline, Error>) -> Void) {
        
        guard let url =  URL(string: activity_booking_online)
        else {
            return     }
        let body: [String: Any] =
        [
            "searchId":activity.searchId,
            "title":activity.title,
            "fName":activity.fName,
            "lName":activity.lName,
            "childtitle":activity.childtitle,
            "chfName":activity.chfName,
            "childlast":activity.childlast,
            "userId":activity.userId,
            "adultPrice":activity.adultPrice,
            "adultNo":activity.adultNo,
            "childPrice":activity.childPrice,
            "childNo":activity.childNo,
            "totalPrice":activity.totalPrice,
            "email":activity.email,
            "contactNumber":activity.contactNumber,
            "address":activity.address,
            "checkIn":activity.checkIn,
            "from":activity.from,
            "to":activity.to,
            "hotel":activity.hotel,
            "ActivityName":activity.ActivityName,
            "ActivityImage":activity.ActivityImage,
            "duration":activity.duration,
            "rateKey":activity.rateKey,
            "currency":activity.currency,
            "cancellationPolicy":cancellationP
            
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = [header: headerSecond]
        URLSession.shared.dataTask(with: request){
            (data , response, error)  in
            guard let data = data, error == nil else {
                
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error?.localizedDescription as! Error))
                return
            }
            guard let response = response else {
                return
            }
            print(response)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(ActivityBookingOnline.self, from: data)
                    print(postBody)
                    completion(.success(postBody))
                }catch let error{
                    print(error.localizedDescription)
                }
                print(responseJSON)
            }
        }.resume()
    }
    func activityFilter(searchId: String,location : String,countryId : String ,cityId : String ,prices: String,day : [String] ,completion: @escaping (Result<ActivityListResponse, Error>) -> Void) {
        
        guard let url =  URL(string: activity_filter_url)
        else {
            return     }
        let body: [String: Any] =
        [
            "searchId": searchId,
            "location": location,
            "countryId": countryId,
            "cityId": cityId,
            "prices": prices,
            "day": day
            
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = [header: headerSecond]
        URLSession.shared.dataTask(with: request){
            (data , response, error)  in
            guard let data = data, error == nil else {
                
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error?.localizedDescription as! Error ))
                return
            }
            guard let response = response else {
                return
            }
            print(response)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(ActivityListResponse.self, from: data)
                    print(postBody)
                    completion(.success(postBody))
                }catch let error{
                    print(error.localizedDescription)
                }
                print(responseJSON)
            }
        }.resume()
    }
    func activitySort(searchId: String,location : String,countryId : String ,cityId : String ,value: String,completion: @escaping (Result<ActivityListResponse, Error>) -> Void) {
        
        guard let url =  URL(string: activity_sort_url)
        else {
            return     }
        let body: [String: Any] =
        [
            "searchId": searchId,
            "location": location,
            "countryId": countryId,
            "cityId": cityId,
            "value": value
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = [header: headerSecond]
        URLSession.shared.dataTask(with: request){
            (data , response, error)  in
            guard let data = data, error == nil else {
                
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error?.localizedDescription as! Error ))
                return
            }
            guard let response = response else {
                return
            }
            print(response)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(ActivityListResponse.self, from: data)
                    print(postBody)
                    completion(.success(postBody))
                }catch let error{
                    print(error.localizedDescription)
                }
                print(responseJSON)
            }
        }.resume()
    }
    
    func activityBookingList(userId: String ,completion: @escaping (Result<ActivityBookingList, Error>) -> Void){
        guard let url =  URL(string: activity_bookinglist)
        else {
            return     }
        let body: [String: Any] =
        [
            "userId": userId
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = [header:headerSecond]
        URLSession.shared.dataTask(with: request){
            (data , response, error)  in
            guard let data = data, error == nil else {
                
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error?.localizedDescription as! Error ))
                return
            }
            guard let response = response else {
                return
            }
            print(response)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(ActivityBookingList.self, from: data)
                    print(postBody)
                    completion(.success(postBody))
                }catch let error{
                    print(error.localizedDescription)
                }
                print(responseJSON)
            }
        }.resume()
    }
    
    func activityRedirect(key: String, completion: @escaping (Result<ActivityRedirect, Error>) -> Void) {
        guard let url =  URL(string: activity_redirect_url)
        else {
            return     }
        let body: [String: Any] =
        [
            "key": key
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = [header:headerSecond]
        URLSession.shared.dataTask(with: request){
            (data , response, error)  in
            guard let data = data, error == nil else {
                
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error?.localizedDescription as! Error ))
                return
            }
            guard let response = response else {
                return
            }
            print(response)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(ActivityRedirect.self, from: data)
                    print(postBody)
                    completion(.success(postBody))
                }catch let error{
                    print(error.localizedDescription)
                }
                print(responseJSON)
            }
        }.resume()
    }
    func activityCancel(refId: String,cancelDate: String ,completion: @escaping (Result<ActivityCancel, Error>) -> Void){
        guard let url =  URL(string: activity_cancel)
        else {
            return     }
        let body: [String: Any] =
        [
            "refId": refId,
            "cancelDate": cancelDate
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = [header:headerSecond]
        URLSession.shared.dataTask(with: request){
            (data , response, error)  in
            guard let data = data, error == nil else {
                
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error?.localizedDescription as! Error ))
                return
            }
            guard let response = response else {
                return
            }
            print(response)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(ActivityCancel.self, from: data)
                    print(postBody)
                    completion(.success(postBody))
                }catch let error{
                    print(error.localizedDescription)
                }
                print(responseJSON)
            }
        }.resume()
    }
    
    func activityBookingDetails(bookId: String ,completion: @escaping (Result<ActivityBookingDetails, Error>) -> Void) {
        guard let url =  URL(string: activity_bookingDet)
        else {
            return     }
        let body: [String: Any] =
        [
            "bookId": bookId
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = [header:headerSecond]
        URLSession.shared.dataTask(with: request){
            (data , response, error)  in
            guard let data = data, error == nil else {
                
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error?.localizedDescription as! Error ))
                return
            }
            guard let response = response else {
                return
            }
            print(response)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(ActivityBookingDetails.self, from: data)
                    print(postBody)
                    completion(.success(postBody))
                }catch let error{
                    print(error.localizedDescription)
                }
                print(responseJSON)
            }
        }.resume()
    }
    
    func hotelDestination(search: String, completion: @escaping (Result<[HDestinationData], Error>) -> Void) {
        guard let url = URL(string: hotel_Dest_url) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }

        let body: [String: Any] = ["keyword": search]

        do {
            let finalBody = try JSONSerialization.data(withJSONObject: body)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = finalBody
            request.allHTTPHeaderFields = [header: headerSecond]

            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    print("No data received")
                    completion(.failure(NSError(domain: "No data received", code: -1, userInfo: nil)))
                    return
                }

                do {
                    let postBody = try JSONDecoder().decode(HotelDestiny.self, from: data)
                    print(postBody)
                    completion(.success(postBody.result))
                } catch let decodingError {
                    print(decodingError.localizedDescription)
                    completion(.failure(decodingError))
                }
            }.resume()
        } catch let serializationError {
            print(serializationError.localizedDescription)
            completion(.failure(serializationError))
        }
    }


    func hotelList(destination: String,rooms: String ,nights: String,dates: String,occupancy: [Any],  completion: @escaping (Result<HotelListDetails, Error>) -> Void)  {
        guard let url =  URL(string: hotel_list_url)
        else {
            return     }
        let body: [String: Any] =
        [
            "destination": destination,
            "rooms": rooms,
            "nights": nights,
            "dates": dates,
            "occupancy": occupancy
            
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = [header:"birdview@v1"]
        URLSession.shared.dataTask(with: request){
            (data , response, error)  in
            guard let data = data, error == nil else {
                
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error?.localizedDescription as! Error ))
                return
            }
            guard let response = response else {
                return
            }
            print(response)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(HotelListDetails.self, from: data)
                    print(postBody)
                    completion(.success(postBody))
                }catch let error{
                    print(error.localizedDescription)
                }
                print(responseJSON)
            }
        }.resume()
    }
    func hotelDetails(searchId: String,sessionId: String ,rooms: String,nights: String,tokenId: String, productId: String,hotelId: String, completion: @escaping (Result<HotelDetails, Error>) -> Void) {
        guard let url =  URL(string: hotel_Det_url)
        else {
            return     }
        let body: [String: Any] =
        [
            "searchId": searchId,
            "sessionId": sessionId,
            "rooms": rooms,
            "nights": nights,
            "tokenId": tokenId,
            "productId": productId,
            "hotelId": hotelId
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = [header:headerSecond]
        URLSession.shared.dataTask(with: request){
            (data , response, error)  in
            guard let data = data, error == nil else {
                
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error?.localizedDescription as! Error ))
                return
            }
            guard let response = response else {
                return
            }
            print(response)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(HotelDetails.self, from: data)
                    print(postBody)
                    completion(.success(postBody))
                }catch let error{
                    print(error.localizedDescription)
                }
                print(responseJSON)
            }
        }.resume()
    }
    
    
    func hotelCheckOut(destination: String,rooms: String ,nights: String,dates: String,occupancy: String,  completion: @escaping (Result<HotelListDetails, Error>) -> Void) {
        guard let url =  URL(string: hotel_booking_online)
        else {
            return     }
        let body: [String: Any] =
        [
            "destination": destination,
            "rooms": rooms,
            "nights": nights,
            "dates": dates,
            "occupancy": occupancy
            
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = [header:headerSecond]
        URLSession.shared.dataTask(with: request){
            (data , response, error)  in
            guard let data = data, error == nil else {
                
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error?.localizedDescription as! Error ))
                return
            }
            guard let response = response else {
                return
            }
            print(response)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(HotelListDetails.self, from: data)
                    print(postBody)
                    completion(.success(postBody))
                }catch let error{
                    print(error.localizedDescription)
                }
                print(responseJSON)
            }
        }.resume()
    }
    func hotelBooking(destination: String,rooms: String ,nights: String,dates: String,occupancy: String,  completion: @escaping (Result<HotelListDetails, Error>) -> Void) {
        guard let url =  URL(string: hotel_booking_list)
        else {
            return     }
        let body: [String: Any] =
        [
            "destination": destination,
            "rooms": rooms,
            "nights": nights,
            "dates": dates,
            "occupancy": occupancy
            
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = [header:headerSecond]
        URLSession.shared.dataTask(with: request){
            (data , response, error)  in
            guard let data = data, error == nil else {
                
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error?.localizedDescription as! Error ))
                return
            }
            guard let response = response else {
                return
            }
            print(response)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(HotelListDetails.self, from: data)
                    print(postBody)
                    completion(.success(postBody))
                }catch let error{
                    print(error.localizedDescription)
                }
                print(responseJSON)
            }
        }.resume()
    }
    func hotelFilter(searchId: String,value: Int ,price: String,star: [Int],  completion: @escaping (Result<HotelListDetails, Error>) -> Void) {
        guard let url =  URL(string: hotel_filter_url)
        else {
            return     }
        let body: [String: Any] =
        [
            "searchId": searchId,
            "value": value,
            "price": price,
            "star": star
            
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = [header:headerSecond]
        URLSession.shared.dataTask(with: request){
            (data , response, error)  in
            guard let data = data, error == nil else {
                
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error?.localizedDescription as! Error ))
                return
            }
            guard let response = response else {
                return
            }
            print(response)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(HotelListDetails.self, from: data)
                    print(postBody)
                    completion(.success(postBody))
                }catch let error{
                    print(error.localizedDescription)
                }
                print(responseJSON)
            }
        }.resume()
    }
    func hotelBookingList(destination: String,rooms: String ,nights: String,dates: String,occupancy: String,  completion: @escaping (Result<HotelListDetails, Error>) -> Void)  {
        guard let url =  URL(string: hotel_booking_list)
        else {
            return     }
        let body: [String: Any] =
        [
            "destination": destination,
            "rooms": rooms,
            "nights": nights,
            "dates": dates,
            "occupancy": occupancy
            
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = [header:headerSecond]
        URLSession.shared.dataTask(with: request){
            (data , response, error)  in
            guard let data = data, error == nil else {
                
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error?.localizedDescription as! Error ))
                return
            }
            guard let response = response else {
                return
            }
            print(response)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(HotelListDetails.self, from: data)
                    print(postBody)
                    completion(.success(postBody))
                }catch let error{
                    print(error.localizedDescription)
                }
                print(responseJSON)
            }
        }.resume()
    }
    
    func hotelBookingOnline(hotel : HotelBookingInput, paxDetail : [Any], completion: @escaping (Result<HotelBookingOnline, Error>) -> Void) {
        
        guard let url =  URL(string: hotel_booking_online)
        else {
            return     }
        let body: [String: Any] =
        [
            "amount":hotel.amount!,
            "searchId": hotel.searchId!,
            "user":hotel.userId!,
            "sessionId":hotel.sessionId!,
            "tokenId":hotel.tokenId!,
            "productId": hotel.productId!,
            "rateBasisId":hotel.rateBasisId!,
            "nights":hotel.nights!,
            "rooms":hotel.rooms!,
            "adults":hotel.adults!,
            "child":hotel.child!,
            "email":hotel.email!,
            "phone":hotel.phone!,
            "paxDetails": paxDetail
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        print(finalBody)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = [header:headerSecond]
        URLSession.shared.dataTask(with: request){
            (data , response, error)  in
            guard let data = data, error == nil else {
                
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error?.localizedDescription as! Error))
                return
            }
            guard let response = response else {
                return
            }
            print(response)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(HotelBookingOnline.self, from: data)
                    print(postBody)
                    completion(.success(postBody))
                }catch let error{
                    print(error.localizedDescription)
                }
                print(responseJSON)
            }
        }.resume()
    }
    
    func hotelBookedList(userId: String ,completion: @escaping (Result<HotelBookingList, Error>) -> Void)  {
        guard let url =  URL(string: hotel_bookingList_url)
        else {
            return     }
        let body: [String: Any] =
        [
            "user": userId
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = [header:headerSecond]
        URLSession.shared.dataTask(with: request){
            (data , response, error)  in
            guard let data = data, error == nil else {
                
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error?.localizedDescription as! Error ))
                return
            }
            guard let response = response else {
                return
            }
            print(response)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(HotelBookingList.self, from: data)
                    print(postBody)
                    completion(.success(postBody))
                }catch let error{
                    print(error.localizedDescription)
                }
                print(responseJSON)
            }
        }.resume()
    }
    func hotelCancel(hbId: String,scNumber: String,rNumber: String ,completion: @escaping (Result<HotelCancel, Error>) -> Void) {
        guard let url =  URL(string: hotel_cancel)
        else {
            return     }
        let body: [String: Any] =
        [
            "hbId": hbId,
            "scNumber": scNumber,
            "rNumber": rNumber
            
        ]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = [header:headerSecond]
        URLSession.shared.dataTask(with: request){
            (data , response, error)  in
            guard let data = data, error == nil else {
                
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error?.localizedDescription as! Error ))
                return
            }
            guard let response = response else {
                return
            }
            print(response)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                do {
                    let postBody = try JSONDecoder().decode(HotelCancel.self, from: data)
                    print(postBody)
                    completion(.success(postBody))
                }catch let error{
                    print(error.localizedDescription)
                }
                print(responseJSON)
            }
        }.resume()
    }
    
    
    
    func hotelRedirect(key: String, completion: @escaping (Swift.Result<HotelRedirect, Error>) -> Void) {
        guard let url = URL(string: hotel_redirect_url) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        let body: [String: Any] = [
            "key": key
        ]
        
        do {
            let finalBody = try JSONSerialization.data(withJSONObject: body)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = finalBody
            request.allHTTPHeaderFields = ["Token": "gopaddi@v1"]
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "No data received", code: -1, userInfo: nil)))
                    return
                }
                
                do {
                    let postBody = try JSONDecoder().decode(HotelRedirect.self, from: data)
                    completion(.success(postBody))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        } catch {
            completion(.failure(error))
        }
    }
    
    
    func flightairports(user: String, keyword: String, completion: @escaping (Result<FlightairportsModel, Error>) -> Void)  {
        guard let url = URL(string: flightairports_url) else {
            // Handle invalid URL
            return
        }

        let body: [String: Any] = [
            "user": user,
            "keyword": keyword
        ]

        do {
            let finalBody = try JSONSerialization.data(withJSONObject: body)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = finalBody
            request.allHTTPHeaderFields = ["Token": headerSecond]

            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    completion(.failure(error ?? NSError(domain: "", code: 0, userInfo: nil)))
                    return
                }

                do {
                    let postBody = try JSONDecoder().decode(FlightairportsModel.self, from: data)
                    completion(.success(postBody))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }.resume()
        } catch {
            print(error.localizedDescription)
            completion(.failure(error))
        }
    }

    
    func flightapisearch(user: String, tripType: String, fromCity: String, toCity: String, departDate: String, returnDate: String, adultss: String, childss: String, infants: String, cabinClass: String, completion: @escaping (Result<FlightsearchModel, Error>) -> Void) {
        guard let url = URL(string: flightsearch_url) else {
            return
        }

        let body: [String: Any] = [
            "user": user,
            "tripType": tripType,
            "fromCity": fromCity,
            "toCity": toCity,
            "departDate": departDate,
            "returnDate": returnDate,
            "adults": adultss,
            "childs": childss,
            "infants": infants,
            "cabinClass": cabinClass
        ]

        let finalBody = try? JSONSerialization.data(withJSONObject: body)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.allHTTPHeaderFields = ["Token": headerSecond]

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }

            do {
                let flightSearchModel = try JSONDecoder().decode(FlightsearchModel.self, from: data)
                completion(.success(flightSearchModel))
            } catch {
                print("Error decoding JSON: \(error)")
                completion(.failure(error))
            }
            print(response)

        }.resume()
    }

    func flightcabins(user: String, completion: @escaping (Result<FlightcabinsModel, Error>) -> Void) {
        guard let url = URL(string: flightcabins_url) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }

        let body: [String: Any] = [
            "user": user
        ]

        do {
            let finalBody = try JSONSerialization.data(withJSONObject: body)
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = finalBody
            request.allHTTPHeaderFields = ["Token": headerSecond]
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    print(error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                    completion(.failure(NSError(domain: "No data or invalid response", code: -1, userInfo: nil)))
                    return
                }

                do {
                    let decodedData = try JSONDecoder().decode(FlightcabinsModel.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                    print("JSON Decoding Error: \(error.localizedDescription)")
                }
            }.resume()
        } catch {
            completion(.failure(error))
            print("JSON Serialization Error: \(error.localizedDescription)")
        }
    }

 
}

