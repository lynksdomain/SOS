# SOS

## Overview
Safe On Sex is an iOS app that connects NYC teenagers to nearby affordable HIV testing clinics

## Gifs


|Authenticate With Face ID|
|:-------------:|
|<img src=https://storage.jumpshare.com/preview/3UYwL0XZnQ3EJOH9IWbcGEukD41fiYNeaLUCh2E5fnrK099E_Q6JqZFqbI46Y0XAbFDAv8UwLzNWy8kG_kJd190Iq-_ZMIwlJNqsu6s4bO0F1kR3dMUjedqC16uBUu85.gif>|

## Features
Users can: 
- Search for nearby HIV testing centers
- Narrow search by existing parameters 
- Navigate to selected testing centers using Apple Maps 
- Track sexual health history
- View FAQ's about sexual health

## Requirements
- iOS 8.0+ / Mac OS X 10.11+ / tvOS 9.0+
- Xcode 9.0+
- Swift 4.0+

## Installation

### CocoaPods
CocoaPods is a dependency manager for Cocoa projects. You can install it with the following command:

`$ sudo gem install cocoapods`

### Pods
- [EasyNotificationBadge](https://github.com/Minitour/EasyNotificationBadge)
- [SnapKit](http://snapkit.io/docs)

### How to Install Pods
To integrate these pods into your Xcode project using CocoaPods, specify it in your Podfile:

```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'SnapKit', '~> 4.0.0',
    pod 'EasyNotificationBadge'

end
```

Then, run the following command in Terminal:

`$ pod install`

## Collaborators
- **Project Manager**: Masai Young
- **Tech Lead**: Alan Holguin  
- **Design Lead**: Margaret Chan  
- **Demo Lead**: Ashlee Krammer
