import Quick
import Nimble
import CoreData
@testable import BlueOwl

class DataModelSpec: QuickSpec {
    override func spec() {
        describe("Core Data Model") {
            let store = DataStore()
            var objectContext: NSManagedObjectContext!

            beforeEach {
                objectContext = store.openExistingDatabase()!
            }

            afterEach {
                objectContext.rollback()
            }

            context("Entities") {
                it("should be user and challanges") {
                    let names = objectContext.persistentStoreCoordinator?.managedObjectModel.entitiesByName.keys.map {$0}
                    expect(names) == ["User", "Challange"]
                }
            }
            context("User") {
                var user: User!

                beforeEach {
                    user = User(context: objectContext)
                }

                context("email") {
                    it("should allow valid emails") {
                        user.email = "user@example.com"
                        try! objectContext.save()
                        expect(user.email) == "user@example.com"
                        expect(objectContext.hasChanges) == false
                    }

                    it("should not allow too short strings") {
                        let expected = CocoaError.error(.validationStringTooShort) as NSError
                        user.email = "@"
                        expect {
                            try user.managedObjectContext?.save()
                            }.to(throwError{ (e:NSError) in
                                expect(e.domain) == expected.domain
                                expect(e.code) == expected.code
                                expect(e.userInfo["NSValidationErrorKey"] as? String) == "email"
                                expect(e.userInfo["NSValidationErrorValue"] as? String) == "@"
                                expect(e.userInfo["NSValidationErrorObject"] as? NSManagedObject) == user
                            })
                    }

                    it("should not allow too long strings") {
                        user.email = String(repeating: "a@b", count: 1000)
                        expect {
                            try user.managedObjectContext?.save()
                            }.to(throwError { (e: NSError) in
                                expect(e.code) == CocoaError.validationStringTooLong.rawValue
                            })
                    }
                }

                context("fetchRequest") {
                    it("should load all users") {
                        let request: NSFetchRequest<User> = User.fetchRequest()
                        let users = try! objectContext.fetch(request)
                        expect(users.count) >= 1
                    }
                }

                context("Challange") {
                    it("should have no challanges initially") {
                        let challanges = user.challanges!
                        expect(challanges.count) == 0
                    }

                    context("addToChallanges") {
                        it("should make user a creator, clearing creator removes challange") {
                            let challange = Challange(context: objectContext)
                            user.addToChallanges(challange)
                            expect(user.challanges!.count) == 1
                            expect(challange.creator) == user
                            challange.creator = nil
                            expect(user.challanges!.count) == 0
                        }
                    }

                    context("fetchRequest") {
                        it("should find all challanges") {
                            let request: NSFetchRequest<Challange> = Challange.fetchRequest()
                            let beforeAdding = try! objectContext.fetch(request)
                            expect(beforeAdding.count) == 0

                            let created = Challange(context: objectContext)
                            expect(created).notTo(beNil())

                            let afterAdding = try! objectContext.fetch(request)
                            expect(afterAdding.count) == 1
                        }
                    }
                }
            }
        }
    }
}
