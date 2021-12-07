import Foundation

public class GiftKitSPM {
    
    public init() {}
    
    var giftCardService = GiftCardService()
    
    // Giftcard actions
    
    public func activate(cardData: [String:Any], completion: @escaping (GiftKitTransactionResponse) -> ()) {
        giftCardService.createGiftServiceRequest(apiRelativePath: "/test", requestBody: cardData) { response in
            print("successful")
            
            // send notification back to POS/GiftKit adapter with response
            guard let safeUnwrappedResponse = response else {
                print("error")
                print(response?.errorMessage)
                return
            }
            print(safeUnwrappedResponse.errorMessage ?? "-")
            completion(safeUnwrappedResponse)
            
        } onFailure: { error in
            print("failed")
            print(error.localizedDescription)
        }
    }
    
    public func secureRedemption(cardData: [String:Any], completion: @escaping (GiftKitTransactionResponse) -> ()) {
        
        giftCardService.createGiftServiceRequest(apiRelativePath: "/test", requestBody: cardData) { response in
            print("successful")
            
            guard let safeUnwrappedResponse = response else {
                print("error")
                print(response?.errorMessage)
                return
            }
            completion(safeUnwrappedResponse)
                        
            // send notification back to POS/GiftKit adapter with response
            
        } onFailure: { error in
            print("failed")
            print(error.localizedDescription)
        }
    }
    
    public func cashbackRedemption(cardData: [String:Any], completion: @escaping (GiftKitTransactionResponse) -> ()) {
        giftCardService.createGiftServiceRequest(apiRelativePath: "/test", requestBody: cardData) { response in
            print("successful")
            
            // send notification back to POS/GiftKit adapter with response
            guard let safeUnwrappedResponse = response else {
                print("error")
                print(response?.errorMessage)
                return
            }
            completion(safeUnwrappedResponse)
            
        } onFailure: { error in
            print("failed")
            print(error.localizedDescription)
        }
    }
    
    public func balanceInquiry(cardData: [String:Any], completion: @escaping (GiftKitTransactionResponse) -> ()) {
        giftCardService.createGiftServiceRequest(apiRelativePath: "/test", requestBody: cardData) { response in
            print("successful")
            
            // send notification back to POS/GiftKit adapter with response
            guard let safeUnwrappedResponse = response else {
                print("error")
                print(response?.errorMessage)
                return
            }
            completion(safeUnwrappedResponse)
            
        } onFailure: { error in
            print("failed")
            print(error.localizedDescription)
        }

    }
    
    public func increment(cardData: [String:Any], completion: @escaping (GiftKitTransactionResponse) -> ()) {
        giftCardService.createGiftServiceRequest(apiRelativePath: "/test", requestBody: cardData) { response in
            print("successful")
            
            // send notification back to POS/GiftKit adapter with response
            guard let safeUnwrappedResponse = response else {
                print("error")
                print(response?.errorMessage)
                return
            }
            completion(safeUnwrappedResponse)
            
        } onFailure: { error in
            print("failed")
            print(error.localizedDescription)
        }
    }
    
    public func cancel(cardData: [String:Any], completion: @escaping (GiftKitTransactionResponse) -> ()) {
        giftCardService.createGiftServiceRequest(apiRelativePath: "/test", requestBody: cardData) { response in
            print("successful")
            
            // send notification back to POS/GiftKit adapter with response
            guard let safeUnwrappedResponse = response else {
                print("error")
                print(response?.errorMessage)
                return
            }
            completion(safeUnwrappedResponse)
            
        } onFailure: { error in
            print("failed")
            print(error.localizedDescription)
        }

    }
    
    public func initializeGiftService(completion: @escaping (Bool)-> ()) {
        giftCardService.createGiftServiceInitializeRequest(apiRelativePath: "/initiate", requestBody: ["client_id": "qa2.revelup.com", "establishment_id": "4713"]) { data in
            
            var giftKitInitializeResponse: GiftKitInitializeResponse?
            
            do {
                giftKitInitializeResponse = try JSONDecoder().decode(GiftKitInitializeResponse.self, from: data)
            } catch {
                print("unexpected error: \(error)")
            }
            
            guard let unwrappedResponse = giftKitInitializeResponse else {
                print("Cannot safely unwrap response")
                return
            }
            
            completion(unwrappedResponse.enabled)
        } onFailure: { error in
            print(error)
        }
    }
    
    // get notified by Gift Service when reversal
    
}
