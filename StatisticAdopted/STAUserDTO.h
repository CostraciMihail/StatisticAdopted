//
//  STAUserDTO.h
//  StatisticAdopted
//
//  Created by winify on 7/12/16.
//  Copyright © 2016 winify. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseServerResponse.h"
#import "STACurrentTimeDTO.h"

@interface STAUserDTO : BaseServerResponse

@property(nonatomic, strong) NSString *userName;
@property(nonatomic, strong) NSString *password;
@property(nonatomic, strong) NSString *fullName;
@property(nonatomic, strong) NSString *token;
@property(nonatomic, strong) NSString *userStatistic;
@property(nonatomic, strong) NSString *userTime;

@property(nonatomic, strong) STACurrentTimeDTO *currentTime;

+ (id)shareInstace;
- (void)logInserializion:(NSDictionary *)parameters;

@end
