//
//  MainViewController.m
//  RealityCheck
//
//  Created by Vladislav Korotnev on 1/6/13.
//  Copyright (c) 2013 Vladislav Korotnev. All rights reserved.
//

#import "MainViewController.h"
#import "AudioMaster.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    self.youreNot.text = [self rndnotSleeping];
    [super viewWillAppear:animated];
}
#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) scheduleNotificationForDate: (NSDate*)date {
    
    /* Here we cancel all previously scheduled notifications */
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    localNotification.fireDate = date;
    NSLog(@"date %@",date);
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.alertBody = [self rndRecheck];
    localNotification.alertAction = NSLocalizedString(@"Open app", nil);
    
    /* Here we set notification sound and badge on the app's icon "-1"
     means that number indicator on the badge will be decreased by one
     - so there will be no badge on the icon */
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"snd"]isEqualToString:@""]) {
        localNotification.soundName = UILocalNotificationDefaultSoundName;
    } else {
        localNotification.soundName = [[NSUserDefaults standardUserDefaults]objectForKey:@"snd"];
    }
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"snd"]isEqualToString:@"Random"]) {
        localNotification.soundName = [self rndSnd];
    }
    
    localNotification.applicationIconBadgeNumber = -1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

- (IBAction)showInfo:(id)sender
{    
    FlipsideViewController *controller = [[[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil] autorelease];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
}

- (NSString*)rndSnd {
    NSString* res=@"";
    NSFileManager * fm = [NSFileManager defaultManager];
    NSMutableArray * ar = [NSMutableArray new];
    for (NSString*sound in [fm contentsOfDirectoryAtPath:[[NSBundle mainBundle]bundlePath] error:nil]) {
        if([sound hasSuffix:@".wav"] || [sound hasSuffix:@".aif"]){
            [ar addObject:sound];
        }
    }
    res = [ar objectAtIndex:(arc4random()% (ar.count - 1))];
    return  res;
}

- (NSString*)rndnotSleeping {
    NSString * res = @"";
    res = [[[NSArray alloc]initWithObjects:@"You are NOT sleeping",@"You're not asleep yet",@"You're still in the reality",@"No, you're not asleep", nil]objectAtIndex:(arc4random() % 3)];
    return res;
}

- (NSString*)rndRecheck {
    NSString * res = @"";
    res = [[[NSArray alloc]initWithObjects:@"Don't ignore the reality check",@"You're in the reality. Open the app.",@"You're still in the reality, now open the app",@"Reality check - do not ignore!", nil]objectAtIndex:(arc4random() % 3)];
    return res;
}

- (IBAction)selInterval:(id)sender {
    [[[UIActionSheet alloc]initWithTitle:@"Interval" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"1",@"15",@"30",@"45",@"60", nil]showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([actionSheet.title isEqualToString:@"Sound"] && (buttonIndex != actionSheet.cancelButtonIndex))
    {
        [[NSUserDefaults standardUserDefaults]setObject:[actionSheet buttonTitleAtIndex:buttonIndex+1] forKey:@"snd"];
        NSLog(@"%@",[actionSheet buttonTitleAtIndex:buttonIndex+1] );
        if (![[actionSheet buttonTitleAtIndex:buttonIndex+1]isEqualToString:@"Random"]) {
            [[[SoundCtrl alloc]init]playAlertSoundAtPath:[NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle]bundlePath],[actionSheet buttonTitleAtIndex:buttonIndex+1]]];
        }
    }
    if ([actionSheet.title isEqualToString:@"Interval"] && (buttonIndex != actionSheet.cancelButtonIndex))
    {
        [[NSUserDefaults standardUserDefaults]setObject:[actionSheet buttonTitleAtIndex:buttonIndex] forKey:@"itvl"];
        [[UIApplication sharedApplication]cancelAllLocalNotifications];
        int remain = [[[NSUserDefaults standardUserDefaults]objectForKey:@"itvl"]intValue];
        
        [self scheduleNotificationForDate:[NSDate dateWithTimeIntervalSinceNow:(remain*60)]];
    }

}

- (IBAction)selSound:(id)sender {
    UIActionSheet * act = [[UIActionSheet alloc]initWithTitle:@"Sound" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:nil];

    NSFileManager * fm = [NSFileManager defaultManager];
    for (NSString*sound in [fm contentsOfDirectoryAtPath:[[NSBundle mainBundle]bundlePath] error:nil]) {
        if([sound hasSuffix:@".wav"] || [sound hasSuffix:@".aif"]){
            [act addButtonWithTitle:sound];
        }
    }
    [act addButtonWithTitle:@"Random"];
    [act showInView:self.view];
}

- (void)dealloc {
    [_youreNot release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setYoureNot:nil];
    [super viewDidUnload];
}
@end
