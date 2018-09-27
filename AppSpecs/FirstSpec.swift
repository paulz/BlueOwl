import Quick
import Nimble

class FirstSpec: QuickSpec {
    override func spec() {
        describe("Unit Testing frameworks") {
            context("Quick and Nimble") {
                it("should pass test expectations") {
                    expect(1 + 1) == 2
                }
            }
        }
    }
}
