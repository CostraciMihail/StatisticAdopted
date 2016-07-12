//
//  STABaseConnector.m
//  StatisticAdopted
//
//  Created by winify on 7/12/16.
//  Copyright © 2016 winify. All rights reserved.
//

#import "STABaseConnector.h"
#import "BaseServerResponse.h"

@implementation STABaseConnector


- (void)requestForService:(NSString *)services
           withParameters:(NSDictionary *)parameters
                   method:(REQUEST_METHOD)method
              succesBlock:(SuccessBlock)successBlock
             failuerBlock:(FailureBlock)failureBlock
{
    
    self.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    
    switch (method)
    {
        case REQUEST_METHOD_GET:
        {
            NSLog(@"GET %@", [self buildUrl:services]);
            
            [self GET:[self buildUrl:services]
            parameters:parameters
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                [self processRespondObject:responseObject
                               succesBlock:successBlock
                              failuerBlock:successBlock];
            
            }
            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                NSLog(@"Failure");
                
            }];
            
            
        }
            break;
            
        case REQUEST_METHOD_POST:
        {
            NSLog(@"POST %@", [self buildUrl:services]);
            
            [self POST:[self buildUrl:services]
            parameters:parameters
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   
                   
                   [self processRespondObject:responseObject
                                  succesBlock:successBlock
                                 failuerBlock:successBlock];
                   
               }
               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   
                   NSLog(@"Failure");
                   failureBlock(error);
                   
               }];
            
        }
            break;
            
        
        default:
            break;
    }
    
    
}

- (void)processRespondObject:(id)object
               succesBlock:(SuccessBlock)successBlock
              failuerBlock:(FailureBlock)failureBlock {
    
    NSError *error = nil;
    
    if ([NSJSONSerialization isValidJSONObject:object]) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:object
                                                            options:NSJSONReadingMutableContainers
                                                              error:&error];
        
        successBlock(dic);
        
    }
    else {
        
        NSLog(@"Can't deserealize object");
        failureBlock(error);
    }
}

- (void)validateObject:(BaseServerResponse*)responseObject
                 error:(NSError*)error
               success:(SuccessBlock)success
                  fail:(FailureBlock)fail
{    
    if (!error)
    {
        if (responseObject.isOK) { success(responseObject); }
        else { fail([responseObject errorObject]); }
        
    } else { fail([responseObject errorObject]); }
    
}

- (NSString *)buildUrl: (NSString *)string {
    
    NSString *url = [NSString stringWithFormat:@"%@%@", HOST_NAME , string];
    [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return url;
}

- (void)cancelAllRequests {
    
    [self.operationQueue cancelAllOperations];
}


@end
