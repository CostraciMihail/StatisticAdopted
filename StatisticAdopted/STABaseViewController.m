//
//  STABaseViewController.m
//  StatisticAdopted
//
//  Created by winify on 7/12/16.
//  Copyright © 2016 winify. All rights reserved.
//

#import "STABaseViewController.h"

#define bgActivitySizeView 80
#define activityIndicatorSize 60

@interface STABaseViewController ()
{
    UIView *bgMask;
    UIActivityIndicatorView *activityIndicator;
    UIView *bgActivityView;
}

@end

@implementation STABaseViewController
@synthesize user;


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setUpLoadingView];
    
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

- (void)setUpLoadingView {
    
    bgMask = [[UIView alloc] initWithFrame:screenBounds];
    [bgMask setBackgroundColor:[UIColor grayColor]];
    
    bgActivityView = [[UIView alloc] initWithFrame:CGRectMake(screenBounds.size.width/2-bgActivitySizeView/2,
                                                              screenBounds.size.width/2-bgActivitySizeView/2,
                                                              bgActivitySizeView, bgActivitySizeView)];
    [bgActivityView setBackgroundColor:[UIColor blackColor]];
    bgActivityView.layer.cornerRadius = 10;
    
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(bgActivitySizeView/2-activityIndicatorSize/2,
                                                                                  bgActivitySizeView/2-activityIndicatorSize/2,
                                                                                  activityIndicatorSize, activityIndicatorSize)];
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
}

- (void)disableUserIteraction {
    
    [self.view setUserInteractionEnabled:NO];
    self.view.alpha = 0.6;
    [self.view addSubview:bgMask];
    [bgMask addSubview:bgActivityView];
    [bgActivityView addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
}

- (void)enableUserIteraction {
    
    [self.view setUserInteractionEnabled:YES];
    self.view.alpha = 1.0;
    [activityIndicator stopAnimating];
    [activityIndicator removeFromSuperview];
    [bgActivityView removeFromSuperview];
    [bgMask removeFromSuperview];
    
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
