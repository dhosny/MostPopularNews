//
//  Config.swift
//  Tadawy
//
//  Created by MAC on 1/16/19.
//  Copyright © 2019 CodexGlobal. All rights reserved.
//

import Foundation

class Config {
    
    static let sharedInstance = Config()
    
    var properties: NSMutableDictionary?
    
    fileprivate init() {
        let pListFileURL = Bundle.main.url(forResource: "Config", withExtension: "plist", subdirectory: "")
        if let pListPath = pListFileURL?.path,
            let pListData = FileManager.default.contents(atPath: pListPath) {
            do {
                let pListObject = try PropertyListSerialization.propertyList(from: pListData, options:PropertyListSerialization.ReadOptions(), format:nil)
                //Cast pListObject - If expected data type is Dictionary
                guard let pListDict = pListObject as? Dictionary<String, AnyObject> else {
                    return
                }
                
                //Cast pListObject - If expected data type is Array of Dict
                //                guard let pListArray = pListObject as? [Dictionary<String, AnyObject>] else {
                //                    return
                //                }
                //Perform actions on pListDict
                self.properties = NSMutableDictionary(dictionary: pListDict)
            } catch {
                print("Error reading regions plist file: \(error)")
                return
            }
        }
    }
    
    var baseUrl: String? {
        let key = isTest ? "TestUrl" : "LiveUrl"
        if let baseUrl = properties?.object(forKey: key) as? String {
            return baseUrl
        }
        return nil
    }
    
    var imageUrl: String? {
        let key = isTest ? "TestImageURL" : "LiveImageURL"
        if let imageURL = properties?.object(forKey: key) as? String {
            return imageURL
        }
        return nil
                
    }
    
    var applicationToken: String? {
        let key = isTest ? "TestApplicationToken" : "LiveApplicationToken"
        if let applicationToken = properties?.object(forKey: key) as? String {
            return applicationToken
        }
        return nil
    }
    
    var isTest: Bool {
        if let offline = properties?.object(forKey: "TestMode") as? Bool {
            return offline
        }
        return false
    }
    
    var boldFont: String {
        if let font = properties?.object(forKey: "BoldFont") as? String {
            return font
        }
        return ""
    }
    
    var semiBoldFont: String {
        if let font = properties?.object(forKey: "SemiBoldFont") as? String {
            return font
        }
        return ""
    }
    
    var regularFont: String {
        if let font = properties?.object(forKey: "RegularFont") as? String {
            return font
        }
        return ""
    }
    
}
