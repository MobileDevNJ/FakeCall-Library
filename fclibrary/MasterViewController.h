//
//  MasterViewController.h
//  fclibrary
//
//  Created by Neo Neo on 11/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FCLibrary.h"
#import "RegisterViewController.h"

@class DetailViewController;

@interface MasterViewController : UIViewController
{
    IBOutlet UIButton *btnChangePassword;
    IBOutlet UIButton *btnAuthorizeNumber;
    IBOutlet UIButton *btnRemoveNumber;
    NSDictionary *accountDetails;

    
    FCLibrary *fakeCall;
}
@property (strong, nonatomic) DetailViewController *detailViewController;
@property (nonatomic, retain) FCLibrary *fakeCall;

- (void)updateTextLabels;
- (void)showCallOrRegistrationButton;
- (void)updateLabelWithString:(NSString*)newString forTag:(int)tagNumber;

@end
