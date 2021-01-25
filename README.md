# Walkabout
Walkabout is an iOS app that fetches photos from Flickr whenever the user walks 100 meters. 
The user is starting the app and presses the start button. After that they put the phone into their pocket and start walking, every 100 meters a picture for their location is requested from the flickr photo search api and added to their stream. New pictures are added on top. Any time they take a look at their phone they see the most recent picture and can scroll through a stream of pictures which show them impressions of where they have been.

## Getting Started

Here are the steps to get started with the project on your local machine:

1. Clone the git repositiory
2. Wait for Xcode to fetch the dependencies. (The dependencies are only for the test target.)
3. If running on the simulator, you can edit the scheme and set the simulated location in Xcode. 
There's a .gpx file with predefined routes called **Bählin.gpx** which could be used to simulate a run between *Berlin RingBahn stations*.
4. Run the project via Xcode.

### Prerequisites

What things you need to install the software and how to install them

1. Mac OS X
2. Xcode
3. Optional: [xcpretty](https://github.com/supermarin/xcpretty)


### Running the tests

The app uses BDD style tests using Quick and Nimble. There are unit tests written to test the LocationManager, APIClient (with Network mocks), and ViewModel behaviors. To run the test, enter the command on the command line.

```
xcodebuild -scheme 'Walkabout' \
    -sdk iphonesimulator \
    -configuration Debug \
    -destination 'platform=iOS Simulator,name=iPhone 11,OS=latest' \
    clean build test | xcpretty
```

The output will be similar to:

```
...
All tests
Test Suite WalkaboutTests.xctest started
ApiClientTests
    ✓ testFlickrRequest (0.064 seconds)
LocationProviderTests
    ✓ Given_a_LocationProvider__When_it_s_started_with_LocationManager__then_starts_location_updates (15.518 seconds)
    ✓ Given_a_LocationProvider__When_it_s_started_with_LocationManager__then_provides_current_location (0.097 seconds)
PhotoStreamViewModelTests
    ✓ Given_a_PhotoStreamViewModelTests__updates_the_photo_stream_for_the_observer (0.001 seconds)
WalkaboutTests
    ✓ Test_for_JSON_Parsing__This_group_tests_the_model_parsing__should_parse_the_data_correctly (0.001 seconds)

     Executed 5 tests, with 0 failures (0 unexpected) in 15.681 (15.688) seconds

2020-09-24 11:18:10.999 xcodebuild[20824:467476] [MT] IDETestOperationsObserverDebug: 21.136 elapsed -- Testing started completed.
2020-09-24 11:18:10.999 xcodebuild[20824:467476] [MT] IDETestOperationsObserverDebug: 0.001 sec, +0.001 sec -- start
2020-09-24 11:18:10.999 xcodebuild[20824:467476] [MT] IDETestOperationsObserverDebug: 21.136 sec, +21.136 sec -- end
▸ Test Succeeded
```


Icons made by [Freepik](https://www.flaticon.com/authors/freepik) from [www.flaticon.com](https://www.flaticon.com/)