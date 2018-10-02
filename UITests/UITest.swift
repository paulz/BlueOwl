import XCTest

class UITest: XCTestCase {

    let app = XCUIApplication()
    var tabBarsQuery: XCUIElementQuery!

    override func setUp() {
        continueAfterFailure = false
        tabBarsQuery = app.tabBars
        app.launch()
    }

    func testNearMeShouldListExistingChallanges() {
        XCTAssert(app.state == .runningForeground, "app should be running")

        tabBarsQuery.buttons["Near Me"].tap()
        XCTAssert(app.staticTexts["Many a developer has slept all night on the streets surrounding this three-level exhibition hall."].exists,
                  "This hint should be visible in the list")
    }
}
