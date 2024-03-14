//
//  BaseVM.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//

import Foundation
import SwiftyJSON
import Alamofire
import UIKit

class BaseVM: NSObject, ObservableObject, LoadingIndicatorDelegate {
    static let shared = BaseVM()
    
    //ALERTS
    @Published var isShowAlert = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    
}

extension BaseVM {
    func handleErrorResponse(_ error: Error?, completion: CompletionHandler) {
        if let errorResponse = error as? ErrorResponse {
            switch errorResponse {
            case .error(let statusCode, let data, let error):
                if let responseData = data {
                    let errorJson = JSON(responseData)
                    
                    if let message = errorJson["message"].string {
                        print("error: \(message), code: \(statusCode)")
                        completion(false, statusCode, message)
                    } else {
                        print("error: \(error.localizedDescription) , code: \(statusCode)")
                        completion(false, statusCode, error.localizedDescription)
                    }
                } else if let errorResponse = error as? AFError {
                    switch errorResponse {
                    case .invalidURL(let url):
                        print("Error in URL: \(url)")
                        completion(false, errorResponse.responseCode ?? 500, errorResponse.errorDescription ?? errorResponse.localizedDescription)
                    default:
                        print("error: \(errorResponse.errorDescription ?? errorResponse.localizedDescription), code: \(statusCode)")
                        completion(false, errorResponse.responseCode ?? 500, errorResponse.errorDescription ?? errorResponse.localizedDescription)
                    }
                }
            }
        } else if let errorResponse = error as? DecodingError {
            switch errorResponse {
            case .typeMismatch(let type, let context):
                print("Type '\(type)' mismatch: \(context.codingPath)" )
                completion(false, 422, context.debugDescription)
            default:
                completion(false, 422, error?.localizedDescription ?? .ErrorCorrupted)
            }
        }
    }
    
}

//MARK:- Alert
extension BaseVM {
    func handleErrorAndShowAlert(error: Error?) {
        self.handleErrorResponse(error) { (status, statusCode, message) in
            self.alertTitle = "Error"
            self.alertMessage = message
            self.stopLoading()
            self.isShowAlert = true
            return
        }
    }
    
    func showNoInternetAlert() {
        self.alertTitle = .Error
        self.alertMessage = .NoInternet
        self.isShowAlert = true
    }
}


//MARK:- Logs
extension BaseVM {
    
    func showErrorLogger(message:String){
        Logger.log(logType: LogType.error, message: message)
    }
    
    func showSuccessLogger(message:String){
        Logger.log(logType: LogType.success, message: message)
    }
    
    
    func showInfoLogger(message:String){
        Logger.log(logType: LogType.info, message: message)
    }

}


extension BaseVM {
    func getJsonString<T: Encodable>(data: [T]) -> String {
        let jsonData = try! JSONEncoder().encode(data)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        return jsonString
    }
    
    func getSavedURL(image: UIImage, name: String) -> URL? {
        guard let imageURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("temp"+"\(name)"+".jpeg") else {
            print("Failed getting URL: \(name)")
            return nil
        }
        do {
            try image.jpegData(compressionQuality: 0.1)?.write(to: imageURL)
            print("Success saving image \(name) with URL \(imageURL)")

        } catch {
            print("❌ Failed saving image: \(name)")
            return nil
        }
        
        return imageURL
    }
}

extension BaseVM{
    //MARK: - LOGOUT FUNCATION
    func proceedLogoutAPi(completion: @escaping (_ status: Bool) -> ()) {
        
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            showNoInternetAlert()
            completion(false)
            return
        }
        
        
//        
//        AuthAPI.authGetLogout(accept: ASP.shared.accept) { response, error in
//            
//            if error != nil {
//                self.handleErrorAndShowAlert(error: error)
//                completion(false)
//                return
//                
//            }else{
//                completion(true)
//                PersistenceController.shared.deleteUserData()
//            }
//        }
        
    }
}

