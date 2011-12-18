//
//  fclibraryTests.m
//  fclibraryTests
//
//  Created by Neo Neo on 11/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "fclibraryTests.h"
#import "FCLibrary.h"

@implementation fclibraryTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    fc = [FCLibrary sharedSingleton];
    [super setUp];
}

- (void)tearDown
{
    // Tear-down code here.
    [super tearDown];
}

- (void)testSetup
{
//    STAssertNotNil(fc, @"Can't be nil");
//    // do we have account and password?
//    STAssertTrue([[fc account] isKindOfClass: [NSDictionary class]], @"Response Received is not Dictionary, Account Error.");
//    STAssertNotNil([fc account], @"Account not setup, please register.");
}

- (void)testRegisterPrimaryNumber
{
    // can we register Account
    NSDictionary *response = [fc registerNumber:@"1234567890" withPassword:@"981"];
    STAssertTrue([response isKindOfClass: [NSDictionary class]], @"Response Received is not Dictionary, Registration Failed");
    STAssertNotNil([response valueForKey:@"code"], @"Code key not found! Registration Failed");
    STAssertNotNil([response valueForKey:@"message"], @"Message key not found! Registration Failed");
}

- (void)testRemoveAccount
{
    // can we remove account - {"message":"Account 1234567890 removed."}
    NSDictionary *response = [fc removeAccount:@"1234567890"];
    STAssertTrue([response isKindOfClass: [NSDictionary class]], @"Response Received is not Dictionary, Registration Failed");
    STAssertTrue([[response valueForKey:@"message"] isEqualToString:@"Account 1234567890 removed."],    @"Invalid Response to Account Removal");
    
}

- (void)testChangePassword
{
    // Can we change Password {"message":"Account 1234567890 removed."}
    NSDictionary *response = [fc changePassword:@"1234567890"];
    STAssertTrue([response isKindOfClass: [NSDictionary class]], @"Response Received is not Dictionary, Password Changed Failed");
    STAssertNotNil([response valueForKey:@"code"], @"Code key not found! Registration Failed");
    STAssertNotNil([response valueForKey:@"message"], @"Message key not found! Registration Failed");
    
}

- (void)testCallNow
{
    // calling your number -   {"timelimit":"now","caller":"steve","precision":"0s","message":"I'm calling 1234567890 right now!"}
    NSDictionary *response = [fc call:@"1234567890"];
    STAssertTrue([response isKindOfClass: [NSDictionary class]], @"Response Received is not Dictionary, Registration Failed");
    STAssertNotNil([response valueForKey:@"timelimit"], @"now");
    STAssertNotNil([response valueForKey:@"message"], @"I'm calling 1234567890 right now!");
}

- (void)testAuthorizeNumber
{
    // calling your number -    {"message":"5555558899 is now authorized to post to your number."}
    NSDictionary *response = [fc authorizeThisNumber:@"1234567890" forMyAccount:@"097654321"];
    STAssertTrue([response isKindOfClass: [NSDictionary class]], @"Response Received is not Dictionary, Authorization Failed");
    STAssertNotNil([response valueForKey:@"message"], @"1234567890 is now authorized to post to your number.");
}

- (void)testListAuthorizedNumbers
{
    // calling your number -    {"list":["5555558899","5556667777"],"message":"call authorizations"}
    NSDictionary *response = [fc listAuthorizedNumbers:@"1234567890"];
    STAssertTrue([response isKindOfClass: [NSDictionary class]], @"Response Received is not Dictionary, Listing Failed");
    NSArray *array = [response objectForKey:@"list]:
    if ([response count] == 0 ) {
        STAssertTrue([response count] == 0, @"There are no numbers authorized on your account");
    } else {
        STAssertTrue([response count] >= 1, @"There are number(s) authorized on your account");

    }
}

- (void)testRemoveAuthorizedNumber
{
    // remove Authorized Number -    {"message":"1234567890 has been deauthorized."}
    NSDictionary *response = [fc removeAuthorizedNumber:@"1234567890"];
    STAssertTrue([response isKindOfClass: [NSDictionary class]], @"Response Received is not Dictionary, Removal Failed");
    STAssertNotNil([response valueForKey:@"message"], @"1234567890 as been deauthorized.");

}

// can we make a request to dial friend's number

@end
