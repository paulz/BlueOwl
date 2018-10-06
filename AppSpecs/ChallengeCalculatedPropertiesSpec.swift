import Quick
import Nimble
import CoreData
import SwinjectStoryboard
@testable import BlueOwl

class ChallengeCalculatedPropertiesSpec: QuickSpec {
    override func spec() {
        describe("Challenge") {
            let container = SwinjectStoryboard.defaultContainer
            var moc: NSManagedObjectContext!

            beforeEach {
                moc = container.resolve(NSManagedObjectContext.self)
            }

            afterEach {
                moc.rollback()
            }

            context("photoFilePath") {
                it("should be a path to image within iSpyPhotos folder") {
                    let challenge = Challenge(context: moc)
                    challenge.photoHref = "horse"
                    expect(challenge.photoFilePath).to(endWith("/Library/Application Support/iSpyPhotos/horse.jpg"))
                }
            }

            context("average rating") {
                it("should be 0 when there are no ratings with stars") {
                    let challenge = Challenge(context: moc)
                    expect(challenge.averageRoundedRating()) == 0

                    challenge.addToRatings(Rating(context: moc))
                    expect(challenge.averageRoundedRating()) == 0
                }

                it("should be 3 for ratings with 1, 2 and 5 stars") {
                    let challenge = Challenge(context: moc)

                    [1, 2, 5].forEach { stars in
                        let rating = Rating(context: moc)
                        rating.stars = NSNumber(integerLiteral: stars)
                        challenge.addToRatings(rating)
                    }

                    expect(challenge.averageRoundedRating()) == 3
                }
                
                it("should be 1 for ratings 1") {
                    let challenge = Challenge(context: moc)
                    let rating = Rating(context: moc)
                    rating.stars = 1

                    challenge.addToRatings(rating)

                    expect(challenge.averageRoundedRating()) == 1
                }
            }
        }
    }
}
