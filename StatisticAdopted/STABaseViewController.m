//
//  STABaseViewController.m
//  StatisticAdopted
//
//  Created by winify on 7/12/16.
//  Copyright © 2016 winify. All rights reserved.
//

#import "STABaseViewController.h"

@interface STABaseViewController ()

@end

@implementation STABaseViewController
@synthesize user;


- (void)viewDidLoad {
    [super viewDidLoad];

    self.mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    user = [STAUserDTO shareInstace];
    
}


- (void)showAlertViewWithTitle:(NSString *)title
                    andMessage:(NSString *)message
{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil, nil];
    
    [alertView show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
