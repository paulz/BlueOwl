import Quick
import Nimble
import CoreData
import SwinjectStoryboard
@testable import BlueOwl

class DataModelSpec: QuickSpec {
    override func spec() {
        describe("Core Data Model") {
            let container = SwinjectStoryboard.defaultContainer
            var moc: NSManagedObjectContext!

            beforeEach {
                moc = container.resolve(NSManagedObjectContext.self)
            }

            afterEach {
                moc.rollback()
            }

            context("Entities") {
                it("should be user, challenges, match and rating") {
                    let names = moc.persistentStoreCoordinator?.managedObjectModel.entitiesByName.keys.map {$0}
                    expect(names).to(contain(["User", "Challenge", "Match", "Rating"]))
                }

                context("Match and Rating") {
                    it("should load all matches") {
                        let request: NSFetchRequest<Match> = Match.fetchRequest()
                        let matches = try! moc.fetch(request)
                        expect(matches.count) == 10
                    }

                    it("should load all ratings") {
                        let request: NSFetchRequest<Rating> = Rating.fetchRequest()
                        let ratings = try! moc.fetch(request)
                        expect(ratings.count) == 24
                    }
                }
            }
            context("User") {
                var user: User!

                beforeEach {
                    user = User(context: moc)
                }

                context("email") {
                    it("should allow valid emails") {
                        user.email = "user@example.com"
                        user.username = "bob"
                        user.avatarLargeHref = "https://randomuser.me/api/portraits/men/91.jpg"
                        user.avatarMediumHref = "https://randomuser.me/api/portraits/med/men/91.jpg"
                        user.avatarThumbnailHref = "https://randomuser.me/api/portraits/thumb/men/91.jpg"
                        try! moc.save()
                        expect(user.email) == "user@example.com"
                        expect(moc.hasChanges) == false
                    }

                    it("should raise validation errors when there are missing fields") {
                        let expected = CocoaError.error(.validationMultipleErrors) as NSError
                        user.email = "@"
                        expect {
                            try user.managedObjectContext?.save()
                            }.to(throwError{ (e:NSError) in
                                expect(e.domain) == expected.domain
                                expect(e.code) == expected.code
                            })
                    }
                }

                context("fetchRequest") {
                    it("should load all users") {
                        let request: NSFetchRequest<User> = User.fetchRequest()
                        let users = try! moc.fetch(request)
                        expect(users.count) >= 1
                    }
                }

                context("Challenge") {
                    it("should have no challenges initially") {
                        let challenges = user.challenges!
                        expect(challenges.count) == 0
                    }

                    context("addToChallenges") {
                        it("should make user a creator, clearing creator removes challange") {
                            let challange = Challenge(context: moc)
                            user.addToChallenges(challange)
                            expect(user.challenges!.count) == 1
                            expect(challange.creator) == user
                            challange.creator = nil
                            expect(user.challenges!.count) == 0
                        }
                    }

                    context("fetchRequest") {
                        it("should find all challenges") {
                            let request: NSFetchRequest<Challenge> = Challenge.fetchRequest()
                            let beforeAdding = try! moc.fetch(request)
                            expect(beforeAdding.count) == 6

                            let created = Challenge(context: moc)
                            expect(created).notTo(beNil())

                            let afterAdding = try! moc.fetch(request)
                            expect(afterAdding.count) == 7
                        }
                    }
                }
            }
        }
    }
}
