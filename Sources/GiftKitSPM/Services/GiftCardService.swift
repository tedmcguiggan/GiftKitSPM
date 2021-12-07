//
//  File.swift
//  
//
//  Created by Ted McGuiggan on 12/7/21.
//

import Foundation

public protocol GiftCardServiceProtocols {
    func createGiftServiceRequest(apiRelativePath: String, requestBody: [String:Any]?, onSuccess: @escaping (GiftKitTransactionResponse?) -> Void, onFailure: @escaping (Error) -> Void)
}

public class GiftCardService: GiftCardServiceProtocols {
        
    public init() {}
        
    public var restAPIManager = RestAPIManager()
    // static var sharedInstance = GiftCardService()
        
    public func createGiftServiceRequest(apiRelativePath: String, requestBody: [String:Any]?, onSuccess: @escaping (GiftKitTransactionResponse?) -> Void, onFailure: @escaping (Error) -> Void) {
        
        var giftKitResponse: GiftKitTransactionResponse?
        
        restAPIManager.createHTTPRequest(httpMethod: .POST, relativeApiPath: apiRelativePath, body: requestBody) { data in
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                giftKitResponse = try decoder.decode(GiftKitTransactionResponse.self, from: data)
            } catch {
                print("unexpected error: \(error)")
            }
            onSuccess(giftKitResponse)
        } onFailure: { error in
            onFailure(error)
        }

    }
    
    public func createGiftServiceInitializeRequest(apiRelativePath: String, requestBody: [String:Any]?, onSuccess: @escaping (Data) -> Void, onFailure: @escaping (Error) -> Void) {
        
        restAPIManager.createHTTPRequest(httpMethod: .POST, relativeApiPath: apiRelativePath, body: requestBody) { data in
            onSuccess(data)
        } onFailure: { error in
            onFailure(error)
        }

        
    }
    
}

public class GiftCardMockService: GiftCardServiceProtocols {
      
    public init() {}
    
    public func createGiftServiceRequest(apiRelativePath: String, requestBody: [String:Any]?, onSuccess: @escaping (GiftKitTransactionResponse?) -> Void, onFailure: @escaping (Error) -> Void) {
        
        var giftKitResponse: GiftKitTransactionResponse!
        
        giftKitResponse.result = "success"
        giftKitResponse.certificateBalance = "100.00"
        giftKitResponse.certificateExpirationDate = "None"
        giftKitResponse.currency = "$"
        
        onSuccess(giftKitResponse)

    }
}

