//
//  ImageModel+Persistable.swift
//  ImageSearchTest
//
//  Created by Oleksii Shulzhenko on 02.02.2018.
//  Copyright © 2018 Oleksii Shulzhenko. All rights reserved.
//

import Foundation
import RealmSwift

extension ImageModel: Persistable {
    
    public init(managedObject: ImageModelObject) {
        identifier = managedObject.identifier
        image = UIImage(data: managedObject.image!)!
        requestString = managedObject.requestString
    }
    
    public func managedObject() -> ImageModelObject {
        let imageModelObject = ImageModelObject()
        imageModelObject.identifier = identifier
        imageModelObject.image = UIImageJPEGRepresentation(image, 1)
        imageModelObject.requestString = requestString
        
        return imageModelObject
    }
}

extension ImageModel {
    
    public enum PropertyValue: PropertyValueType {
        case image(UIImage)
        case requestString(String)
        case identifier(String)
        
        public var propertyValuePair: PropertyValuePair {
            switch self {
            case .identifier(let id):
                return ("identifier", id)
            case .requestString(let requestString):
                return ("requestString", requestString)
            case .image(let image):
                return ("image", image)
            }
        }
    }
}

extension ImageModel {
    
    public enum Query: QueryType {
        case all
        
        public var predicate: NSPredicate? {
            switch self {
            case .all:
                return NSPredicate(value: true)
            }
        }
        
        public var sortDescriptors: [SortDescriptor] {
            return [SortDescriptor(keyPath: "identifier")]
        }
    }
}

