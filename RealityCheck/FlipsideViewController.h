//
//  FlipsideViewController.h
//  RealityCheck
//
//  Created by Vladislav Korotnev on 1/6/13.
//  Copyright (c) 2013 Vladislav Korotnev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController

@property (assign, nonatomic) id <FlipsideViewControllerDelegate> delegate;
@property (retain, nonatomic) IBOutlet UIView *whatIsThat;

@property (retain, nonatomic) IBOutlet UIScrollView *scroller;
- (IBAction)done:(id)sender;

@end
