//
//  PasswordViewController.h
//  fclibrary
//
//  Created by Neo Neo on 12/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"

@interface PasswordViewController : UIViewController
{

    MasterViewController *masterViewController;
}

- (NSString*)getLabelWithString:(int)tagNumber;

@end

