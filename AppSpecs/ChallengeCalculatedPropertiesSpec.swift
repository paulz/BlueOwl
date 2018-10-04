import Quick
import Nimble
import CoreData
@testable import BlueOwl

class ChallengeCalculatedPropertiesSpec: QuickSpec {
    override func spec() {
        describe("Challenge") {
            let store = DataStore()
            var objectContext: NSManagedObjectContext!

            beforeEach {
                objectContext = store.openExistingDatabase()!
            }

            afterEach {
                objectContext.rollback()
            }

            context("average rating") {
                it("should be three for ratings 1, 2, 5") {
                    let challenge = Challenge(context: objectContext)
                    let rating1 = Rating(context: objectContext)
                    rating1.stars = 1
                    let rating2 = Rating(context: objectContext)
                    rating2.stars = 2
                    let rating3 = Rating(context: objectContext)
                    rating3.stars = 5

                    challenge.addToRatings(rating1)
                    challenge.addToRatings(rating2)
                    challenge.addToRatings(rating3)

                    expect(challenge.averageRating()) == 3
                }
                
                it("should be 1 for ratings 1") {
                    let challenge = Challenge(context: objectContext)
                    let rating = Rating(context: objectContext)
                    rating.stars = 1

                    challenge.addToRatings(rating)

                    expect(challenge.averageRating()) == 1
                }
            }
        }
    }
}
