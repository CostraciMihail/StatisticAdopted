//
//  STACurrentTimeDTO.h
//  StatisticAdopted
//
//  Created by winify on 7/13/16.
//  Copyright © 2016 winify. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STAUtilities.h"


@interface STACurrentTimeDTO : NSObject

@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSString *timeWorked;
@property (nonatomic, strong) NSString *timeToWork;
@property  LOGED_IN loggedIn;
@property (nonatomic, strong) NSString *error;


- (instancetype)initWithJSONdict:(NSDictionary *)parameters;

@end
