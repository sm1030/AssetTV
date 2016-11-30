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
    var titleFilter = ""
    var programs = [Program]()
    
    func pullUpdates() {
        if api == nil {
            api = ApiService(delegate: self)
        }
        
        api?.requestPrograms()
    }
    
    func apiServiceProgramDataReceived() {
        programs = Program.getFilteredItems(byTitle: titleFilter) ?? [Program]()
        delegate?.presenterDataUpdated()
    }
    
    func apiServiceDataImageReceived() {
        delegate?.presenterDataUpdated()
    }
    
    func applyNewTitleFilter(newTitleFilter: String) {
        titleFilter = newTitleFilter
        apiServiceProgramDataReceived()
    }

    func getCachedImage(image_url: String) -> Image? {
        let image = Image.getImage(url: image_url)
        if image == nil {
            api?.requestImage(image_url: image_url)
        }
        return image
    }
}
