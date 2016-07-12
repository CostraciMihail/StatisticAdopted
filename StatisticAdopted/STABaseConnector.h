//
//  STABaseConnector.h
//  StatisticAdopted
//
//  Created by winify on 7/12/16.
//  Copyright © 2016 winify. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <Foundation/Foundation.h>


#define HOST_NAME @"http://192.168.3.145"

typedef enum : NSUInteger {
    
    REQUEST_METHOD_GET,
    REQUEST_METHOD_POST,
    REQUEST_METHOD_DELETE
    
} REQUEST_METHOD;


@interface STABaseConnector : AFHTTPRequestOperationManager

typedef void (^SuccessBlock)(id object);
typedef void (^FailureBlock)(id object);

- (void)requestForService:(NSString *)services
           withParameters:(NSDictionary *)parameters
                   method:(REQUEST_METHOD)method
              succesBlock:(SuccessBlock)successBlock
             failuerBlock:(FailureBlock)failureBlock;

@end
