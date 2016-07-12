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

                succesBlock(object);
                    
                }
               failuerBlock:^(NSError *error) {
                   
                   failBlock(error);
                   
               }];
    
}

- (void)logOut:(NSDictionary *)parameters
 successBlock:(SuccessBlock)succesBlock
    failBlock: (FailureBlock)failBlock
{
    
    [self requestForService:@"/logout"
             withParameters:@{@"token" : user.token}
                     method:REQUEST_METHOD_POST
                succesBlock:^(id object) {
                    
                    
                    
                    succesBlock(object);
                }
               failuerBlock:^(id object) {

                   
                   
                   failBlock(object);
               }];
    
}

- (void)startTime:(NSDictionary *)parameters
     successBlock:(SuccessBlock)succesBlock
        failBlock: (FailureBlock)failBlock
{
    
    [self requestForService:[self buildUrl:@"/start"]
             withParameters:parameters
                     method:REQUEST_METHOD_POST
                succesBlock:^(NSDictionary *responseObject) {
                    
                    
                    succesBlock(responseObject);
                    
                }
               failuerBlock:^(NSError *error) {
                   
                   failBlock(error);
                   
               }];
    
    
}


@end
