//
//  STAStatisticConnector.m
//  StatisticAdopted
//
//  Created by winify on 7/13/16.
//  Copyright © 2016 winify. All rights reserved.
//

#import "STAStatisticConnector.h"
#import "STAUserDTO.h"

@implementation STAStatisticConnector


- (void)getStatisticInfo:(NSDictionary *)parameters
        successBlock:(SuccessBlock)succesBlock
           failBlock: (FailureBlock)failBlock
{
    
    [self requestForService:@"/statistics/getInfo"
             withParameters:parameters
                     method:REQUEST_METHOD_GET
                succesBlock:^(NSDictionary *responseObject) {
                    
                    
                    succesBlock(responseObject);
                }
               failuerBlock:^(NSError *error) {
                   
                   [errorHandler handle:error];
                   failBlock(error);
                   
               }];

}

@end
