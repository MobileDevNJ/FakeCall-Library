//
//  MasterViewController.m
//  fclibrary
//
//  Created by Neo Neo on 11/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "RegisterViewController.h"
#import "PasswordViewController.h"
#import "ListViewController.h"
#import "CallAnotherNumber.h"

@implementation MasterViewController

@synthesize detailViewController = _detailViewController;
@synthesize fakeCall;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Master", @"Master");
    }
    return self;
}

							
- (void)dealloc
{
    [_detailViewController release];
    [btnRemoveNumber release];
    [btnChangePassword release];
    [btnAuthorizeNumber release];
    [super dealloc];
}

- (void)showCallOrRegistrationButton
{
    // are we already registered?
    accountDetails = [[NSDictionary alloc] init];
    accountDetails = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"accountDetails"];
    
    if((accountDetails == nil) || ([accountDetails count] == 0)) // compare against nil
    {
        // Register
        //==no user) )data saved, Show register buttons
        // create Register button, with tag and place on screen with registerAction
        UIButton *myButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        myButton.tag = 800;
        myButton.frame = CGRectMake(20, 20, 200, 44); // position in the parent view and set the size of the button
        [myButton setTitle:@"Register" forState:UIControlStateNormal];
        [myButton addTarget:self action:@selector(register:) forControlEvents:UIControlEventTouchUpInside];
        [self updateLabelWithString:@"No Account Defined." forTag:100];
        [self updateLabelWithString:@"Please Register." forTag:101];
        [self.view addSubview:myButton];
        
        
    } else {
        
        // Call
        // show functions, create Call Button, with tag and place on screen
        // update phone number field with account number
        UIButton *myButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        myButton.tag = 800;
        myButton.frame = CGRectMake(20, 20, 200, 44); // position in the parent view and set the size of the button
        [myButton setTitle:@"Call" forState:UIControlStateNormal];
        [myButton addTarget:self action:@selector(call:) forControlEvents:UIControlEventTouchUpInside];
        
        // set Text and Status
        [self updateLabelWithString:[accountDetails objectForKey:@"account"] forTag:100];
        [self updateLabelWithString:[accountDetails objectForKey:@"Ready..."] forTag:101];
        [self.view addSubview:myButton];
    }
}

- (void)updateTextLabels
{
    // set Text and Status
    [self updateLabelWithString:[accountDetails objectForKey:@"account"] forTag:100];
    [self updateLabelWithString:[accountDetails objectForKey:@"Ready..."] forTag:101];
    
}

- (void)updateLabelWithString:(NSString*)newString forTag:(int)tagNumber
{
    UILabel *number = (UILabel*)[self.view viewWithTag:tagNumber];
    [number setText:newString];

}

- (NSString*)getLabelWithString:(int)tagNumber
{
    UILabel *number = (UILabel*)[self.view viewWithTag:tagNumber];
    return [number text];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (IBAction)removeNumberAction:(id)sender {
    
    NSDictionary *dataDictionary = [[NSDictionary alloc] init];
    dataDictionary = [fakeCall removeAccount:[self getLabelWithString:100]];
    
    // isValid - {"message":"Account 1234567890 removed."}
    if ([[dataDictionary objectForKey:@"message"] isEqualToString:[NSString stringWithFormat:@"Account %@ removed.",[self getLabelWithString:100]]]) {
        
        // remove NSUserDefaults
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"accountDetails"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // update Display
        [self showCallOrRegistrationButton];
        
    } else {
        // error
        [self updateLabelWithString:@"Error Removing Number!" forTag:101];
    }  
    [dataDictionary release];
    
}

- (IBAction)changePasswordAction:(id)sender {
    
    // pushViewController to register user
    PasswordViewController *passwordViewController = [[PasswordViewController alloc] initWithNibName:@"PasswordViewController" bundle:nil];
    [self.navigationController pushViewController:passwordViewController animated:YES];
    [passwordViewController release];
    
}


- (IBAction)authorizeNumberAction:(id)sender {
    
    // listViewController
    ListViewController *listViewController = [[ListViewController alloc] initWithNibName:@"ListViewController" bundle:nil];
    [self.navigationController pushViewController:listViewController animated:YES];
    [listViewController release];

    
}

- (IBAction)register:(id)sender
{
    // pushViewController to register user
    RegisterViewController *registerViewController = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:registerViewController animated:YES];
    [registerViewController release];
    
}


- (IBAction)call:(id)sender
{
    // call 
    NSDictionary *dataDictionary = [[NSDictionary alloc] init];
    dataDictionary = [fakeCall call:[self getLabelWithString:100]];
    
    // isValid
    
    [dataDictionary release];
 }

- (IBAction)callAnotherNumber:(id)sender
{
    // listViewController
    CallAnotherNumber *viewController = [[CallAnotherNumber alloc] initWithNibName:@"CallAnotherNumber" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
  
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    fakeCall = [FCLibrary sharedSingleton];
    
    // set Call/Reg button
    [self showCallOrRegistrationButton];
    
    // set Text and Status
    [self updateTextLabels];
}

- (void)viewDidUnload
{
    [btnRemoveNumber release];
    btnRemoveNumber = nil;
    [btnChangePassword release];
    btnChangePassword = nil;
    [btnAuthorizeNumber release];
    btnAuthorizeNumber = nil;
    [accountDetails release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self showCallOrRegistrationButton];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    // Configure the cell.
    cell.textLabel.text = NSLocalizedString(@"Detail", @"Detail");
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.detailViewController) {
        self.detailViewController = [[[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil] autorelease];
    }
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

@end
