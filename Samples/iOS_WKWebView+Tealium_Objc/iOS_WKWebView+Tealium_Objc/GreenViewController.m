//
//  GreenViewController.m
//  iOS_WKWebView+Tealium_Objc
//
//  Created by Jonathan Wong on 4/1/19.
//  Copyright © 2019 Jonathan Wong. All rights reserved.
//

#import "GreenViewController.h"
#import "TealiumHelper.h"

@interface GreenViewController ()

@end

@implementation GreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if ([[TealiumHelper sharedInstance] initNeeded]) {
        [TealiumHelper stopTracking];
        [TealiumHelper startTrackingWithView:self.view];
        [[TealiumHelper sharedInstance] setInitNeeded:NO];
    }
    
    [TealiumHelper trackView:@"BlueViewController"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)trackEvent:(id)sender {
    [TealiumHelper trackEvent:@"green_button_pressed"];
}

@end
