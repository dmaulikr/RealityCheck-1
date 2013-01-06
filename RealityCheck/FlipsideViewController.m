//
//  FlipsideViewController.m
//  RealityCheck
//
//  Created by Vladislav Korotnev on 1/6/13.
//  Copyright (c) 2013 Vladislav Korotnev. All rights reserved.
//

#import "FlipsideViewController.h"

@interface FlipsideViewController ()

@end

@implementation FlipsideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.scroller.contentSize = CGSizeMake(self.whatIsThat.frame.size.width, self.whatIsThat.frame.size.height);
    [self.scroller addSubview:self.whatIsThat    ];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (void)dealloc {
    [_whatIsThat release];
    [_scroller release];
    [super dealloc];
}
@end
