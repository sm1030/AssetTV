//
//  ImageTests.swift
//  AssetTV
//
//  Created by Alexandre Malkov on 29/11/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import XCTest
@testable import AssetTV

class ImageTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Image.deleteAll()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSaveAndGetImage() {
        
        var logoData: Data? = nil
        var splashData: Data? = nil
        
        // Make sure there is no images
        XCTAssertEqual(Image.getAll()?.count, 0)
        
        // Save logo
        if let image = UIImage(named: "logo.png") {
            logoData = UIImagePNGRepresentation(image)
            Image.saveImage(url: "logo", data: logoData!)
        } else {
            XCTFail()
        }
        
        // Should be 1 image
        XCTAssertEqual(Image.getAll()?.count, 1)
        
        // Save splash
        if let image = UIImage(named: "splash") {
            splashData = UIImagePNGRepresentation(image)
            Image.saveImage(url: "splash", data: splashData!)
        } else {
            XCTFail()
        }
        
        // Should be 2 images
        XCTAssertEqual(Image.getAll()?.count, 2)
        
        //Check results
        let logoImage = Image.getImage(url: "logo")
        let splashImage = Image.getImage(url: "splash")
        XCTAssertEqual(logoImage?.original as Data?, logoData)
        XCTAssertEqual(splashImage?.original as Data?, splashData)
        
        // Should be 2 images
        Image.deleteAll()
        
        // Should be 0 images
        XCTAssertEqual(Image.getAll()?.count, 0)
    }
    
}
