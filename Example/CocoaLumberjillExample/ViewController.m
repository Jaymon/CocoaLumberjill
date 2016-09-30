//
//  ViewController.m
//  CocoaLumberjillExample
//
//  Created by Jay Marcyes on 9/28/16.
//  Copyright © 2016 CLJ. All rights reserved.
//

#import "ViewController.h"
#import "CocoaLumberjill.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DDLogDebug(@"This is the log message");
    
    // Do any additional setup after loading the view, typically from a nib.
    DDLogMethod();
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
