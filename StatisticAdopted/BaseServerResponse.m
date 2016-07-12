//
//  BaseServerResponse.m
//
//  Copyright (c) 2015 MUUME AG. All rights reserved.
//

#import "BaseServerResponse.h"
#import "STABaseConnector.h"
#import "ErrorHandler.h"

@implementation BaseServerResponse

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
  return @{@"statusString":@"status",
           @"errorString":@"error"};
}

- (void)setAsUnknownError
{
  self.statusString = @"ERROR";
  self.errorString = @"UNKNOWN_ERROR";
}


- (void)setAsUnauthorizedError
{
  self.statusString = @"ERROR";
  self.errorString = @"UNAUTHORIZED";
}

- (BOOL)isOK {
    
    if ([self.statusString isEqualToString:@"OK"]) {
        return YES;
    }
    return NO;
}

- (NSError*)errorObject {
    
    return [NSError errorWithDomain:HOST_NAME
                               code:[ErrorHandler errorCodeFromString:self.errorString]
                           userInfo:@{NSLocalizedDescriptionKey:self.errorString}];
    
//    [MuumeUtils localized:self.errorString]
}

@end
