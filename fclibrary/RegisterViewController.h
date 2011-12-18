//
//  RegisterViewController.h
//  fclibrary
//
//  Created by Neo Neo on 11/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController  <UITextFieldDelegate>
{
    UITextField *txtFldRegister;
    IBOutlet UITextField *txtFldPassword;

}
@property (retain, nonatomic) IBOutlet UITextField *txtFldRegister;

- (IBAction)register:(id)sender;

@end
