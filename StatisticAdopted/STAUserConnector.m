//
//  STAMeConnector.m
//  StatisticAdopted
//
//  Created by winify on 7/12/16.
//  Copyright © 2016 winify. All rights reserved.
//

#import "STAUserConnector.h"

@implementation STAUserConnector


- (void)logIn:(NSDictionary *)parameters
 successBlock:(SuccessBlock)succesBlock
    failBlock: (FailureBlock)failBlock
{

    [self requestForService:@"/login"
             withParameters:parameters
                     method:REQUEST_METHOD_POST
                succesBlock:^(id object) {
                   

                    
                }
               failuerBlock:^(id object) {
                   
                   
               }];
    
}



@end
