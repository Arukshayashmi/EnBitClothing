//
//  AFWrapper.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//

import Alamofire
import Foundation
import UIKit


struct APIErrorResponse: Codable {
    let status: String?
    let code: String?
    let message: String?
}
enum AFWrapperError: Error {
    case requestFailed(String)
    case decodingFailed
    
    var errorMessage: String {
        switch self {
        case .requestFailed(let message):
            return message
        case .decodingFailed:
            return "Decoding failed."
        }
    }
}


final class AFWrapper {
    
    static let shared = AFWrapper()
    
    private init() {} // Private initializer to ensure Singleton usage
    
    
    
    func request<T: Decodable>(
        _ endpoint: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = JSONEncoding.default,
        headers: HTTPHeaders? = nil,
        success: @escaping (T) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        var allParameters = parameters ?? Parameters()
        
        var allHeaders = headers ?? HTTPHeaders()
        
        // Attempt to retrieve and log the auth token
        if !iBSUserDefaults.authToken.isEmpty {
            print("Using auth token: \(iBSUserDefaults.authToken)")
            allHeaders.add(name: "Authorization", value: "Bearer \(iBSUserDefaults.authToken)")
        } else {
            print("No auth token found")
        }
        
        // MARK: - if we are using anykind of API keys and authorisation tokens, in here we can add like this
//        allParameters["apiKey"] = Constant.apiKey
        

        // Remove any nil, NSNull, and empty string values
        allParameters = allParameters.compactMapValues {
            if $0 is NSNull || $0 as? String == "" {
                return nil
            }
            return $0
        }

        //remove null values
        let requestURL = Constant.getBaseURL.appending(endpoint)
        
        print("🔹Prerquest data : Url \(requestURL)\n🔹")
        
        
        let request = AF.request(requestURL, method: method, parameters: allParameters, encoding: encoding, headers: allHeaders)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .failure(let error):
                    
                    if let data = response.data, let decodingError = try? JSONDecoder().decode(APIErrorResponse.self, from: data) {
                        failure(AFWrapperError.requestFailed(decodingError.message ?? ""))
                        return
                    }else{
                        let message = "Request failed: \(error.localizedDescription)"
                        failure(AFWrapperError.requestFailed(message))
                    }
                    
                case .success(let data):
                    self.decode(data: data, success: success, failure: failure)
                }
            }
        
        DispatchQueue.main.async {
            // your code here
            print("REQUEST = \(request.debugLog())")
        }
    }
    
    
    private func decode<T: Decodable>(data: Data, success: @escaping (T) -> Void, failure: @escaping (Error) -> Void) {
        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let result = try decoder.decode(T.self, from: data)
            success(result)
        } catch {
            failure(AFWrapperError.decodingFailed)
        }
    }
}

// MARK: - FOR IMAGE UPLOAD
extension AFWrapper {
    func uploadImage<T: Decodable>(
        _ endpoint: String,
        image: UIImage,
        imageName: String,
        parameters: [String: String]? = nil,
        headers: HTTPHeaders? = nil,
        progressCompletion: @escaping (Double) -> Void,
        success: @escaping (T) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        let requestURL = Constant.getBaseURL.appending(endpoint)
        
        // Prepare headers
        var allHeaders = headers ?? HTTPHeaders()
        if !iBSUserDefaults.authToken.isEmpty {
            allHeaders.add(name: "Authorization", value: "Bearer \(iBSUserDefaults.authToken)")
        }
        
        AF.upload(multipartFormData: { multipartFormData in
            // Append image
            if let imageData = image.jpegData(compressionQuality: 0.5) { // Consider adjusting compression quality
                multipartFormData.append(imageData, withName: imageName, fileName: "image.jpg", mimeType: "image/jpeg")
            }
            
            // Append other parameters
            parameters?.forEach { key, value in
                if let data = value.data(using: .utf8) {
                    multipartFormData.append(data, withName: key)
                }
            }
        }, to: requestURL, method: .put, headers: allHeaders)
        .uploadProgress { progress in
            progressCompletion(progress.fractionCompleted)
        }
        .validate(statusCode: 200..<300)
        .responseData { response in
            switch response.result {
            case .success(let data):
                self.decode(data: data, success: success, failure: failure)
            case .failure(let error):
                if let data = response.data, let decodingError = try? JSONDecoder().decode(APIErrorResponse.self, from: data) {
                    failure(AFWrapperError.requestFailed(decodingError.message ?? "Unknown error occurred"))
                } else {
                    failure(error)
                }
            }
        }
    }

}


struct Constant {
    static let apiKey = "API key goes in here"
    static let getBaseURL =  "http://localhost:8080/api/v1"
}


extension Request {
    public func debugLog() -> Self {
#if DEBUG
        cURLDescription(calling: { (curl) in
            debugPrint("=======================================")
            print(curl)
            debugPrint("=======================================")
        })
#endif
        return self
    }
}
