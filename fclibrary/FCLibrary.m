//
//  fclibrary.m
//  fcdispatch
//
//  Created by Neo Neo on 11/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FCLibrary.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJsonParser.h"

#define debugMode TRUE

static FCLibrary *sharedSingleton = nil;

@implementation FCLibrary

#pragma mark -
#pragma mark "Singleton"
#pragma mark -


+ (FCLibrary *)sharedSingleton
{
    @synchronized(self)
    {
        if (!sharedSingleton)
            sharedSingleton = [[FCLibrary alloc] init];
        
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
#pragma mark "network Request"
#pragma mark -

- (NSDictionary*)networkRequest:(NSString*)url requestType:(NSString*)type data:(NSData*)data passwordRequired:(BOOL)sendPassword
{
    
    // make network request
    NSDictionary *dataDictionary = [NSDictionary dictionary];
    NSDictionary *accountDetails = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"accountDetails"];    
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    
    // build request
    if (data != nil) [request appendPostData:data];
    [request setRequestMethod:type];    
    [request setRequestHeaders:[NSMutableDictionary dictionaryWithObject:@"application/x-www-form-urlencoded" forKey:@"Content-Type"]];
    
    // password ?
    if (sendPassword) {
        request.shouldPresentCredentialsBeforeChallenge = YES;
        [request addBasicAuthenticationHeaderWithUsername:[accountDetails objectForKey:@"account"]
                                              andPassword:[accountDetails objectForKey:@"password"]];
    }
    
    // network request
    [request startSynchronous];
    
    // handle response
    NSError *error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        
        if (debugMode) NSLog (@"%@", response);
        
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        dataDictionary = [parser objectWithString:response];
        [parser release];
    }
    return dataDictionary;
}

#pragma mark -
#pragma mark "Functions"
#pragma mark -

- (NSDictionary*)registerNumber:(NSString *)primaryNumber withPassword:(NSString *)password
{
    // registerNumber
    NSString *credentials = [NSString stringWithFormat:@"password=%@", password];
    return [self networkRequest:[NSString stringWithFormat:@"http://api.fakecall.net/v1/account/%@", primaryNumber]
                    requestType:@"PUT"
                           data:[credentials dataUsingEncoding:NSUTF8StringEncoding]
               passwordRequired:YES];
}

- (NSDictionary*)removeAccount:(NSString *)primaryNumber
{
    // removeAccount
    return [self networkRequest:[NSString stringWithFormat:@"http://api.fakecall.net/v1/account/%@", primaryNumber]
                    requestType:@"DELETE"
                           data:nil
               passwordRequired:YES];
}

- (NSDictionary*)changePassword:(NSString *)primaryNumber
{
    NSDictionary *dataDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"45", @"code", @"message", @"message", nil];
    return dataDictionary;
}

- (NSDictionary*)call:(NSString *)numberToCall
{
    
    // set up call
    return [self networkRequest:[NSString stringWithFormat:@"http://api.fakecall.net/v1/account/%@/call", numberToCall]
                    requestType:@"POST"
                           data:nil
               passwordRequired:YES];
}

- (NSDictionary*)authorizeThisNumber:(NSString*)primaryNumber forMyAccount:(NSString*)number
{
    
    // Authorize another caller to call your account
    return [self networkRequest:[NSString stringWithFormat:@"http://api.fakecall.net/v1/account/%@/authorization/%@", primaryNumber, number]
                    requestType:@"PUT"
                           data:nil
               passwordRequired:YES];
}

- (NSDictionary*)listAuthorizedNumbers:(NSString*)primaryNumber
{
    // list authorized numbers - {"list":["5555558899","5556667777"],"message":"call authorizations"}
    return [self networkRequest:[NSString stringWithFormat:@"http://api.fakecall.net/v1/account/%@/authorization", primaryNumber]
                    requestType:@"GET"
                           data:nil
               passwordRequired:YES];
}

- (NSDictionary*)removeAuthorizedNumber:(NSString*)number
{
    
    // Remove Authorized Number
    NSDictionary *accountDetails = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"accountDetails"];    
    return [self networkRequest:[NSString stringWithFormat:@"http://api.fakecall.net/v1/account/%@/authorization/%@", [accountDetails objectForKey:@"account"], number]
                    requestType:@"DELETE"
                           data:nil
               passwordRequired:YES];
}

@end
