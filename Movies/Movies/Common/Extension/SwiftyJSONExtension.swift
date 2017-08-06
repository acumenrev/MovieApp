//
//  SwiftyJSONExtension.swift
//  Movies
//
//  Created by admin on 8/5/17.
//  Copyright © 2017 Tri Vo. All rights reserved.
//

import Foundation
import SwiftyJSON


extension JSON {
    
    /**
     String for key
     
     - parameter key: Key
     
     - returns: String value
     */
    func stringForKey(_ key : String) -> String {
        guard self[key].null == nil else {
            return ""
        }
        
        return self[key].stringValue
    }
    
    /**
     int for key
     
     - parameter key: Key
     
     - returns: Int value
     */
    func intForKey(_ key : String) -> Int {
        guard self[key].null == nil else {
            return 0
        }
        
        return self[key].intValue
    }
    
    /**
     Int8 For Key
     
     - parameter key: Key
     
     - returns: Int8 Value
     */
    func int8ForKey(_ key : String) -> Int8 {
        guard self[key].null == nil else {
            return 0
        }
        
        return self[key].int8Value
    }
    
    /**
     Int16 For Key
     
     - parameter key: Key
     
     - returns: Int16 Value
     */
    func int16ForKey(_ key : String) -> Int16 {
        guard self[key].null == nil else {
            return 0
        }
        
        return self[key].int16Value
    }
    
    /**
     Int32 For Key
     
     - parameter key: Key
     
     - returns: Int32 Value
     */
    func int32ForKey(_ key : String) -> Int32 {
        guard self[key].null == nil else {
            return 0
        }
        
        return self[key].int32Value
    }
    
    /**
     Int64 For Key
     
     - parameter key: Key
     
     - returns: Int64 Value
     */
    func int64ForKey(_ key : String) -> Int64 {
        guard self[key].null == nil else {
            return 0
        }
        
        return self[key].int64Value
    }
    
    /**
     UInt For Key
     
     - parameter key: Key
     
     - returns: UInt Value
     */
    func uintForKey(_ key : String) -> UInt {
        guard self[key].null == nil else {
            return 0
        }
        
        return self[key].uIntValue
    }
    
    /**
     UInt8 For Key
     
     - parameter key: Key
     
     - returns: UInt8 Value
     */
    func uint8ForKey(_ key : String) -> UInt8 {
        guard self[key].null == nil else {
            return 0
        }
        
        return self[key].uInt8Value
    }
    
    /**
     UInt16 For Key
     
     - parameter key: Key
     
     - returns: UInt16 Value
     */
    func uint16ForKey(_ key : String) -> UInt16 {
        guard self[key].null == nil else {
            return 0
        }
        
        return self[key].uInt16Value
    }
    
    /**
     UInt32 For Key
     
     - parameter key: Key
     
     - returns: UInt32 Value
     */
    func uint32ForKey(_ key : String) -> UInt32 {
        guard self[key].null == nil else {
            return 0
        }
        
        return self[key].uInt32Value
    }
    
    /**
     UInt64 For Key
     
     - parameter key: Key
     
     - returns: UInt64 Value
     */
    func uint64ForKey(_ key : String) -> UInt64 {
        guard self[key].null == nil else {
            return 0
        }
        
        return self[key].uInt64Value
    }
    
    /**
     Double for key
     
     - parameter key: Key
     
     - returns: Double value
     */
    func doubleForKey(_ key : String) -> Double {
        guard self[key].null == nil else {
            return 0
        }
        
        return self[key].doubleValue
    }
    
    /**
     Float for key
     
     - parameter key: Key
     
     - returns: Float value
     */
    func floatForKey(_ key : String) -> Float {
        
        guard self[key].null == nil else {
            return 0.0
        }
        
        return self[key].floatValue
    }
    
    /**
     Bool for key
     
     - parameter key: Key
     
     - returns: Bool value
     */
    func boolForKey(_ key : String) -> Bool {
        guard self[key].null == nil else {
            return false
        }
        
        return self[key].boolValue
    }
    
    /**
     Array for key
     
     - parameter key: Key
     
     - returns: Array
     */
    func arrayForKey(_ key : String) -> [AnyObject]? {
        guard self[key].null == nil else {
            return nil
        }
        
        return self[key].arrayObject as [AnyObject]?
    }
    
    
    func existKey(_ key : String) -> Bool {
        var exist = self[key].exists()
        exist = self[key] != JSON.null
        
        return exist
    }
    
}
