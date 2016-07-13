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
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.title = @"Time";
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
    
    
    
}

- (void)getStatisticInfo {
    
    
    
    [statisticConnector getStatisticInfo:@{@"username" : user.userName}
                            successBlock:^(NSDictionary *object) {
                                
                                user.currentTime = [[STACurrentTimeDTO alloc] initWithJSONdict:object];
                                
                                NSLog(@"%@", user.currentTime.timeWorked);
                                
                            }
                               failBlock:^(NSError *error) {
                                
                                   [self showAlertViewWithTitle:@"Error" andMessage:error.localizedDescription];
                               }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
