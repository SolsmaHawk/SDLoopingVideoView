# SDLoopingVideoView

[![CI Status](https://img.shields.io/travis/SolsmaHawk/SDFancyTextField.svg?style=flat)](https://travis-ci.org/SolsmaHawk/SDFancyTextField)
[![Version](https://img.shields.io/cocoapods/v/SDFancyTextField.svg?style=flat)](https://cocoapods.org/pods/SDFancyTextField)
[![License](https://img.shields.io/cocoapods/l/SDFancyTextField.svg?style=flat)](https://cocoapods.org/pods/SDFancyTextField)
[![Platform](https://img.shields.io/cocoapods/p/SDFancyTextField.svg?style=flat)](https://cocoapods.org/pods/SDFancyTextField)

![](Screenshots/SDFancyTextField_main_demo.gif)

## Description

SDLoopingVideoView is a looping video-view based off of AVPlayerLayer; it works great when used as a video background (see below for list of apps using SDLoopingVideoView). SDLoopingVideoView automatically scales any video  displayed to aspect-fill the view you define; scaling can be set manually as well. SDLoopingVideoView responds to any UIView animations and scales accordingly without interuption of the video playing.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

Swift 4.2

## Installation

SDLoopingVideoView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SDLoopingVideoView'
```

## How to use

### Interface Builder
![](Screenshots/SDFancyTextField_example1.png)
The easiest way to create a ```SDLoopingVideoView``` is to drag and drop a ```UIView``` in interface builder and set its class to ```SDLoopingVideoView```. Then, under the attributes inspector tab, set the ```videoName``` property to the name of your video file and set the ```videoType``` property to the extension of your video file.

### Programatically
You can also initialize an SDLoopingVideoView by declaring it in code:
```
let loopingVideoView = SDLoopingVideoView.init(frame: 
CGRect.init(x: 0, y: 0, width: 200, height: 200), 
videoName: "your_video_name", 
videoType: "mp4")
view.addSubview(loopingVideoView)
```
Simple!

## Author

John Solsma (Solsma Dev Inc.), solsma@me.com, http://SolsmaDev.com

## Apps using SDLoopingVideoView
If you're using SDLoopingVideoView in a public app, email me and I will add it to the list!
## License

SDLoopingVideoView is available under the MIT license. See the LICENSE file for more info.
