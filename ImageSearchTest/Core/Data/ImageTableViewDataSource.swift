//
//  ImageTableViewDataSource.swift
//  ImageSearchTest
//
//  Created by Oleksii Shulzhenko on 01.02.2018.
//  Copyright © 2018 Oleksii Shulzhenko. All rights reserved.
//

import UIKit

class ImageTableViewDataSource: NSObject, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ImageModelController.share.modelsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.Identifier, for: indexPath as IndexPath) as! ImageTableViewCell
        let model = ImageModelController.share.imageViewModel(at: indexPath.row)
        cell.imageimageView.image = model.image
        cell.textLable.text = model.requestString
        return cell
    }
}
