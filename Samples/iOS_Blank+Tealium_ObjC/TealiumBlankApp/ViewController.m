//
//  ViewController.m
//  TealiumBlankApp
//
//  Created by Jason Koo on 11/8/15.
//  Copyright © 2015 Tealium. All rights reserved.
//

#import "ViewController.h"
#import "TealiumHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.


}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [TealiumHelper trackViewWithTitle:self.title dataSources:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
