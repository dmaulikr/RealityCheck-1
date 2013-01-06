//
//  MainViewController.h
//  RealityCheck
//
//  Created by Vladislav Korotnev on 1/6/13.
//  Copyright (c) 2013 Vladislav Korotnev. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate,UIActionSheetDelegate>
@property (retain, nonatomic) IBOutlet UILabel *youreNot;

- (IBAction)showInfo:(id)sender;
- (IBAction)selInterval:(id)sender;
- (IBAction)selSound:(id)sender;
-(void) scheduleNotificationForDate: (NSDate*)date;
@end
