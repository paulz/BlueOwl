import Quick
import Nimble

@testable import SwiftOwl

class ModelSpec: QuickSpec {
    override func spec() {
        describe("Model") {
            context("field") {
                it("should be value") {
                    expect(Model().field) == "value"
                }
            }
        }
    }
}
