//
//  STAStatisticConnector.h
//  StatisticAdopted
//
//  Created by winify on 7/13/16.
//  Copyright © 2016 winify. All rights reserved.
//

#import "STABaseConnector.h"

@interface STAStatisticConnector : STABaseConnector

- (void)getStatisticInfo:(NSDictionary *)parameters
            successBlock:(SuccessBlock)succesBlock
               failBlock: (FailureBlock)failBlock;

@end
