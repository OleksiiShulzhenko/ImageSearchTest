//
//  ImageModelController.swift
//  ImageSearchTest
//
//  Created by Oleksii Shulzhenko on 02.02.2018.
//  Copyright © 2018 Oleksii Shulzhenko. All rights reserved.
//

import UIKit

class ImageModelController {
    
    static let share = ImageModelController()
    
    private var imageViewModels = [ImageModel]()
    
    let container = try! Container()
    
    var modelsCount: Int {
        get {
            return imageViewModels.count
        }
    }
    
    init() {
        let results = container.values(
            ImageModel.self,
            matching: .all
        )
        
        imageViewModels = results.reversed()
        print(imageViewModels)
    }
    
    func retriveImage(for name: String,_ completionBlock: @escaping ( _ success: Bool, _ errorMessage: String?) -> ()) {
        
        GettyimagesAPI.instance.getImage(for: name) { [weak self](success, errorMessage, imageURL) in
            if !success {
                completionBlock(false, errorMessage)
            } else {
                
                guard let data = try? Data(contentsOf: URL(string: imageURL!)!) else {return}
                guard let image = UIImage(data: (data)) else {return}
                
                let imageViewModel = ImageModel(image: image, requestString: name, identifier: (self?.imageViewModels.count)!)
                    //ImageModel(image: image, requestString: name)
                
                DispatchQueue.main.async {
                    try! self?.container.write { transaction in
                        transaction.add(imageViewModel)
                    }
                }
                
                self?.imageViewModels.insert(imageViewModel, at: 0)
                completionBlock(true, nil)
            }
        }
    }
    
    func imageViewModel(at index: Int) -> ImageModel {
        return imageViewModels[index]
    }
}
