//
//  RegisterViewController.m
//  fclibrary
//
//  Created by Neo Neo on 11/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RegisterViewController.h"
#import "FCLibrary.h"

@implementation RegisterViewController
@synthesize txtFldRegister;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // add navigationButton to Bar
    UIBarButtonItem *button = [[UIBarButtonItem alloc]
                               initWithTitle:@"register" style:UIBarButtonItemStylePlain target:self action:@selector(register:)];
    
    self.navigationItem.rightBarButtonItem = button;
    [button release];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self register:textField];
    return NO;  
}

-(void)closeWindow
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)alert:(NSString*)message
{
    // show alert withm message
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
													message:message
												   delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (IBAction)register:(id)sender 
{
    
    // Dismiss keyboard, call FC Web service, confirm alert
    [txtFldRegister resignFirstResponder];
    
    if (! ([txtFldRegister.text isEqualToString:@""] | [txtFldPassword.text isEqualToString:@""]))
    {
        // Register
        FCLibrary *fc = [FCLibrary sharedSingleton];
        NSDictionary *response = [fc registerNumber:txtFldRegister.text withPassword:txtFldPassword.text];
        
        // Response - code & message
        NSEnumerator *keyEnum = [response keyEnumerator];
        id key;
        BOOL isValid = false;
        while ((key = [keyEnum nextObject]))
        {
            if ([key isEqualToString:@"code"]) {
                isValid = TRUE;
            }
        };
        
        // Did we get valid response
        if (isValid) {
            [self alert:[NSString stringWithFormat:@"%@ %@", [response objectForKey:@"message"], [response objectForKey:@"code"]]];
            [[NSUserDefaults standardUserDefaults] setValue:[NSDictionary dictionaryWithObjectsAndKeys:txtFldRegister.text, @"account", txtFldPassword.text, @"password", nil] forKey:@"accountDetails"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        } else {
            [self alert:[NSString stringWithFormat:@"Invalid response."]];
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [self setTxtFldRegister:nil];
    [txtFldPassword release];
    txtFldPassword = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [txtFldRegister release];
    [txtFldPassword release];
    [super dealloc];
}
@end
