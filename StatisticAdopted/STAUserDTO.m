//
//  STAUserDTO.m
//  StatisticAdopted
//
//  Created by winify on 7/12/16.
//  Copyright © 2016 winify. All rights reserved.
//

#import "STAUserDTO.h"

@implementation STAUserDTO

+ (id)shareInstace
{
    static STAUserDTO *userDTO = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userDTO = [[self alloc] init];
    });
    return userDTO;
}

- (void)logInserializion:(NSDictionary *)parameters
{
    NSLog(@"%@", parameters);
    
    self.token = [parameters valueForKey:@"token"];
}

@end
