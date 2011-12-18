//
//  fclibrary.h
//  fcdispatch
//
//  Created by Neo Neo on 11/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "SBJsonParser.h"

@interface FCLibrary : NSObject
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
