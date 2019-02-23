# SDLoopingVideoView

[![CI Status](https://img.shields.io/travis/SolsmaHawk/SDFancyTextField.svg?style=flat)](https://travis-ci.org/SolsmaHawk/SDFancyTextField)
[![Version](https://img.shields.io/cocoapods/v/SDFancyTextField.svg?style=flat)](https://cocoapods.org/pods/SDFancyTextField)
[![License](https://img.shields.io/cocoapods/l/SDFancyTextField.svg?style=flat)](https://cocoapods.org/pods/SDFancyTextField)
[![Platform](https://img.shields.io/cocoapods/p/SDFancyTextField.svg?style=flat)](https://cocoapods.org/pods/SDFancyTextField)

![](Screenshots/SDFancyTextField_main_demo.gif)

## Description

SDFancyTextField is a UIView subclass that replicates the functionality of a UITextField with many added features including automated field-validation and unique animations. UITextField has always been a little… plain. With SDFancyTextField you can easily add an interactive textfield in code or using interface builder. Using interface builder, an SDFancyTextField can be placed in your view and entirely customized within IB. In only a couple lines of code you can have the textfield setup to automatically validate and organize textfields into forms that can be validated all at once (all with fancy animations 😎).

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

Swift 4

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
```let loopingVideoView = SDLoopingVideoView.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 200), videoName: "solsmaDev_logo", videoType: "mov")
view.addSubview(loopingVideoView)```

## Author

John Solsma (Solsma Dev Inc.), solsma@me.com, http://SolsmaDev.com

## License

SDFancyTextField is available under the MIT license. See the LICENSE file for more info.
