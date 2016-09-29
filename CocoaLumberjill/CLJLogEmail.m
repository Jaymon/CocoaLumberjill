//  Created by Jay Marcyes on 9/28/16.

@import MessageUI;
#import "CLJLogEmail.h"
#import <CocoaLumberjack/CocoaLumberjack.h>


@interface CLJLogEmail() <MFMailComposeViewControllerDelegate>

/**
 the controller that will be used to present the email VC and dismiss it
 */
@property (nonatomic, weak, nullable) UIViewController<CocoaLumberjillEmailDelegate> *controller;

@end


@implementation CLJLogEmail

+ (instancetype)sharedInstance {
    
    static CLJLogEmail *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [CLJLogEmail new];
    });
    
    return instance;
}

- (void)composeEmailUsingController:(UIViewController<CocoaLumberjillEmailDelegate> *)controller toRecipients:(NSArray *)emails withSubject:(NSString *)subject andBody:(NSString *)body
{
    // https://developer.apple.com/library/ios/documentation/MessageUI/Reference/MFMailComposeViewController_class/
    // http://www.codingexplorer.com/mfmailcomposeviewcontroller-send-email-in-your-apps/
    
    if ([MFMailComposeViewController canSendMail]) {
        
        self.controller = controller;
        
        MFMailComposeViewController *mailViewController = [MFMailComposeViewController new];
        mailViewController.mailComposeDelegate = self;
        NSMutableData *errorLogData = [NSMutableData data];
        for (NSData *errorLogFileData in [self errorLogData]) {
            [errorLogData appendData:errorLogFileData];
        }
        [mailViewController addAttachmentData:errorLogData mimeType:@"text/plain" fileName:@"errorLog.txt"];
        
        NSDateFormatter *DateFormatter=[NSDateFormatter new];
        [DateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *fullSubject = [NSString stringWithFormat:@"%@ [%@]", subject, [DateFormatter stringFromDate:[NSDate date]]];
        
        [mailViewController setToRecipients:emails];
        [mailViewController setSubject:fullSubject];
        [mailViewController setMessageBody:body isHTML:NO];
        
        ///[self.navigationController pushViewController:mailViewController animated:YES];
        [self.controller presentViewController:mailViewController animated:YES completion:nil];
        
    } else {
        // iOS <8
        ///NSString *message = @"This device cannot send email :( Mail.app not configured?";
        ///[[[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        
        // iOS 8+
        UIAlertController * alert= [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Cannot Sent email", @"")
                                                                       message:NSLocalizedString(@"Maybe your Mail.app is not configured?", @"")
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"")
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                   }];
        
        [alert addAction:ok];
        [controller presentViewController:alert animated:YES completion:nil];
        
    }
}


// #############################################################################
#pragma mark email support methods
// #############################################################################

//- (NSString *)environmentDetailsHeader {
//    
//    id<UIApplicationDelegate> appDelegate = [[UIApplication sharedApplication] delegate];
//    
//    return [NSString stringWithFormat:@"Device: %@ (%@)\nBuild version: %@\nBuild number: %@\nRevision: %@\nMode: %@\n\nEnter any additional details here...\n",
//            ///[[UIDevice currentDevice] platformString],
//            [[UIDevice currentDevice] systemVersion],
//            [appDelegate buildVersion],
//            [appDelegate buildNumber],
//            [appDelegate buildHash]
//            ];
//}

- (NSMutableArray *)errorLogData
{
    // this method and the compose method was inspired by this answer
    // http://stackoverflow.com/a/11544657
    
    DDFileLogger *flogger = nil;
    for (DDAbstractLogger *logger in [DDLog allLoggers]) {
        if ([logger isKindOfClass:[DDFileLogger class]]) {
            
            flogger = (DDFileLogger *)logger;
            break;
            
        }
    }
    
    NSMutableArray *errorLogFiles = [NSMutableArray arrayWithCapacity:flogger.logFileManager.maximumNumberOfLogFiles];
    // http://stackoverflow.com/a/586529
    for (DDLogFileInfo *logFileInfo in [[flogger.logFileManager sortedLogFileInfos] reverseObjectEnumerator]) {
        NSData *fileData = [NSData dataWithContentsOfFile:logFileInfo.filePath];
        [errorLogFiles addObject:fileData];
    }
    
    return errorLogFiles;
}

// #############################################################################
#pragma mark MFMailComposeViewControllerDelegate
// #############################################################################

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultSent:
            //DDLogInfo(@"Email sent");
            break;
            
        case MFMailComposeResultSaved:
            ///DDLogInfo(@"Email draft saved");
            error = [NSError errorWithDomain:MFMailComposeErrorDomain
                                        code:1
                                    userInfo:@{NSLocalizedDescriptionKey:@"Email draft saved"}];
            break;
            
        case MFMailComposeResultCancelled:
            ///DDLogInfo(@"Email sending cancelled");
            error = [NSError errorWithDomain:MFMailComposeErrorDomain
                                        code:2
                                    userInfo:@{NSLocalizedDescriptionKey:@"Email sending cancelled"}];
            break;
            
        case MFMailComposeResultFailed:
            ///DDLogError(@"%@", error.description);
            break;
            
        default:
            ///DDLogError(@"%@", error.description);
            break;
    }
    
    [self.controller dismissViewControllerAnimated:YES completion:nil];
    
    if (error) {
        if ([self.controller respondsToSelector:@selector(emailDidFailWithError:)]) {
            [self.controller emailDidFailWithError:error];
        }
        
    } else {
        if ([self.controller respondsToSelector:@selector(emailDidSend)]) {
            [self.controller emailDidSend];
        }
    }
    
    self.controller = nil;
    ///[self.navigationController popViewControllerAnimated:YES];
}


@end
