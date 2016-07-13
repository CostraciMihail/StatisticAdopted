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

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.title = @"Time";
    isTimeStarted = NO;
    [self.startStopButton setTitle:@"Start" forState:UIControlStateNormal];
    userConnector = [STAUserConnector new];
    statisticConnector = [STAStatisticConnector new];
    [self getStatisticInfo];

    
}

- (IBAction)logOutButtonPressed:(id)sender {
 
    [userConnector logOutWithSuccessBlock:^(id object) {
        
        [self showAlertViewWithTitle:@"Log Out" andMessage:@"Success"];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    failBlock:^(NSError *error) {
        
        [self showAlertViewWithTitle:@"Error" andMessage:error.localizedDescription];

    }];
    
}

- (void)logOut {
    
    
}

- (IBAction)startStopButtonTouched:(id)sender {
    
    
    if (isTimeStarted) {
        [self startTime];
    }
    else [self stopTime];
    
}

- (void)startTime {
    
    [userConnector startTime:@{@"token" : user.token}
                successBlock:^(id object) {
                    
                    isTimeStarted = YES;
                    [self changeTitleButtonForTimeStarted:YES];
                    
                }
                   failBlock:^(NSError *error) {
                       
                       
                       
                   }];
    
}

- (void)stopTime {
    
    [userConnector stopTime:@{@"token" : user.token}
               successBlock:^(id object) {
                   
                   isTimeStarted = NO;
                   [self changeTitleButtonForTimeStarted:NO];
                   
               }
                failBlock:^(id object) {
                      
                 }];
    
}

- (void)getStatisticInfo {
    
    [statisticConnector getStatisticInfo:@{@"username" : user.userName}
                            successBlock:^(NSDictionary *object) {
                                
                                user.currentTime = [[STACurrentTimeDTO alloc] initWithJSONdict:object];
                                
                                NSLog(@"%@", user.currentTime.timeWorked);
                                self.timeLabel.text = user.currentTime.timeWorked;
                                
                            }
                               failBlock:^(NSError *error) {
                                
                                   [self showAlertViewWithTitle:@"Error" andMessage:error.localizedDescription];
                               }];
    
}


//MARK: Time
//MARK:
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
    
    hours = components.hour;
    minutes = components.minute;
    seconds = components.second;
    
}

- (void)updateTime {
    
    seconds += 1;
    
    if (seconds >= 60)
    {
        minutes += 1;
        seconds = 0;
    }
    
    if (minutes >= 60)
    {
        hours += 1;
        minutes = 0;
    }
    
    self.timeLabel.text = [NSString stringWithFormat:@"%02d : %02d %02d", hours, minutes, seconds];
}

- (void)changeTitleButtonForTimeStarted:(BOOL)isStarted {
    
    if  (isStarted)
    {
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
