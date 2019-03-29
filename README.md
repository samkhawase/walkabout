# Walkabout
Walkabout is an iOS app that fetches photos from Flickr whenever the user walks 100 meters. 
The user is starting the app and presses the start button. After that he puts the phone into his pocket and starts walking, every 100 meters a picture for his location is requested from the flickr photo search api and added to his stream. New pictures are added on top.
Any time he takes a look at his phone he sees the most recent picture and can scroll through a stream of pictures which shows him impressions of where he has been.

## Getting Started

Here are the steps to get started with the project on your local machine:

1. Clone the git repositiory
2. Run `carthage update --platform iOS --cache-builds --no-use-binaries` to fetch the dependencies.
3. If running on the simulator, you can edit the scheme and set the simulated location in Xcode. 
There's a .gpx file with predefined routes called **Bählin.gpx** which could be used to simulate a run between *Berlin RingBahn stations*.
4. Run the project via Xcode.

### Prerequisites

What things you need to install the software and how to install them

1. Mac OS X
2. Xcode
3. [Carthage](https://github.com/Carthage/Carthage)
4. Optional: [xcpretty](https://github.com/supermarin/xcpretty)


### Running the tests

The app uses BDD style tests using Quick and Nimble. There are unit tests written to test the LocationManager, APIClient (with Network mocks), and ViewModel behaviors. To run the test, enter the command on the command line.

```
xcodebuild -scheme 'Walkabout' \
    -sdk iphonesimulator \
    -configuration Debug \
    -destination 'platform=iOS Simulator,name=iPhone X,OS=latest' \
    clean build test | xcpretty
```

The output will be similar to:

```
All tests
Quick.framework
Test Suite WalkaboutTests.xctest started
ApiClientTests
    ✓ testFlickrRequest (0.010 seconds)
LocationProviderTests
    ✓ Given_a_LocationProvider__When_it_s_started_with_LocationManager__then_starts_location_updates (0.011 seconds)
    ✓ Given_a_LocationProvider__When_it_s_started_with_LocationManager__then_provides_current_location (0.006 seconds)
PhotoStreamViewModelTests
    ✓ Given_a_PhotoStreamViewModelTests__updates_the_photo_stream_for_the_observer (0.001 seconds)
WalkaboutTests
    ✓ Test_for_JSON_Parsing__This_group_tests_the_model_parsing__should_parse_the_data_correctly (0.001 seconds)


         Executed 5 tests, with 0 failures (0 unexpected) in 0.029 (0.039) seconds

2019-03-29 14:51:56.094 xcodebuild[38284:25040379] [MT] IDETestOperationsObserverDebug: 17.317 elapsed -- Testing started completed.
2019-03-29 14:51:56.094 xcodebuild[38284:25040379] [MT] IDETestOperationsObserverDebug: 0.000 sec, +0.000 sec -- start
2019-03-29 14:51:56.094 xcodebuild[38284:25040379] [MT] IDETestOperationsObserverDebug: 17.317 sec, +17.317 sec -- end
▸ Test Succeeded
```
