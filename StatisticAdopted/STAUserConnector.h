//
//  STAMeConnector.h
//  StatisticAdopted
//
//  Created by winify on 7/12/16.
//  Copyright © 2016 winify. All rights reserved.
//

#import "STABaseConnector.h"

@interface STAUserConnector : STABaseConnector

- (void)logIn:(NSDictionary *)parameters successBlock:(SuccessBlock)succesBlock
                                            failBlock:(FailureBlock)failBlock;

- (void)relogIn:(SuccessBlock)succesBlock
    failBlock:(FailureBlock)failBlock;

- (void)logOutWithSuccessBlock:(SuccessBlock)succesBlock
                     failBlock:(FailureBlock)failBlock;

- (void)startTime:(NSDictionary *)parameters
     successBlock:(SuccessBlock)succesBlock
        failBlock: (FailureBlock)failBlock;


- (void)stopTime:(NSDictionary *)parameters
    successBlock:(SuccessBlock)succesBlock
       failBlock: (FailureBlock)failBlock;

@end
