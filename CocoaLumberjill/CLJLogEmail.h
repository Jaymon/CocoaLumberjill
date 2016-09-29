//  Created by Jay Marcyes on 9/28/16.

@import UIKit;


/**
 if you want to get feedback on if the email sent or not, then the ViewController (VC)
 you pass into the composeEmailUsingController:...to... method can conform to this
 protocol and receive feedback
 */
@protocol CocoaLumberjillEmailDelegate <NSObject>

@optional

/**
 this will fire if the email sent successfully
 */
- (void)emailDidSend;

/**
 this will fire if the email failed

 @param error the reason the email wasn't sent
 */
- (void)emailDidFailWithError:(nonnull NSError *)error;

@end


/**
 handles all the heavy lifting to compile the logs and send an email
 */
@interface CLJLogEmail : NSObject

/**
 The singleton of this class

 @return instancetype of this class
 */
+ (nonnull instancetype)sharedInstance;

/**
 all the email magic happens here, basically you just call this from your event handler
 and pass in the VC you want to handle bringing up the email dialog, that controller
 can optionally conform to the CocoaLumberjillEmailDelegate protocol to get feedback
 on the actual sending

 @param controller the controller that will handle bringing up the email dialog
 @param emails     an array of email addresses
 @param subject    the subject of the email
 @param body       the body of the email, defaults to empty
 */
- (void)composeEmailUsingController:(nonnull UIViewController<CocoaLumberjillEmailDelegate> *)controller toRecipients:(nonnull NSArray *)emails withSubject:(nonnull NSString *)subject andBody:(nullable NSString *)body;

@end
