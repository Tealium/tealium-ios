//
//  ViewController.m
//  iOS_WKWebView+Tealium_Objc
//
//  Created by Jonathan Wong on 4/1/19.
//  Copyright © 2019 Jonathan Wong. All rights reserved.
//

#import "BlueViewController.h"
#import "TealiumHelper.h"
#import "GreenViewController.h"

@interface BlueViewController ()

@end

@implementation BlueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [TealiumHelper trackView:@"BlueViewController"];
}

- (IBAction)onPush:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GreenViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"GreenViewController"];
    [self.navigationController showViewController:viewController sender:nil];
}

- (IBAction)trackEvent:(id)sender {
    [TealiumHelper trackEvent:@"blue_button_pressed"];
}

@end
