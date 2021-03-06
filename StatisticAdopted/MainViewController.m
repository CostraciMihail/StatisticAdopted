//
//  ViewController.m
//  StatisticAdopted
//
//  Created by winify on 7/8/16.
//  Copyright © 2016 winify. All rights reserved.
//

#import "MainViewController.h"
#import "STAUserConnector.h"
#import "STACurrentTimeDTO.h"
#import "STAStatisticConnector.h"

@interface MainViewController ()
{
    STAUserConnector *userConnector;
    STAStatisticConnector *statisticConnector;
    BOOL isTimeStarted;
    
    int counter;
    int hours;
    int minutes;
    int seconds;
    
}
@end

@implementation MainViewController

#pragma mark - View Cycle
#pragma mark -

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.title = @"Time";
    isTimeStarted = NO;
    
    self.startStopButton.layer.cornerRadius = 10;
    [self changeTitleButtonForTimeStarted:NO];
    
    UIBarButtonItem *logOutItem = [[UIBarButtonItem alloc] initWithTitle:@"Log Out"
                                                                  style:UIBarButtonItemStyleBordered
                                                                 target:self
                                                                 action:@selector(logOut)];
    
    UIBarButtonItem *updateItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                target:self
                                                                                action:@selector(getStatisticInfo)];
    
    [self.navigationItem setLeftBarButtonItem:logOutItem animated:YES];
    [self.navigationItem setRightBarButtonItem:updateItem animated:YES];
    
    userConnector = [STAUserConnector new];
    statisticConnector = [STAStatisticConnector new];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear: animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(autoLogOut)
                                                 name:@"UNAUTHORIZED"
                                               object:nil];
    [self getStatisticInfo];

}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear: animated];
    [self.timer invalidate];
}


#pragma mark - Actions
#pragma mark -

- (void)logOut {
    
    [self disableUserIteraction];
    
    [userConnector logOutWithSuccessBlock:^(id object) {
        
        [self enableUserIteraction];
        [self.timer invalidate];
        [self showAlertViewWithTitle:@"Log Out" andMessage:@"Success"];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UNAUTHORIZED" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
        
        
    } failBlock:^(NSError *error) {
        
        [self enableUserIteraction];
    }];
    
}

- (IBAction)startStopButtonTouched:(id)sender {
    
    if (isTimeStarted) {
        [self stopTime];
    }
    else [self startTime];
    
}

#pragma mark - Requests
#pragma mark -

- (void)startTime {
    
    [self disableUserIteraction];
    
    [userConnector startTime:@{@"token" : user.token}
                successBlock:^(id object) {
                    
                    [self enableUserIteraction];
                    
                    isTimeStarted = YES;
                    [self startTimer];
                    [self changeTitleButtonForTimeStarted:YES];
                  
                    
                } failBlock:^(NSError *error) {
                       
                    [self enableUserIteraction];
                       
                   }];
    
}

- (void)stopTime {
    
    [self disableUserIteraction];
    
    [userConnector stopTime:@{@"token" : user.token}
               successBlock:^(id object) {
                   
                   [self enableUserIteraction];
                   
                   isTimeStarted = NO;
                   [self.timer invalidate];
                   [self changeTitleButtonForTimeStarted:NO];
                   
               }
                failBlock:^(id object) {
                   
                    [self enableUserIteraction];
                 }];
    
}

- (void)getStatisticInfo {
    
    [self disableUserIteraction];
    
    [statisticConnector getStatisticInfo:@{@"username" : user.userName}
                            successBlock:^(NSDictionary *object) {
                                
                                [self enableUserIteraction];
                                
                                user.currentTime = [[STACurrentTimeDTO alloc] initWithJSONdict:object];
                                self.timeLabel.text = user.currentTime.timeWorked;
                                
                                if (user.currentTime.loggedIn == LOGED_IN_TRUE) {
                                    
                                    isTimeStarted = YES;
                                    [self.timer invalidate];
                                    [self startTimer];
                                    [self changeTitleButtonForTimeStarted:YES];
                                }
                                if (user.currentTime.loggedIn == LOGED_IN_FALSE) {
                                    
                                    isTimeStarted = NO;
                                    [self.timer invalidate];
                                    [self changeTitleButtonForTimeStarted:NO];
                                }
                                
                            } failBlock:^(NSError *error) {
                                
                                   [self enableUserIteraction];
                               }];
    
}

- (void)autoLogOut {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You will be signed out"
                                                    message:@"Your session doesn't longer exist. For security reason you will be signout."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Time
#pragma mark -

- (void)startTimer {
    
    [self setHourMinuteSecondFromTimeWorked];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(updateTime)
                                           userInfo:nil
                                            repeats:true];
    [self.timer fire];
}

- (void)setHourMinuteSecondFromTimeWorked {
    
    NSDateFormatter *timeFormatter = [NSDateFormatter new];
    timeFormatter.calendar = [NSCalendar currentCalendar];
    timeFormatter.timeZone = [NSTimeZone localTimeZone];
    timeFormatter.timeStyle = NSDateFormatterMediumStyle;
    timeFormatter.dateFormat = @"hh : mm : ss";
    NSDate *date = [timeFormatter dateFromString:user.currentTime.timeWorked];
    
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond)
                                                                   fromDate:date];
    
    hours = (int)components.hour;
    minutes = (int)components.minute;
    seconds = (int)components.second;
    
}

- (void)updateTime {
    
    seconds += 1;
    
    if (seconds >= 60) {
        minutes += 1;
        seconds = 0;
    }
    
    if (minutes >= 60) {
        hours += 1;
        minutes = 0;
    }
    
    self.timeLabel.text = [NSString stringWithFormat:@"%02d : %02d : %02d", hours, minutes, seconds];
}

- (void)changeTitleButtonForTimeStarted:(BOOL)isStarted {
    
    if  (isStarted) {
        
        isTimeStarted = isStarted;
        [self.startStopButton setTitle:@"Stop Time" forState:UIControlStateNormal];
         self.startStopButton.backgroundColor = [UIColor redColor];
        
    } else {
        
        isTimeStarted = isStarted;
        [self.startStopButton setTitle:@"Start Time" forState:UIControlStateNormal];
        self.startStopButton.backgroundColor = [UIColor greenColor];
    }
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
