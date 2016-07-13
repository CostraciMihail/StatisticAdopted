//
//  STABaseViewController.h
//  StatisticAdopted
//
//  Created by winify on 7/12/16.
//  Copyright © 2016 winify. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STAUserDTO.h"


@interface STABaseViewController : UIViewController
{
    STAUserDTO *user;

}

@property(nonatomic, strong) UIStoryboard *mainStoryBoard;
@property(nonatomic, strong) STAUserDTO *user;

- (void)showAlertViewWithTitle:(NSString *)title
                    andMessage:(NSString *)message;

@end
