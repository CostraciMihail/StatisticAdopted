//
//  BaseServerResponse.h
//
//  Copyright (c) 2015 Statistic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseServerResponse : NSObject

@property (nonatomic, strong) NSString *statusString;
@property (nonatomic, strong) NSString *errorString;

- (void)setAsUnknownError;
- (void)setAsUnauthorizedError;
- (BOOL)isOK;
- (NSError*)errorObject;

@end
