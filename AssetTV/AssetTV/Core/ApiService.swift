//
//  ApiService.swift
//  AssetTV
//
//  Created by Alexandre Malkov on 30/11/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import Foundation
import Alamofire

protocol ApiServiceDelegate: class {
    func apiServiceDataReceived()
}

class ApiService {
    
    weak var delegate: ApiServiceDelegate?
    
    init(delegate: ApiServiceDelegate) {
        self.delegate = delegate
    }
    
    func requestPrograms() {
        
        Alamofire.request("https://embed-titan-uk.pantheonsite.io/api/channel-json/latest/2240/23").responseJSON { response in
            
            if let _ = response.result.value {
                
                // Delete old data
                Program.deleteAll()
                
                // Load new schedule data
                Program.loadJSON(data: response.data)
                
                // Save changes
                DataController.saveContext()
                
                // Notify delegate
                self.delegate?.apiServiceDataReceived()
            }
        }
    }
    
    func requestImage(image_url: String?) {
        if image_url != nil {
            Alamofire.request(image_url!).responseData(completionHandler: { (dataResponse: DataResponse<Data>) in
                if dataResponse.data != nil {
                    Image.saveImage(url: image_url!, data: dataResponse.data!)
                    self.delegate?.apiServiceDataReceived()
                }
            })
        }
    }
    
}
