//
//  STACurrentTimeDTO.m
//  StatisticAdopted
//
//  Created by winify on 7/13/16.
//  Copyright © 2016 winify. All rights reserved.
//

#import "STACurrentTimeDTO.h"

@implementation STACurrentTimeDTO


- (instancetype)initWithJSONdict:(NSDictionary *)parameters
{
    self = [super init];
    if (self) {
        
        self.timeWorked = [parameters valueForKey:@"timeWorked"];
        self.timeToWork = [parameters valueForKey:@"timeToWork"];
        self.loggedIn = [self getTimeState:[parameters valueForKey:@"loggedIn"]];
        self.error = [parameters valueForKey:@"error"];
    }
    return self;

}

- (LOGED_IN)getTimeState:(id)state {
    
    NSNumber *tmp = state;
    
    if ([tmp isEqual:@0])
        return LOGED_IN_FALSE;

    else  {
        return LOGED_IN_TRUE;
    }
}

@end
