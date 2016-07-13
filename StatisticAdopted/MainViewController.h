//
//  ViewController.h
//  StatisticAdopted
//
//  Created by winify on 7/8/16.
//  Copyright © 2016 winify. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STABaseViewController.h"

@interface MainViewController : STABaseViewController

@property (weak, nonatomic) IBOutlet UIButton *logOutButton;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *startStopButton;
@property (strong, nonatomic) NSTimer *timer;

- (void)getStatisticInfo;

@end

