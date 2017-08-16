# Coding Changllenge 2
# Description
Display and listing media with categories data from https://pastebin.com/raw/8LiEHfwU

## Wireframes
![Wireframe 1](Wireframes/1.jpg)
![Wireframe 2](Wireframes/2.jpg)

## Feature Requirements
[x] Implement according to the wireframes provided

[x] Single View Controller application

[x] Vertication table views

[x] Child collection views with horizontal orientation

[x] All horizontal rows must scroll independently to each other

[x] Async load data

[x] No third-party code / libries

[x] Programmatic layout (No StoryBoards or xibs)

[x] Use of AutoLayouts for layouts

[x] Include Unit Tests

## Bouns Tasks
[x] Using Swift

[x] Using MVVM over MVC pattern

[x] Clicking on a media element should animate show the detail view controller

[x] Demonstrate the good usage of Protocol Oriented Programming 

[x] Follow a coding style guide (Apple's coding style)

[x] No compiling warnings

[x] No third party library is used

[x] Mobile layout

# To Run
To run the app open it with Xcode 8.3.3. Pleaes change the "Signing" setting to your own team certificate to run the app in an real device.

# Environment
* Devices: iPhone and iPad
* Deploy Target: iOS 9.0 and above
* Xcode Verions: 8.3.3
* Tested Devices: iPhone 6S, iPad Air

# Unit Tests
* tested API call (files: ObjectFetchingTests.swift )
* tested images downloads  (files: CachedImageTests.swift )
* tested local image caches (files: CachedImageTests.swift )
* tested Category, Media item, Images json mapping object (files: ObjectFetchingTests.swift )

# Error Handled
* Internet connection errors
* JSON invalid errors

# Time Logs
* Project started at Tuesday 15th Auguest 11:30 AM

# Limitations / Assumptions
* Invalid JSON data object will result hiding that data object from user. However, an error message will print in the console. This is to avoid showing multiple popup messages to user during multiple JSON errors occurred
* No manaul Accessibility added to UI elements due to the complexity of no storyboard and nib are allowed