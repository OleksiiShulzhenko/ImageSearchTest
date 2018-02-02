//
//  GettyimagesAPI.swift
//  ImageSearchTest
//
//  Created by Oleksii Shulzhenko on 02.02.2018.
//  Copyright © 2018 Oleksii Shulzhenko. All rights reserved.
//

import Foundation

class GettyimagesAPI {
    
    private static let _instance = GettyimagesAPI()
    static var instance: GettyimagesAPI { return _instance }
    
    func getImage(for name: String,_ completionBlock: @escaping ( _ success: Bool, _ errorMessage: String?, _ imageURL: String?) -> ()) {
        
        let apiKey = "vdhyd6p5adhfz7687hz869kf"
        let urlPath = "https://api.gettyimages.com/v3/search/images?fields=id,title,thumb,referral_destinations&sort_order=best&phrase=\(String(describing: name.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!))"
        
        guard let url = URL(string: urlPath) else {
            print("Error creating url")
            return
        }
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "Api-Key")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if (response as! HTTPURLResponse).statusCode == 200{
                do {
                    guard let data = data else {return}
                    
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] else {return}
                    
                    guard let result_count = json["result_count"] as? Int else {return}
                    guard result_count != 0 else {completionBlock(false, "image count = 0", nil); return}
                    
                    guard let images = json["images"] as? [[String:AnyObject]] else {return}
                    
                    guard let referral_destinations = images[0]["display_sizes"] as? [[String:AnyObject]] else {return}
                    
                    guard let uri = referral_destinations[0]["uri"] as? String else {return}
                    
                    completionBlock(true, nil, uri)
                } catch let error {
                    print(error)
                }
            } else {
                print(error)
                completionBlock(false, error?.localizedDescription, nil)
            }
            }.resume()
    }
}
