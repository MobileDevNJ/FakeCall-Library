//
//  ListViewController.m
//  fclibrary
//
//  Created by Neo Neo on 12/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CallAnotherNumber.h"
#import "FCLibrary.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"


#define TAG_OFFSET 100

@implementation CallAnotherNumber

@synthesize myTableView;
@synthesize listArray, myNumber, fakeCall, savedIndexPath;

- (id)init
{
    self = [super init];
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

- (void)dealloc
{
    [myTableView release];
    [fakeCall release];
    [listArray release];
    [myNumber release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc]
                               initWithTitle:@"Call" style:UIBarButtonItemStylePlain target:self action:@selector(action:)];
    
    self.navigationItem.rightBarButtonItem = button;
    [button release];
    
    fakeCall = [[FCLibrary alloc] init];
    listArray = [[NSArray arrayWithObject:@"Not Implemented"] retain];
    
    // get list of authorized numbers
//    NSDictionary *accountDetails = [[NSDictionary alloc] init];
//    accountDetails = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"accountDetails"];
//    NSDictionary *dataDictionary = [NSDictionary dictionary];
//    dataDictionary = [[fakeCall listAuthorizedNumbers:[accountDetails objectForKey:@"account"]] retain];
//    listArray = [dataDictionary objectForKey:@"list"];
}


- (void)action:(id)sender
{
    NSDictionary *dataDictionary = [fakeCall call:[myNumber text]];    
    // check error message (example) -> {"message":"you are not authorized on 9087910535"}
    if ([[dataDictionary objectForKey:@"message"] isEqualToString:[NSString stringWithFormat:@"you are not authorized on %@", [myNumber text]]]) {
        [self showAlert];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewDidUnload
{
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Call log";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [listArray count];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // dismisss keyboard
    [textField resignFirstResponder];
    return NO;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    [cell.textLabel setText:[listArray objectAtIndex:indexPath.row]];
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        // remove authorized number
        [fakeCall  removeAuthorizedNumber:[listArray objectAtIndex:indexPath.row]];
        
        [listArray removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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

- (void)showAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You are not authorized to call this number" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        // call number at indexPath
        UITableViewCell *cell = [myTableView cellForRowAtIndexPath:savedIndexPath];
        [fakeCall call:cell.textLabel.text];
        
    }
    
    [myTableView deselectRowAtIndexPath:savedIndexPath animated:YES];
    
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    savedIndexPath = indexPath;
    
    
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
