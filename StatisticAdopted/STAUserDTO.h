//
//  STAUserDTO.h
//  StatisticAdopted
//
//  Created by winify on 7/12/16.
//  Copyright © 2016 winify. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STAUserDTO : NSObject

@property(nonatomic, strong) NSString *userName;
@property(nonatomic, strong) NSString *password;
@property(nonatomic, strong) NSString *fullName;
@property(nonatomic, strong) NSString *token;
@property(nonatomic, strong) NSString *userStatistic;
@property(nonatomic, strong) NSString *userTime;

+ (id)shareInstace;
- (void)logInserializion:(NSDictionary *)parameters;

@end
