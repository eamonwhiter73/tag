//
//  EncryptionService.swift
//  tagit
//
//  Created by Eamon White on 12/4/17.
//  Copyright © 2017 EamonWhite. All rights reserved.
//

import Foundation
import CommonCrypto

class EncryptionService: NSObject {
    
    public func AESEncryption(phrase: String, key: String, ivKey: String, encryptOrDecrypt: Bool) -> NSMutableData? {
        let phraseData = phrase.data(using: String.Encoding.utf8)
        let ivData = ivKey.data(using: String.Encoding.utf8)
        let keyData: NSData! = key.data(using: String.Encoding.utf8, allowLossyConversion: false)! as NSData
        let keyBytes         = UnsafeRawPointer(keyData.bytes)
        let keyLength        = size_t(kCCKeySizeAES128)
        let dataLength       = Int(phraseData!.count)
        let dataBytes        = UnsafeRawPointer(phraseData!.withUnsafeBytes { (bytes: UnsafePointer<UInt8>) in
            return bytes
        })
        let bufferData       = NSMutableData(length: Int(dataLength) + kCCBlockSizeAES128)!
        let bufferPointer    = UnsafeMutableRawPointer(bufferData.mutableBytes)
        let bufferLength     = size_t(bufferData.length)
        let preBuffer = ivData!.withUnsafeBytes { (bytes: UnsafePointer<UInt8>) in
            return bytes
        }
        let ivBuffer = UnsafeRawPointer(preBuffer)
        
        var bytes = Int(0)
        
        let operation = encryptOrDecrypt ? UInt32(kCCEncrypt) : UInt32(kCCDecrypt)
        print(operation.description + "    operation")
        let algorithm:  CCAlgorithm = UInt32(kCCAlgorithmAES128)
        let options:   CCOptions   = UInt32(kCCOptionPKCS7Padding)
        
        let cryptStatus = CCCrypt(
            operation,
            algorithm,
            options,
            keyBytes,
            keyLength,
            ivBuffer,
            dataBytes,
            dataLength,
            bufferPointer,
            bufferLength,
            &bytes)
        if Int32(cryptStatus) == Int32(kCCSuccess) {
            bufferData.length = bytes
            return bufferData
        } else {
            print("Encryption Error: \(cryptStatus)")
        }
        return nil
    }
}
