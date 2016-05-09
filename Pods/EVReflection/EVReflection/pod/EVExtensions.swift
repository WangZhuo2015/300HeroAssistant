//
//  EVExtensions.swift
//  EVReflection
//
//  Created by Edwin Vermeer on 9/2/15.
//  Copyright © 2015 evict. All rights reserved.
//

import Foundation

/**
Implementation for Equatable ==

- parameter lhs: The object at the left side of the ==
- parameter rhs: The object at the right side of the ==

 - returns: True if the objects are the same, otherwise false.
*/
public func == (lhs: EVObject, rhs: EVObject) -> Bool {
    return EVReflection.areEqual(lhs, rhs: rhs)
}

/**
Implementation for Equatable !=

- parameter lhs: The object at the left side of the ==
- parameter rhs: The object at the right side of the ==

 - returns: False if the objects are the the same, otherwise true.
*/
public func != (lhs: EVObject, rhs: EVObject) -> Bool {
    return !EVReflection.areEqual(lhs, rhs: rhs)
}


/**
Extending Array with an initializer with a json string
*/
public extension Array {
    
    /**
    Initialize an array based on a json string
    
    - parameter json: The json string
    - parameter convertionOptions: Option set for the various conversion options.
    */
    public init(json: String?, convertionOptions: ConvertionOptions = .Default) {
        self.init()
        let arrayTypeInstance = getArrayTypeInstance(self)
        let newArray = EVReflection.arrayFromJson(arrayTypeInstance, json: json, convertionOptions: convertionOptions)
        for item in newArray {
            self.append(item)
        }
    }
    
    /**
    Get the type of the object where this array is for
    
    - parameter arr: this array
    
    - returns: The object type
    */
    public func getArrayTypeInstance<T>(arr: Array<T>) -> T {
        return arr.getTypeInstance()
    }
    
    /**
    Get the type of the object where this array is for
    
    - returns: The object type
    */
    public func getTypeInstance<T>(
        ) -> T {
        if let nsobjectype: NSObject.Type = T.self as? NSObject.Type {
            let nsobject: NSObject = nsobjectype.init()
            if let obj =  nsobject as? T {
                return obj
            }
            assert(true, "Could not instantiate array item instance. will crash")
            return (nsobject as? T)!
        }
        assert(true, "Could not instantiate array item instance. will crash")
        return (NSObject() as? T)!
    }
    
    /**
    Convert this array to a json string
    
    - parameter convertionOptions: Option set for the various conversion options.
    
    - returns: The json string
    */
    public func toJsonString(convertionOptions: ConvertionOptions = .Default) -> String {
        return "[\n" + self.map({($0 as? EVObject ?? EVObject()).toJsonString(convertionOptions)}).joinWithSeparator(", \n") + "\n]"
    }
    
    /**
     Returns the dictionary representation of this array.
     
     - parameter convertionOptions: Option set for the various conversion options.
     
     - returns: The array of dictionaries
     */
    public func toDictionaryArray(convertionOptions: ConvertionOptions = .Default) -> NSArray {
        return self.map({($0 as? EVObject ?? EVObject()).toDictionary(convertionOptions)})
    }
}
