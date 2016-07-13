//
//  STABaseConnector.m
//  StatisticAdopted
//
//  Created by winify on 7/12/16.
//  Copyright © 2016 winify. All rights reserved.
//

#import "STABaseConnector.h"

@implementation STABaseConnector
@synthesize errorHandler;


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        errorHandler = [ErrorHandler new];
    }
    return self;
}

- (void)requestForService:(NSString *)services
           withParameters:(NSDictionary *)parameters
                   method:(REQUEST_METHOD)method
              succesBlock:(SuccessBlock)successBlock
             failuerBlock:(FailureBlock)failureBlock
{
    
    self.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    NSString *requestURL = [self buildUrl:services];
    
    switch (method)
    {
        case REQUEST_METHOD_GET:
        {
            NSLog(@"GET %@", requestURL);
            
            [self GET:requestURL
            parameters:parameters
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSLog(@"%ld %@", (long)operation.response.statusCode, operation.response.URL);
                NSLog(@"ResponseString: %@", operation.responseString);
                NSLog(@"ResponseObject: %@",responseObject);
                
                [self processRespondObject:responseObject
                               succesBlock:successBlock
                              failuerBlock:successBlock];
            
            }
            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                NSLog(@"%ld %@", (long)operation.response.statusCode, operation.response.URL);
                NSLog(@"Error: %@ \n ResponseString: %@" , error, operation.responseString);

//                NSString *str = [[NSString alloc] initWithData:(NSData *)operation.responseObject encoding:NSUTF8StringEncoding];
//                NSLog(@"%@", str);
//                NSLog(@"%@", error.localizedFailureReason);
//                NSLog(@"%@", error.userInfo);
                
//                [errorHandler handle:error];
                failureBlock(error);
                
            }];
            
        }
            break;
            
            
            
        case REQUEST_METHOD_POST:
        {
            NSLog(@"POST %@", requestURL);
            
            [self POST:requestURL
            parameters:parameters
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   
                   NSLog(@"%ld %@", (long)operation.response.statusCode, operation.response.URL);
                   NSLog(@"ResponseString: %@", operation.responseString);
                   NSLog(@"ResponseObject: %@",responseObject);
                   
                   [self processRespondObject:responseObject
                                  succesBlock:successBlock
                                 failuerBlock:successBlock];
                   
               }
               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   
                   
                   NSLog(@"%ld %@", (long)operation.response.statusCode, operation.response.URL);
                   NSLog(@"Error: %@ \n ResponseString: %@" , error, operation.responseString);
                   
//                   NSLog(@"%@", operation.responseString);
//                   NSLog(@"%@", error.localizedFailureReason);
//                   NSLog(@"%@", error.userInfo);
                   
//                   [errorHandler handle:error];
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
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:object
                                                            options:NSJSONReadingAllowFragments
                                                              error:&error];
    
    
    if (!error) {
        
        successBlock(dic);
    }
    
    else {
        
        NSLog(@"Can't deserealize object");
        failureBlock(error);
    };
    
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

- (NSString *)buildUrl:(NSString *)string {
    
    NSString *url = [NSString stringWithFormat:@"%@%@", HOST_NAME , string];
    [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return url;
}

- (void)cancelAllRequests {
    
    [self.operationQueue cancelAllOperations];
}


@end
