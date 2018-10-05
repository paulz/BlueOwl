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
                it("should be 0 when there are no ratings with stars") {
                    let challenge = Challenge(context: objectContext)
                    expect(challenge.averageRoundedRating()) == 0

                    challenge.addToRatings(Rating(context: objectContext))
                    expect(challenge.averageRoundedRating()) == 0
                }

                it("should be 3 for ratings with 1, 2 and 5 stars") {
                    let challenge = Challenge(context: objectContext)

                    [1, 2, 5].forEach { stars in
                        let rating = Rating(context: objectContext)
                        rating.stars = NSNumber(integerLiteral: stars)
                        challenge.addToRatings(rating)
                    }

                    expect(challenge.averageRoundedRating()) == 3
                }
                
                it("should be 1 for ratings 1") {
                    let challenge = Challenge(context: objectContext)
                    let rating = Rating(context: objectContext)
                    rating.stars = 1

                    challenge.addToRatings(rating)

                    expect(challenge.averageRoundedRating()) == 1
                }
            }
        }
    }
}
