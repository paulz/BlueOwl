//
//  BlueOwlUITests.swift
//  BlueOwlUITests
//
//  Created by Paul Zabelin on 9/27/18.
//  Copyright © 2018 Paul Zabelin. All rights reserved.
//

import XCTest

class UITest: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    func testLaunching() {
        XCTAssert(app.state == .runningForeground, "app should be running")
    }
}
