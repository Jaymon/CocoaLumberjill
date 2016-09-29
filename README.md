# CocoaLumberJill

Wraps CocoaLumberJack to format logging and make it easy to send logs via email, among other things.


## Configure the logs

```objective-c
#import "CocoaLumberjill.h"

// ...

[CocoaLumberjill configureWithLogLevel:@"all"]; // you can also use @"info", @"debug", etc.
```


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


## License

Available under the BSD license (matching [CocoaLumberjack](https://github.com/CocoaLumberjack/CocoaLumberjack)). See the LICENSE file for more info.

