//
//  ProgramTests.swift
//  AssetTV
//
//  Created by Alexandre Malkov on 29/11/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import XCTest
@testable import AssetTV

class ProgramTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Program.deleteAll()
        
        // Load JSON file
        let fileName = "feed"
        let json = TestsHelper.readJsonFile(fileName)
        Program.loadJSON(string: json)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testProgram() {
        
        // Test unfiltered data
        var programs = Program.getFilteredItems(byTitle: "")
        XCTAssertEqual(programs.count, 100)
        
        // Test filtered data
        programs = Program.getFilteredItems(byTitle: "Europ")
        XCTAssertEqual(programs.count, 10)
    }
    
}
