//
//  ViewController.m
//  applicationHelpers
//
//  Created by Tim Taylor on 5/17/11.
//  Copyright 2011 Big Diggy SW. All rights reserved.//

/*
 
 The below license is the new BSD license with the OSI recommended personalizations.
 <http://www.opensource.org/licenses/bsd-license.php>
 
 Copyright (C) 2011 Big Diggy SW. All Rights Reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are
 met:
 
 * Redistributions of source code must retain the above copyright notice,
 this list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 
 * Neither the name of Tim Taylor nor Big Diggy SW 
 may be used to endorse or promote products derived from this software
 without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY Big Diggy SW "AS IS" AND ANY
 EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
 CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ViewController.h"
#import <BDApplicationHelpers/BDHelpViewController.h>

@implementation ViewController
@synthesize helpViewController = helpViewController_;
@synthesize popoverController = popoverController_;


- (void)didReceiveMemoryWarning
{
    NSLog(@"didReceiveMemoryWarning");
    [super didReceiveMemoryWarning];
    if (!popoverController_.isPopoverVisible) {
        self.helpViewController=nil;
        helpViewController_=nil;
        self.popoverController=nil;
        popoverController_=nil;
    }
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (IBAction)showHelpViewController:(id)sender {
    
   
    
    __block __weak ViewController *weakSelf = self;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        // We are on an iPhone
        self.helpViewController.doneButtonPushedCallbackBlock=^{
            ViewController *strongSelf=weakSelf;
            [strongSelf dismissModalViewControllerAnimated:YES];
        };
        self.helpViewController.emailButtonPushedCallbackBlock=^{
            ViewController *strongSelf=weakSelf;
            NSLog(@"emailButtonPushedCallback Block");
            [strongSelf dismissModalViewControllerAnimated:NO];
            [strongSelf displayMailComposer];
        };
        self.helpViewController.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentModalViewController:self.helpViewController animated:YES];
        });
        
    }else{
        // We are on an iPad
        UIButton *theButton=sender;
        
        // setup popoverController
        [self.popoverController setContentViewController:self.helpViewController];
        
        self.helpViewController.doneButtonPushedCallbackBlock=^{
            ViewController *strongSelf=weakSelf;
            [strongSelf.popoverController dismissPopoverAnimated:YES];
            
        };
        self.helpViewController.emailButtonPushedCallbackBlock=^{
            ViewController *strongSelf=weakSelf;
            [strongSelf.popoverController dismissPopoverAnimated:YES];
            [strongSelf displayMailComposer];
        };
        
        self.popoverController.popoverContentSize=self.helpViewController.view.frame.size;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.popoverController presentPopoverFromRect:theButton.bounds inView:theButton permittedArrowDirections: UIPopoverArrowDirectionAny animated:YES];
            
        });
        
    }
    [self.helpViewController loadDocument: @"appHelpScreeniPhone.html"];
        

}

#pragma mark -
#pragma mark MFMailComposeViewController Methods

// Displays an email composition interface inside the application. Populates all the Mail fields. 
-(void)displayMailComposer{
	//	NSLog(@"display mailcomposer");
	MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
	mailComposer.mailComposeDelegate = self;	
	mailComposer.modalTransitionStyle= UIModalTransitionStyleCoverVertical;
	// Set up recipients
	NSArray *toRecipients = [NSArray arrayWithObject:@"myGreatAppSupport@myGreatApp.com"]; 
	
	
	[mailComposer setToRecipients:toRecipients];
	
	// Attach an image to the email
	/*	NSString *path = [[NSBundle mainBundle] pathForResource:@"rainy" ofType:@"png"];
	 NSData *myData = [NSData dataWithContentsOfFile:path];
	 [mailComposer addAttachmentData:myData mimeType:@"image/png" fileName:@"rainy"];
	 */	
	
	// Fill out the email body text
	NSString *emailBody = @"";
	[mailComposer setMessageBody:emailBody isHTML:NO];
	//		NSLog(@"  mail composer view frame:  %@",NSStringFromCGRect(mailComposer.view.frame));
	
	[self presentModalViewController:mailComposer animated:YES];
	//	NSLog(@"  mail composer view frame:  %@",NSStringFromCGRect(mailComposer.view.frame));
	
}

// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	// Notifies users about errors associated with the interface
	//	NSLog(@"display mailcomposer");
	
	switch (result)
	{
		case MFMailComposeResultCancelled:
			NSLog(@"Result: canceled");
			break;
		case MFMailComposeResultSaved:
			NSLog(@"Result: saved");
			break;
		case MFMailComposeResultSent:
			NSLog(@"Result: sent");
			break;
		case MFMailComposeResultFailed:
			NSLog(@"Result: failed");
			break;
		default:
			NSLog(@"Result: not sent");
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
	
}



#pragma mark -
#pragma mark BDInformationViewController


// Lazily created
-(BDHelpViewController *)helpViewController{
	//	static 
    if (helpViewController_!=nil) {
        return helpViewController_;
    }
 
    
    helpViewController_=[[BDHelpViewController alloc] init];
    
    self.helpViewController.supportDictionary=[NSDictionary dictionaryWithObjectsAndKeys:@"http://bigdiggy.wordpress.com/support",BDSupportURLStringKey,
											   @"Support for Wonderful app is provided by via email and via the support website.",BDSupportStringKey,
											   @"yourSupportAddress@wonderfulapp.com",BDSupportEmailStringKey,
											   @"app",BDURLRejectStringKey,nil];
    
    
      helpViewController_.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
		
	return helpViewController_;
}

#pragma mark -
#pragma mark UIPopoverController
-(UIPopoverController *)popoverController{
    if (popoverController_!=nil) {
        return popoverController_;
    }
    popoverController_=[[UIPopoverController alloc] initWithContentViewController:[[UIViewController alloc] init]];
    return popoverController_;
}


@end
