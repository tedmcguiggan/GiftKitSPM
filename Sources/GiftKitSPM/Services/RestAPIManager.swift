//
//  File.swift
//  
//
//  Created by Ted McGuiggan on 12/7/21.
//

import Foundation

public class RestAPIManager: NSObject {
    
//    var baseUrl = "https://1dcfn9drek.execute-api.us-east-1.amazonaws.com/default/giftcard_service-dev-handler"
    var baseUrl = "https://giftcard-service-dev-handler.dev.revelup.io"
    
    static let contentType = "application/json"
    
    func createHTTPRequest(httpMethod: HttpMethod, relativeApiPath: String, body: [String: Any]?, onSuccess: @escaping (Data) -> Void, onFailure: @escaping (Error) -> Void) {
        
        var apiUrl = baseUrl + relativeApiPath
        apiUrl = apiUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let request = NSMutableURLRequest(url: URL(string: apiUrl)!)
        
        request.httpMethod = httpMethod.rawValue
        request.addValue(RestAPIManager.contentType, forHTTPHeaderField: "Content-Type")
        
        if let body = body {
            do {
                try request.httpBody = JSONSerialization.data(withJSONObject: body, options: [])
            } catch {
                print("unexpected error: \(error)")
            }
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest) { data, responseHeader, error in
            if let data = data {
                onSuccess(data)
            }
            if let error = error {
                onFailure(error)
            }
        }
        
        task.resume()
        
    }
    
}

