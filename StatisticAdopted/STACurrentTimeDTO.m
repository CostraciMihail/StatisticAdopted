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
        self.loggedIn = (BOOL)[parameters valueForKey:@"loggedIn"];
        self.error = [parameters valueForKey:@"error"];
    }
    return self;

}

@end
