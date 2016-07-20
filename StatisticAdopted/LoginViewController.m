//
//  LoginViewController.m
//  StatisticAdopted
//
//  Created by winify on 7/8/16.
//  Copyright © 2016 winify. All rights reserved.
//

#import "LoginViewController.h"
#import "STAUserConnector.h"
#import "MainViewController.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {

    [super viewDidLoad];

    self.title = @"Log In";
    
    self.loginButton.layer.cornerRadius = 10;
    self.userNameTextField.layer.cornerRadius = 10;
    self.passwordTextField.layer.cornerRadius = 10;
    self.scrollView.delegate = self;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = YES;
    self.scrollView.showsHorizontalScrollIndicator = YES;
    
    self.userNameTextField.text = @"mcostraci";
    self.passwordTextField.text = @"Roller.sl92";
    
}


- (IBAction)loginButtonTouched:(id)sender {
    
//    {@"username" : self.userNameTextField.text,
//        @"password" : self.passwordTextField.text}
    
    [self disableUserIteraction];
    
    STAUserConnector *userConnector = [STAUserConnector new];
    [userConnector logIn:@{@"username" : @"mcostraci",
                           @"password" : self.passwordTextField.text}
            successBlock:^(id object) {
                
                [self enableUserIteraction];
                user.userName = self.userNameTextField.text;
                
                MainViewController *mainVC = [self.mainStoryBoard instantiateViewControllerWithIdentifier:@"MainViewControllerID"];
                [self.navigationController pushViewController:mainVC animated:YES];
                
            }
            failBlock:^(NSError *error) {
                
                [self enableUserIteraction];
                [self showAlertViewWithTitle:@"Error" andMessage:error.localizedDescription];
            
               }];
    
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
