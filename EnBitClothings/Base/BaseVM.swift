//
//  BaseVM.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//

import Foundation
//import SwiftyJSON
import Alamofire
import UIKit

class BaseVM: NSObject, ObservableObject, LoadingIndicatorDelegate {
    static let shared = BaseVM()
    
    //ALERTS
    @Published var isShowAlert = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    
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
    func convertStringToDate(_ dateString: String, format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: dateString)
    }

    func extractDate(from isoDate: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        if let date = isoFormatter.date(from: isoDate) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            return dateFormatter.string(from: date)
        } else {
            return "Invalid date"
        }
    }
}


extension BaseVM {
    func proceedLogoutAPi(completion : @escaping CompletionHandler) {
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            completion(false, "Internet connection appears to be offline.")
            return
        }
        
        // Prepare the endpoint
        let endpoint = "/user/logout"
        
        
        // Make the request with JSON encoding
        AFWrapper.shared.request(endpoint, method: .get, encoding: URLEncoding.default, success: { (response: UserResponse) in
            
            //MARK: - LOCAL USER DELETE
            PersistenceController.shared.deleteUserData()
            
            completion(true, "Logout Success.")
        }, failure: { error in
            if let afError = error as? AFWrapperError {
                completion(false, afError.errorMessage)
            } else {
                completion(false, error.localizedDescription)
            }
        })
    }
}

