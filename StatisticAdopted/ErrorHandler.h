//
//  ErrorHandler.h
//
//  Copyright © 2016 MUUME AG. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    UNKNOWN_ERROR,
    LOGIN_FAILED,
    UNAUTHORIZED = 401,
    UNAUTHORIZED_WRONG_PASSWORD = -1011,
    PASSWORD_IS_REQUIRED,
    WRONG_PASSWORD,
    OPERATION_COULD_NOT_BE_COMPLETED = -999,
    NO_INTERNET_CONNECTION = -1004
    
} ErrorCode;


typedef void (^Handler)(id sender);

@interface ErrorHandler : NSObject  {
    
    NSMutableDictionary *handlers;
    id errorHandler;
}

/**
 An dictionary where the key is NSError and value is a block to handle such
 errors.
 */
@property (strong, nonatomic) NSMutableDictionary *handlers;

/**
 A default handler is executed when no any added handlers.
 */
- (void)setDefaultHandler:(void(^)(NSError *error))handler;
@property (strong, nonatomic) id errorHandler;

/**
 A default initializator. It adds a signout handler to handlers dictionary
 */
- (id)init;


/**
 Add a handler block for errors with the doman and code.
 @param handler A block this will execute to handle the error with the domain
 and code passed as 2 and 3 params.
 @param domain domain of error
 @param code code of error
 */

- (void)addHandler:(void(^)(NSError *error))handler
            domain:(NSString *)domain
              code:(NSInteger)code;


/**
 
 Handle the error. This method iterates through handlers dictionary keys
 and search a NSError key with the domain and code same as in error parameter.
 If found it gets the handle block using found key and execute it. If such
 key not found it executes the default handler.
 
 @param error Error to handle. If there is no added a handler block for error
 with same domain and code execute default handler. If the default handler is
 not set too, do nothing.
 
 */
- (void)handle:(NSError*)error;



+ (ErrorCode)errorCodeFromString:(NSString*)errorString;

@end
