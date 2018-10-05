import Quick
import Nimble

@testable import SwiftOwl

extension QuickSpec {
    var raises: [String:Bool] { get { return ["exception":true] } }
}

class UITableViewExtensionSpec: QuickSpec {
    override func spec() {
        describe("UITableViewCell") {
            context("defaultReuseIdentifier") {
                it("should be name of the class") {
                    class FancyCell: UITableViewCell {}
                    expect(FancyCell.defaultReuseIdentifier) == "FancyCell"
                }
            }
        }

        describe("UITableView") {
            var tableView: UITableView!

            beforeEach {
                tableView = UITableView()
            }

            context("cell<T>(for indexPath: IndexPath) -> T") {
                context("not registered") {
                    it("should raise exception", flags: raises) {
                        expect {
                            tableView.cell(for: IndexPath(row: 0, section: 0))
                            }.to(raiseException())
                    }
                }

                context("custom class") {
                    class CustomCell: UITableViewCell {
                    }

                    beforeEach {
                        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.defaultReuseIdentifier)
                    }

                    it("should return instance of") {
                        let cell: CustomCell = tableView.cell(for: IndexPath(row: 0, section: 0))
                        expect(cell.reuseIdentifier) == CustomCell.defaultReuseIdentifier
                    }
                }
            }
        }
    }
}
