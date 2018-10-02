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
