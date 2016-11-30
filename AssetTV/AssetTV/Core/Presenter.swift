//
//  Presenter.swift
//  AssetTV
//
//  Created by Alexandre Malkov on 30/11/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import Foundation
import CoreData

protocol PresenterDelegate: class {
    func presenterDataUpdated()
}

class Presenter: ApiServiceDelegate {
    
    static let sharedInstance = Presenter()
    
    weak var delegate: PresenterDelegate?
    var api: ApiService?
    var lastTitleFilter = ".."
    
    func pullUpdates() {
        if api == nil {
            api = ApiService(delegate: self)
        }
        
        api?.requestPrograms()
    }
    
    func apiServiceDataReceived() {
        delegate?.presenterDataUpdated()
    }
    
    func getFilteredPrograms(title: String) -> [Program] {
        let programs = Program.getFilteredItems(byTitle: title)
        if lastTitleFilter != title {
            lastTitleFilter = title
            delegate?.presenterDataUpdated()
        }
        return programs ?? [Program]()
    }

    func getCachedImage(image_url: String) -> Image? {
        let image = Image.getImage(url: image_url)
        if image == nil {
            api?.requestImage(image_url: image_url)
        }
        return image
    }
}
