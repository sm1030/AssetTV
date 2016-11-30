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
        var programs = Program.getAll()
        XCTAssertEqual(programs?.count, 126)
        
        // Test first record
        XCTAssertEqual(programs?[0].nid, 7615)
        XCTAssertEqual(programs?[0].title, "Global Equities | Masterclass")
//        XCTAssertEqual(programs?[0].date, Program.date(fromString: "2016/01/28"))
        XCTAssertEqual(programs?[0].duration, "49:32")
        XCTAssertEqual(programs?[0].image_url, "https://embed-titan-uk.pantheonsite.io/sites/default/files/images/7a56182806ac6e0fccba5ee1d5e8ea7094b5020d38e5b7708c995d5516e66d47_5451_Live_Global_Equities.jpg")
        XCTAssertEqual(programs?[0].descript, "In this masterclass on global equities, a panel of experts review global equities in the year to date, what issues were expected throughout the year, the US election, whether to expect a bear market for bonds and equities and give their outlooks for the last quarter of the year.\r\n\r\nOn the panel are:\r\nSimon Clements, Investment Management, ATI\r\nJamie Horvat, Fund Manager, M&G Global Basics Fund, M&G Investments\r\nLaurence Taylor, Portfolio Specialist, Equity Devision, T.Rowe Price\r\n\r\nLearning outcomes:\r\nThe factors that have influenced global equities in the year to date\r\nHow global equity portfolios are currently structured\r\nWhat themes are currently in favour in global equity portfolios")
        XCTAssertEqual(programs?[0].contact_details, "")
        XCTAssertEqual(programs?[0].terms, "asset.tv, ATI, Bonds, Equities, Global Equities, Jamie Horvat, Laurence Taylor, M&amp;G Investments, Markets, Masterclass, Masterclass, Mutual funds, Simon Clements, T. Rowe Price, US election")
        
        // Test last record
        XCTAssertEqual(programs?[125].nid, 2243)
        XCTAssertEqual(programs?[125].title, "Institutional Masterclass - Corporate Index Linked Bonds")
        //        XCTAssertEqual(programs?[0].date, Program.date(fromString: "2016/01/28"))
        XCTAssertEqual(programs?[125].duration, "38:37")
        XCTAssertEqual(programs?[125].image_url, "https://embed-titan-uk.pantheonsite.io/sites/default/files/video/images/institutional_masterclass_-_corporate_index_linked_bonds_migrated.jpg")
        XCTAssertEqual(programs?[125].descript, "Corporate Index Linked Bonds with Julian Lyne, Head of Global Consultants, Ian Robinson, Head of Credit, and Andrew Brown, Fund Manager Credit.")
        XCTAssertEqual(programs?[125].contact_details, "London • Harpenden\nTel: +44 (0)1582 764000\nNew York\nTel: +1 212 661 4111\nIf you have found this report informative and would like further information please email asset.tv at hello@asset.tv\n")
        XCTAssertEqual(programs?[125].terms, "Andrew Brown, F&amp;C Investments, Ian Robinson, Julian Lyne")
        
        // Test filtered data
        programs = Program.getFilteredItems(byTitle: "Europ")
        XCTAssertEqual(programs?.count, 3)
    }
    
}
