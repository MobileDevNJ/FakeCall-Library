//
//  FCUnitTestMock.h
//  fclibrary
//
//  Created by Ainsley Rattray on 1/1/12.
//  Copyright (c) 2012 Kaliware, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "SBJsonParser.h"
#import "FCLibrary.h"

@interface FCUnitTestMock : FCLibrary
{
    
}

    + (FCLibrary *)sharedSingleton;
    - (NSDictionary*)registerNumber:(NSString *)primaryNumber withPassword:(NSString *)password;
    - (NSDictionary*)removeAccount:(NSString *)primaryNumber;
    - (NSDictionary*)changePassword:(NSString *)primaryNumber;
    - (NSDictionary*)call:(NSString *)numberToCall;
    - (NSDictionary*)authorizeThisNumber:(NSString*)number forMyAccount:(NSString*)primaryNumber;
    - (NSDictionary*)listAuthorizedNumbers:(NSString*)primaryNumber;
    - (NSDictionary*)removeAuthorizedNumber:(NSString*)number;

@end
