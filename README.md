# BlueOwl
[![Build Status](https://travis-ci.org/paulz/BlueOwl.svg?branch=master)](https://travis-ci.org/paulz/BlueOwl)
[![codecov](https://codecov.io/gh/paulz/BlueOwl/branch/master/graph/badge.svg)](https://codecov.io/gh/paulz/BlueOwl)

BlueOwl is https://github.com/BlueOwlDev/iSpyChallenge 100% test covered implementation.

![https://raw.githubusercontent.com/paulz/BlueOwl/master/BlueOwl/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60%403x.png](https://raw.githubusercontent.com/paulz/BlueOwl/master/BlueOwl/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60%403x.png)

# Unit Specs
Test low level code included Dynamic Swift Framework: SwiftOwl
Can not access application bundle resources.

# App Specs
Test application code by loading App as a bundle.
Can access Core Data, UI, Network and bundle resources.

# UI Tests
Xcode User Interface Tests simulating user interactions with the app.
Can not access application memory or state other than through inspecting app output.

## How to run tests
```
xcodebuild test -destination "platform=iOS Simulator,name=iPhone X" -scheme BlueOwl -workspace BlueOwl.xcworkspace | xcpretty
```

## Sample Test Run output

Test output show 3 suites pass within few seconds:
```
All tests

Test Suite UnitSpecs.xctest started
FirstSpec
    ✓ Unit_Testing_frameworks__Quick_and_Nimble__should_pass_test_expectations (0.007 seconds)
ModelSpec
    ✓ Model__field__should_be_value (0.002 seconds)
	 Executed 2 tests, with 0 failures (0 unexpected) in 0.008 (0.016) seconds

Test Suite AppSpecs.xctest started
DataModelSpec
    ✓ Core_Data_Model__Entities__should_be_user__challenges__match_and_rating (0.206 seconds)
    ✓ Core_Data_Model__Entities__Match_and_Rating__should_load_all_matches (0.274 seconds)
    ✓ Core_Data_Model__Entities__Match_and_Rating__should_load_all_ratings (0.206 seconds)
    ✓ Core_Data_Model__User__email__should_allow_valid_emails (0.219 seconds)
    ✓ Core_Data_Model__User__email__should_raise_validation_errors_when_there_are_missing_fields (0.289 seconds)
    ✓ Core_Data_Model__User__fetchRequest__should_load_all_users (0.201 seconds)
    ✓ Core_Data_Model__User__Challenge__should_have_no_challenges_initially (0.199 seconds)
    ✓ Core_Data_Model__User__Challenge__addToChallenges__should_make_user_a_creator__clearing_creator_removes_challange (0.209 seconds)
    ✓ Core_Data_Model__User__Challenge__fetchRequest__should_find_all_challenges (0.195 seconds)
FirstSpec
    ✓ Unit_Testing_frameworks__Quick_and_Nimble__should_pass_test_expectations (0.001 seconds)
	 Executed 10 tests, with 0 failures (0 unexpected) in 1.999 (2.005) seconds

Test Suite UITests.xctest started
UITest
    ✓ testNearMeShouldListExistingChallanges (5.250 seconds)
	 Executed 1 test, with 0 failures (0 unexpected) in 5.250 (5.252) seconds
```
see this output on CI server: https://travis-ci.org/paulz/BlueOwl/builds/436434625#L739
