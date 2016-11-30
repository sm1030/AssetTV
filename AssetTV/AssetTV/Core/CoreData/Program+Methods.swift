//
//  Program+Methods.swift
//  AssetTV
//
//  Created by Alexandre Malkov on 29/11/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import Foundation
import CoreData

extension Program {
    
    static func loadJSON(string: String) {
        let data = string.data(using: .utf8)
        Program.loadJSON(data: data)
    }
    
    static func loadJSON(data: Data?) {
        if data != nil {
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as? Array<Dictionary<String, AnyObject>> {
                    for item in json {
                        if let nid = Int((item["nid"] as? String) ?? "0") {
                            let program = NSEntityDescription.insertNewObject(forEntityName: String(describing: Program.self), into: DataController.getContext()) as? Program
                            program?.nid = Int32(nid)
                            program?.title = item["title"] as? String
                            program?.date =  Program.date(fromString: (item["date"] as? String) ?? "")
                            program?.duration = item["duration"] as? String
                            program?.image_url = item["image_url"] as? String
                            program?.descript = item["description"] as? String
                            program?.contact_details = item["contact_details"] as? String
                            program?.terms = item["terms"] as? String
                        }
                    }
                }
                DataController.saveContext()
            } catch let error {
                print("ERROR: \(error)")
            }
        }
    }
    
    static func getFilteredItems(byTitle title: String) -> [Program]? {
        do {
            let fetchRequest: NSFetchRequest<Program> = Program.fetchRequest()
            if title.characters.count > 0 {
                fetchRequest.predicate = NSPredicate(format: "title contains[c] %@", title)
            }
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "nid", ascending: false)]
            return try DataController.getContext().fetch(fetchRequest)
        } catch let error {
            print("ERROR: \(error)")
        }
        return nil
    }
    
    static func deleteAll() {
        for program in Program.getAll() ?? [Program]() {
            DataController.getContext().delete(program)
        }
    }
    
    static func getAll() -> [Program]? {
        return getFilteredItems(byTitle: "")
    }
    
    static func date(fromString dateString: String) -> NSDate? {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy/mm/dd"
        return dateFormater.date(from: dateString) as NSDate?
    }
    
}
