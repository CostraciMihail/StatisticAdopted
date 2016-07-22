//
//  ErrorHandler.m
//
//  Copyright © 2016 MUUME AG. All rights reserved.
//

#import "ErrorHandler.h"
#import "AFNetworking.h"

@implementation ErrorHandler
@synthesize handlers,errorHandler;

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        handlers = [NSMutableDictionary new];
        
        [self addSignoutHandler];
        
        [self setDefaultHandler:^(NSError *error) {
            
            NSString *message = (error.localizedDescription);
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"UNKNOWN ERROR"
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
        }];
        
        
        [self addHandler:^(NSError *error) {
            
            NSLog(@"%@",error);
            
        } domain:@"NSURLErrorDomain" code:OPERATION_COULD_NOT_BE_COMPLETED];
        
    }
    return self;
}


- (void)addSignoutHandler
{
    [self addHandler:^(NSError *error) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UNAUTHORIZED" object:nil];
        
    } domain:@"com.alamofire.error.serialization.response" code:UNAUTHORIZED];
    
}

- (void)setDefaultHandler:(void(^)(NSError *error))handler {
    
    errorHandler = handler;
}

- (void)addHandler:(void(^)(NSError *error))handler
            domain:(NSString *)domain
              code:(NSInteger)code
{
    NSError *error = [[NSError alloc] initWithDomain:domain code:code userInfo:nil];
    handlers[error] = handler;
}

- (void)handle:(NSError *)error
{
    if (error)
    {
        void(^handler)(NSError *);
        
        NSLog(@"%li %@", (long)error.code, error.domain);
        
        for (NSError *key in [handlers allKeys]) {
            
            id response = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
            if ([key.domain isEqualToString:error.domain] && (key.code == error.code || (response && key.code == [response statusCode])))
            {
                handler = handlers[key];
            }
        }
        
        if (handler == nil)
        {
            handler = self.errorHandler;
        }
        
        if (handler) {
            handler(error);
        }
    }
}



+ (ErrorCode)errorCodeFromString:(NSString*)errorString {

    @try
    {
        if ([errorString isEqualToString:@"UNKNOWN_ERROR"])
            return UNKNOWN_ERROR;
        if ([errorString isEqualToString:@"LOGIN_FAILED"])
            return LOGIN_FAILED;
        if ([errorString isEqualToString:@"UNAUTHORIZED"])
            return UNAUTHORIZED;
        if ([errorString isEqualToString:@"PHONE_WRONG_FORMAT"])
            return PHONE_WRONG_FORMAT;
        if ([errorString isEqualToString:@"PASSWORD_IS_REQUIRED"])
            return PASSWORD_IS_REQUIRED;
        if ([errorString isEqualToString:@"WRONG_PASSWORD"])
            return WRONG_PASSWORD;
        if ([errorString isEqualToString:@"USER_NOT_AUTHORIZED"])
            return USER_NOT_AUTHORIZED;
        if ([errorString isEqualToString:@"UNAUTHORIZED_WRONG_PASSWORD"])
            return UNAUTHORIZED_WRONG_PASSWORD;
        
        
        return UNKNOWN_ERROR;
    }
    @catch (NSException *exception) { return UNKNOWN_ERROR; }
    
}

@end
