//
//  STAUtilities.h
//  StatisticAdopted
//
//  Created by winify on 7/13/16.
//  Copyright © 2016 winify. All rights reserved.
//

#import <Foundation/Foundation.h>

//SEGUES IDENTIFIES
#define segueIdentifierOpenLoginView @"showLogInViewSegue"
#define segueIdentifierOpenMainView @"openMainView"

#define screenBounds [UIScreen mainScreen].bounds
#define showDealloc NO

typedef enum : NSUInteger {
    
    LOGED_IN_FALSE,
    LOGED_IN_TRUE
    
} LOGED_IN;

@interface STAUtilities : NSObject

@end
