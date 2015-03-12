ENML-Converter [![Build Status](https://travis-ci.org/jcccn/ENML-Converter.png)](https://travis-ci.org/jcccn/ENML-Converter)
======

ENML-Converter is an iOS library to convert html to/from ENML, Evernote's XHTML format.


## Installation with CocoaPods
[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like AFNetworking in your projects.

To install ENML-Converter with CocoaPods, the private CocoaPods repo [jcccn](https://github.com/jcccn/PodSpecs.git) must be configured.

For example, an available Podfile could be like this:

```ruby
# The front repo is prior if conflicted
# [REQUIRED]CocoaPods private repo
source 'https://github.com/jcccn/PodSpecs.git'
# CocoaPods master repo
source 'https://github.com/CocoaPods/Specs.git'

platform :ios,'5.1.1'

# ignore all warnings from all pods
inhibit_all_warnings!

pod 'ENML-Converter'

```

## Usage
After importing the header file with `#import "EnmlConverter.h"` or `#import <ENML-Converter/EnmlConverter.h>`, use the lib like this:

```objective-c
    NSString *html = ...;
    NSString *enml = [[EnmlConverter sharedInstance] convertToENML:html];
```

## Contact

- [Jiang Chuncheng](https://github.com/jcccn) ([@蒋春成](http://weibo.com/jcccn))

## License

ENML-Converter is available under the MIT license. See the LICENSE file for more info.