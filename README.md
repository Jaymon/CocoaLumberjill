# CocoaLumberjill

Wraps CocoaLumberjack to format logging and make it easy to send logs via email, among other things.


## Configure the logs

```objective-c
#import "CocoaLumberjill.h"

// ...

[CocoaLumberjill configureWithLogLevel:@"all"]; // you can also use @"info", @"debug", etc.
```

You can change this at anytime and the logs from then on will obey the new rule, so, for example, you could have it usually be set to **warn** but if you see something wrong you could wire up a three finger long press or something that would change the log level to **verbose**.

Then, you use the CocoaLumberjack commands just like always, so something like:

```objective-c
DDLogDebug(@"This is the log message");
```

Will result in a log message like:

    [D|MM-DD-YY HH:MM:SS:SSS] This is the log message [FILE:LINE]



## Email the logs

```objective-c
#import "CocoaLumberjill.h"

@interface SomeViewController () <CocoaLumberjillEmailDelegate>
@end

@implementation ViewController

- (IBAction)handleSomeEvent:(id)sender
{
    NSString *subject = @"These are the logs";
    [[CocoaLumberjill emailInstance] composeEmailUsingController:self
                                                    toRecipients:@[@"email@example.com"]
                                                     withSubject:subject
                                                         andBody:@""];
}

@end
```


## Installation

Use [Cocoapods](https://cocoapods.org/). To install it, simply add the following line to your Podfile:

```ruby
pod "CocoaLumberjill"
```

or, to get the latest and greatest:

```ruby
pod 'CocoaLumberjill', :git => 'https://github.com/Jaymon/CocoaLumberjill', :branch => 'master'
```


## License

Available under the BSD license (matching [CocoaLumberjack](https://github.com/CocoaLumberjack/CocoaLumberjack)). See the LICENSE file for more info.

