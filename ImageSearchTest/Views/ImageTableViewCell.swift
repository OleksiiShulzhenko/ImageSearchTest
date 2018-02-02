//
//  ImageTableViewCell.swift
//  ImageSearchTest
//
//  Created by Oleksii Shulzhenko on 01.02.2018.
//  Copyright © 2018 Oleksii Shulzhenko. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    static let Identifier = "ImageTableViewCellID"
    
    let imageimageView = UIImageView()
    let textLable = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubviews() {
        self.addSubview(imageimageView)
        imageimageView.translatesAutoresizingMaskIntoConstraints = false
        imageimageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75).isActive = true
        //imageimageView.widthAnchor.constraint(equalTo: imageimageView.heightAnchor).isActive = true
        imageimageView.topAnchor.constraintEqualToSystemSpacingBelow(self.topAnchor, multiplier: 1).isActive = true
        //imageimageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        imageimageView.leadingAnchor.constraintEqualToSystemSpacingAfter(self.leadingAnchor, multiplier: 1).isActive = true
        self.trailingAnchor.constraintEqualToSystemSpacingAfter(imageimageView.trailingAnchor, multiplier: 1).isActive = true
        imageimageView.backgroundColor = UIColor.clear
        imageimageView.contentMode = .scaleAspectFit
        
        
        self.addSubview(textLable)
        textLable.backgroundColor = UIColor.clear
        textLable.translatesAutoresizingMaskIntoConstraints = false
        textLable.topAnchor.constraintEqualToSystemSpacingBelow(imageimageView.bottomAnchor, multiplier: 1).isActive = true
        
        self.bottomAnchor.constraintEqualToSystemSpacingBelow(textLable.bottomAnchor, multiplier: 1).isActive = true
        textLable.leadingAnchor.constraintEqualToSystemSpacingAfter(self.leadingAnchor, multiplier: 1).isActive = true
        self.trailingAnchor.constraintEqualToSystemSpacingAfter(textLable.trailingAnchor, multiplier: 1).isActive = true
        textLable.textAlignment = .center
    }
}
