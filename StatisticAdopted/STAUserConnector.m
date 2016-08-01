//
//  STAMeConnector.m
//  StatisticAdopted
//
//  Created by winify on 7/12/16.
//  Copyright © 2016 winify. All rights reserved.
//

#import "STAUserConnector.h"
#import "STAUserDTO.h"

@implementation STAUserConnector
{
    STAUserDTO *user;

}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        user = [STAUserDTO shareInstace];
        
        __weak __typeof (self)weakSelf = self;
        [errorHandler addHandler:^(NSError *error) {
            
            [weakSelf relogIn:^(id object) { }
            failBlock:^(id object) { }];
            
        } domain:@"NSURLErrorDomain" code:UNAUTHORIZED_WRONG_PASSWORD];
        
    }
    return self;
}


- (void)logIn:(NSDictionary *)parameters
 successBlock:(SuccessBlock)succesBlock
    failBlock: (FailureBlock)failBlock
{

    [self requestForService:@"/login"
             withParameters:parameters
                     method:REQUEST_METHOD_POST
                succesBlock:^(NSDictionary *object) {
                    
                [user logInserializion:object];
                    
                    //validate object is not working
//                NSError *error = nil;
//                [self validateObject:user
//                               error:error
//                             success:succesBlock
//                                fail:failBlock];
                    
                succesBlock(object);
                    
                }
               failuerBlock:^(NSError *error) {
                   
                   [errorHandler handle:error];
                   failBlock(error);
               }];
}

- (void)relogIn:(SuccessBlock)succesBlock
    failBlock:(FailureBlock)failBlock
{
    
    [self requestForService:@"/login"
             withParameters:@{@"username" : user.userName,
                              @"password" : user.password}
                     method:REQUEST_METHOD_POST
                succesBlock:^(id object) {
                    
                    succesBlock(object);
                    
                }
               failuerBlock:^(NSError *error) {
               
                   [errorHandler handle:error];
                   failBlock(error);
                   
               }];
    
}

- (void)logOutWithSuccessBlock:(SuccessBlock)succesBlock
                     failBlock:(FailureBlock)failBlock
{
    
    [self requestForService:@"/logout"
             withParameters:@{@"token" : user.token}
                     method:REQUEST_METHOD_POST
                succesBlock:^(id object) {
                    
                    succesBlock(object);
                }
               failuerBlock:^(NSError *error) {

                   [errorHandler handle:error];
                   failBlock(error);
               }];
    
}

- (void)startTime:(NSDictionary *)parameters
     successBlock:(SuccessBlock)succesBlock
        failBlock: (FailureBlock)failBlock
{
    
    [self requestForService:@"/start"
             withParameters:@{@"token" : user.token}
                     method:REQUEST_METHOD_POST
                succesBlock:^(NSDictionary *responseObject) {
                    
                    
                    succesBlock(responseObject);
                    
                }
               failuerBlock:^(NSError *error) {
                   
                   [errorHandler handle:error];
                   failBlock(error);
                   
               }];
    
}


- (void)stopTime:(NSDictionary *)parameters
            successBlock:(SuccessBlock)succesBlock
               failBlock: (FailureBlock)failBlock
{

    [self requestForService:@"/stop"
             withParameters:@{@"token" : user.token}
                     method:REQUEST_METHOD_POST
                succesBlock:^(NSDictionary *responseObject) {
                    
                    
                    succesBlock(responseObject);
                    
                }
               failuerBlock:^(NSError *error) {
                   
                   [errorHandler handle:error];
                   failBlock(error);
                   
               }];
    

}

@end
