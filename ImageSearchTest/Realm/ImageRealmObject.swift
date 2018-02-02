//
//  ImageRealmObject.swift
//  ImageSearchTest
//
//  Created by Oleksii Shulzhenko on 02.02.2018.
//  Copyright © 2018 Oleksii Shulzhenko. All rights reserved.
//

import Foundation
import RealmSwift

final class ImageModelObject: Object {
    @objc dynamic var image: Data? = nil
    @objc dynamic var requestString = ""
    @objc dynamic var identifier = 0
    override static func primaryKey() -> String? {
        return "identifier"
    }
}

