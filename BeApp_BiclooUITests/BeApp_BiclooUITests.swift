//
//  BeApp_BiclooUITests.swift
//  BeApp_BiclooUITests
//
//  Created by RICHEUX Antoine on 04/06/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import XCTest

class BeApp_BiclooUITests: XCTestCase {
    
    var app: XCUIApplication!
    var bikeStationTable: XCUIElement?
    
    override func setUp() {
        super.setUp()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
        bikeStationTable = app.tables["bikeStationTable"]
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSearchPage() {
        if let tableView = bikeStationTable {
            tableView.buttons["OUVERTES"].tap()
            sleep(1)
            tableView.buttons["FERMEES"].tap()
            sleep(1)
            tableView.buttons["TOUTES"].tap()
            // Pull to refresh
            let firstCell = tableView.cells.element(boundBy: 1)
            let start = firstCell.coordinate(withNormalizedOffset: CGVector(dx:0, dy:0))
            let finish = firstCell.coordinate(withNormalizedOffset: CGVector(dx:0, dy:6))
            start.press(forDuration: 0, thenDragTo: finish)
            sleep(2)
            tableView.searchFields.element.tap()
            let searchField = tableView.searchFields.element
            searchField.typeText("PLACE RIC")
            XCTAssertTrue(tableView.staticTexts["00038-PLACE RICORDEAU"].exists)
            tableView.cells.element(boundBy: 1).tap()
            sleep(2)
            XCTAssert(app.navigationBars["Détail station"].exists)
            XCTAssertTrue(app.staticTexts["00038-PLACE RICORDEAU"].exists)
            XCTAssertTrue(app.staticTexts["place ricordeau"].exists)
            XCTAssertTrue(app.staticTexts["Guichet disponible"].exists)
            app.buttons["Localiser avec Plans"].tap()
        }
    }
    
}
