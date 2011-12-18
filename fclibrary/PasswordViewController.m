//
//  PasswordViewController.m
//  fclibrary
//
//  Created by Neo Neo on 12/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PasswordViewController.h"

@implementation PasswordViewController

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
    UIBarButtonItem *button = [[UIBarButtonItem alloc] 
                               initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(save:)];
    
    self.navigationItem.rightBarButtonItem = button;
    [button release];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)save:(id)sender
{
    // save
    FCLibrary *fakeCall = [FCLibrary sharedSingleton];
    NSDictionary *accountDetails = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"accountDetails"];
    [fakeCall registerNumber:[accountDetails objectForKey:@"account"] withPassword:[self getLabelWithString:100]];
    
}

- (NSString*)getLabelWithString:(int)tagNumber
{
    UILabel *number = (UILabel*)[self.view viewWithTag:tagNumber];
    return [number text];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
