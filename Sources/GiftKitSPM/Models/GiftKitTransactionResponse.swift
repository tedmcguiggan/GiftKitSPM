//
//  File.swift
//  
//
//  Created by Ted McGuiggan on 12/7/21.
//

import Foundation

public class GiftKitTransactionResponse: Codable {
    public var result: String
    public var errorMessage: String?
    public var certificateBalance: String?
    public var certificateExpirationDate: String?
    public var currency: String?
    public var authCode: String?
}
