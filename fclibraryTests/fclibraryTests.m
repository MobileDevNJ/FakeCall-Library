//
//  fclibraryTests.m
//  fclibraryTests
//
//  Created by Neo Neo on 11/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "fclibraryTests.h"
#import "FCLibrary.h"
#import "FCUnitTestMock.h"

// Define one of these
// #define testClass @"FCLibrary" // <-- Real version - NOTE breaks Unit Tests bc user interaction required
 #define testClass @"FCUnitTestMock" // <-- Mock version.

// required for Mock Unit Tests - FCUnitTestMock <-- replace with real phone number for Real version
#define defaultUserAccount @"Your Number Here"
#define defaultUserPassword @"999"

@implementation fclibraryTests

- (void)setUp
{    
    // Set-up code here.
    Class unitTestClass = NSClassFromString(testClass);
    fc = (FCLibrary*)[unitTestClass sharedSingleton];
    
    // use dummy number for Mock
    if ([NSStringFromClass([fc class]) isEqualToString:@"FCUnitTestMock"]) {
        defaultPassword = [[NSString stringWithString:@"999"] retain];        
        defaultPhoneAcct = [[NSString stringWithString:@"1234567890"] retain];
    } else {
        defaultPassword = [[NSString stringWithString:defaultUserPassword] retain];
        defaultPhoneAcct = [[NSString stringWithString:defaultUserAccount] retain];
    }
    [super setUp];
}

- (void)tearDown
{
    // Tear-down code here.
    [defaultPhoneAcct release];
    [defaultPassword release];
    [super tearDown];
}

- (void)test0Setup
{

    // Check for FCLibrary
    STAssertNotNil(fc, @"Can't be nil");
    
    // Check for Account Details
}

- (void)test1RegisterPrimaryNumber
{
    // can we register Account
    NSDictionary *response = [fc registerNumber:defaultPhoneAcct withPassword:defaultPassword];
    STAssertTrue([response isKindOfClass: [NSDictionary class]], @"Response Received is not Dictionary, Registration Failed");
    STAssertNotNil([response objectForKey:@"code"], @"Code key not found! Registration Failed");
    STAssertNotNil([response objectForKey:@"message"], @"Message key not found! Registration Failed");
    
    // save registration info for later
    [[NSUserDefaults standardUserDefaults] setValue:[NSDictionary dictionaryWithObjectsAndKeys:defaultPhoneAcct, @"account", defaultPassword, @"password", nil] forKey:@"accountDetails"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

- (void)test2ChangePassword
{
    // Can we change Password {"message":"Account 1234567890 removed."}
    NSDictionary *response = [fc changePassword:defaultPhoneAcct];
    STAssertTrue([response isKindOfClass: [NSDictionary class]], @"Response Received is not Dictionary, Password Changed Failed");
    STAssertNotNil([response objectForKey:@"code"], @"Code key not found! Registration Failed");
    STAssertNotNil([response objectForKey:@"message"], @"Message key not found! Registration Failed");
    
}

- (void)test3CallNow
{
    // calling your number -   {"timelimit":"now","caller":"steve","precision":"0s","message":"I'm calling 1234567890 right now!"}
    NSDictionary *response = [fc call:defaultPhoneAcct];
    STAssertTrue([response isKindOfClass: [NSDictionary class]], @"Response Received is not Dictionary, Registration Failed");
    STAssertNotNil([response objectForKey:@"timelimit"], @"now");
    STAssertNotNil([response objectForKey:@"message"], @"Message keyword not defined");
    
    // check return message
    NSString *responseString = [NSString stringWithFormat:@"I'm calling %@ right now!", defaultPhoneAcct];
    STAssertEqualObjects([response objectForKey:@"message"], responseString, @"testCallNow: Expected response not received.");
}

- (void)test4AuthorizeNumber
{
    // calling your number -    {"message":"5555558899 is now authorized to post to your number."}
    NSDictionary *response = [fc authorizeThisNumber:defaultPhoneAcct forMyAccount:@"1234567890"];
    STAssertTrue([response isKindOfClass: [NSDictionary class]], @"Response Received is not Dictionary, Authorization Failed");
    NSLog(@"Response: %@", [response objectForKey:@"message"]);
    STAssertNotNil([response objectForKey:@"message"], @"Message key not found! Registration Failed");
    
    // check return message
    NSString *responseString = [NSString stringWithFormat:@"%@ is now authorized to post to your number.", @"1234567890"];
    STAssertEqualObjects([response objectForKey:@"message"], responseString, @"testAuthorizedNumber: Expected response not received.");
}

- (void)test5ListAuthorizedNumbers
{
    // calling your number -    {"list":["5555558899","5556667777"],"message":"call authorizations"}
    NSDictionary *response = [fc listAuthorizedNumbers:defaultPhoneAcct];
    STAssertTrue([response isKindOfClass: [NSDictionary class]], @"Response Received is not Dictionary, Listing Failed");
   
    // check return message
    STAssertEqualObjects([response objectForKey:@"message"], @"call authorizations", @"Expected response: call authorizations - not returned.");
    
    NSArray *array = [response objectForKey:@"list"];
    if ([array count] == 0 ) {
        STAssertTrue([response count] < 1, @"Your number should at least be authorized and it isn't.");
    } else {
        STAssertTrue([response count] >= 1, @"There are number(s) authorized on your account.");
    }
}

- (void)test6RemoveAuthorizedNumber
{
    // remove Authorized Number -    {"message":"1234567890 has been deauthorized."}
    NSDictionary *response = [fc removeAuthorizedNumber:defaultPhoneAcct];
    STAssertTrue([response isKindOfClass: [NSDictionary class]], @"Response Received is not Dictionary, Removal Failed");
    STAssertNotNil([response objectForKey:@"message"], @"1234567890 has been deauthorized.");
    
    // check return message
    NSString *responseString = [NSString stringWithFormat:@"%@ has been deauthorized.", defaultPhoneAcct];
    STAssertEqualObjects([response objectForKey:@"message"], responseString, @"Expected response: call authorizations - not returned.");
}

- (void)test7RemoveAccount
{
    // can we remove account - {"message":"Account 1234567890 removed."}
    NSDictionary *response = [fc removeAccount:defaultPhoneAcct];
    STAssertTrue([response isKindOfClass: [NSDictionary class]], @"Response Received is not Dictionary, Registration Failed");
    
    // check return message
    NSString *responseString = [NSString stringWithFormat:@"Account %@ removed.", defaultPhoneAcct];
    STAssertEqualObjects([response objectForKey:@"message"], responseString, @"Expected response: Account removed - not returned.");
    
    // remove NSUserDefaults
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"accountDetails"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
