//
//  Image+Methods.swift
//  AssetTV
//
//  Created by Alexandre Malkov on 29/11/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import Foundation
import CoreData

extension Image {
    
    static func saveImage(url: String, data: Data) {
        var image = Image.getImage(url: url)
        if image == nil {
            image = NSEntityDescription.insertNewObject(forEntityName: String(describing: Image.self), into: DataController.getContext()) as? Image
        }
        image?.url = url
        image?.original = data as NSData?
    }
    
    static func getImage(url: String) -> Image? {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Image.self))
            fetchRequest.predicate = NSPredicate(format: "url = %@", url)
            if let fetchResults = try DataController.getContext().fetch(fetchRequest) as? [Image] {
                if fetchResults.count > 0 {
                    return fetchResults[0]
                }
            }
        } catch let error {
            print("ERROR: \(error)")
        }
        
        return nil
    }
    
    static func deleteAll() {
        for image in Image.getAll() ?? [Image]() {
            DataController.getContext().delete(image)
        }
    }
    
    static func getAll() -> [Image]? {
        do {
            let fetchRequest: NSFetchRequest<Image> = Image.fetchRequest()
            return try DataController.getContext().fetch(fetchRequest)
        } catch let error {
            print("ERROR: \(error)")
        }
        return nil
    }
    
}
