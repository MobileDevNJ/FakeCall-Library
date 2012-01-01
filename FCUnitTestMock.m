//
//  FCUnitTestMock.m
//  fclibrary
//
//  Created by Ainsley Rattray on 1/1/12.
//  Copyright (c) 2012 Kaliware, LLC. All rights reserved.
//

#import "FCUnitTestMock.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJsonParser.h"

#define failureMode FALSE

static FCUnitTestMock *sharedSingleton = nil;

@implementation FCUnitTestMock

#pragma mark -
#pragma mark "Singleton"
#pragma mark -


+ (FCUnitTestMock *)sharedSingleton
{
    @synchronized(self)
    {
        if (!sharedSingleton)
            sharedSingleton = [[FCUnitTestMock alloc] init];
        
        return sharedSingleton;
    }
}

- (void)dealloc
{
	[super dealloc];
}

- (void)setup:(NSDictionary*)credentials
{
    // set account and password for future calls
}


#pragma mark -
#pragma mark "Functions"
#pragma mark -

- (NSDictionary*)registerNumber:(NSString *)primaryNumber withPassword:(NSString *)password
{
    // registerNumber
    // {"code":45,"message":"Enter the following 2 \
        digit code on your phone when we call you."}
    if (failureMode) {
        return [NSDictionary dictionaryWithObjectsAndKeys:@"Error registering number.", @"message", nil];
    } else {
        return [NSDictionary dictionaryWithObjectsAndKeys:@"45", @"code", @"Enter the following 2 digit code on your phone when we call you.", @"message", nil];
    }
}

- (NSDictionary*)removeAccount:(NSString *)primaryNumber
{
    // removeAccount
    // {"message":"Account 1234567890 removed."}
    if (failureMode) {
        return [NSDictionary dictionaryWithObjectsAndKeys:@"Problem removing account", @"message", nil];
    } else {
        return [NSDictionary dictionaryWithObjectsAndKeys:@"Account 1234567890 removed.", @"message", nil];
    }
}

- (NSDictionary*)changePassword:(NSString *)primaryNumber
{
    // Change Password
    // {"code":45,"message":"Enter the following 2 digit code on your phone when we call you."}
    if (failureMode) {
        return [NSDictionary dictionaryWithObjectsAndKeys:@"Error registering number.", @"message", nil];
    } else {
        return [NSDictionary dictionaryWithObjectsAndKeys:@"45", @"code", @"Enter the following 2 digit code on your phone when we call you.", @"message", nil];
    }
}

- (NSDictionary*)call:(NSString *)numberToCall
{
    // set up call
    // {"timelimit":"now","caller":"steve","precision":"0s", \
        "message":"I'm calling 1234567890 right now!"}
    if (failureMode) {
        return [NSDictionary dictionaryWithObjectsAndKeys:@"User not registered.", @"message", nil];
    } else {
        return [NSDictionary dictionaryWithObjectsAndKeys:@"now", @"timelimit", @"steve", @"caller", @"0s", @"precision", [NSString stringWithFormat:@"I'm calling %@ right now!", numberToCall], @"message", nil];
    }
}

- (NSDictionary*)authorizeThisNumber:(NSString*)number forMyAccount:(NSString*)primaryNumber
{
    // Authorize another caller to call your account
    // {"message":"5555558899 is now authorized to post to your number."}
    if (failureMode) {
        return [NSDictionary dictionaryWithObjectsAndKeys:@"User not registered.", @"message", nil];
    } else {
        return [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@ is now authorized to post to your number.", number ], @"message", nil];
    }
}

- (NSDictionary*)listAuthorizedNumbers:(NSString*)primaryNumber
{
    // list authorized numbers
    // {"list":["5555558899","5556667777"],"message":"call authorizations"}
    if (failureMode) {
        return [NSDictionary dictionaryWithObjectsAndKeys:@"No authorizations", @"message", nil];
    } else {
        return [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:@"1234567890",@"0987654321",nil], @"list", @"call authorizations", @"message", nil];
    }
}

- (NSDictionary*)removeAuthorizedNumber:(NSString*)number
{
    
    // Remove Authorized Number
    // {"message":"5555558899 has been deauthorized."}
    if (failureMode) {
        return [NSDictionary dictionaryWithObjectsAndKeys:@"no authorized users.", @"message", nil];
    } else {
        return [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@ has been deauthorized.", number], @"message", nil];
    }
}

@end
