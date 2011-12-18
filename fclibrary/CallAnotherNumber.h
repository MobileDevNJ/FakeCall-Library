//
//  CallAnotherNumber.h
//  fclibrary
//
//  Created by Neo Neo on 12/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FCLibrary.h"


@interface CallAnotherNumber : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIAlertViewDelegate>
{
    IBOutlet UITableView *myTableView;
    IBOutlet UITextField *myNumber;
    FCLibrary *fakeCall;
    BOOL shouldAdd;
    NSMutableArray *listArray;
    NSIndexPath *savedIndexPath;
}

@property (nonatomic, retain) NSIndexPath *savedIndexPath;
@property (nonatomic, retain) FCLibrary *fakeCall;
@property (nonatomic, retain) UITableView *myTableView;
@property (nonatomic, retain) NSMutableArray *listArray;
@property (nonatomic, retain) UITextField *myNumber;

- (void)showAlert;

@end
