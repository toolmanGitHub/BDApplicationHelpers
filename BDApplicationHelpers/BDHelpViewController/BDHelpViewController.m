//
//  BDHelpViewController.m
//
//  Created by Tim Taylor on 10/22/11.
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


#import "BDHelpViewController.h"
#import "BDIconImageView.h"
#import "BDLowerToolBarView.h"


static NSString *BDHelpViewControllerVersion=@"v1.9";
NSString *BDSupportURLStringKey=@"BDSupportURLStringKey";
NSString *BDSupportStringKey=@"BDSupportStringKey";
NSString *BDSupportEmailStringKey=@"BDSupportEmailStringKey";
NSString *BDURLRejectStringKey=@"BDURLRejectStringKey";
NSString *BDUserDefaultsBoolKey=@"BDUserDefaultsBoolKey";

@interface BDHelpViewController () {
		
}

@property (nonatomic, strong) IBOutlet UIWebView *infoWebView;
@property (nonatomic, strong) IBOutlet UIButton *versionButton;
@property (nonatomic, strong) IBOutlet UIButton *emailSupportButton;
@property (nonatomic, strong) IBOutlet UIButton *doneButton;
@property (nonatomic, strong) IBOutlet UIView *transparentButtonView;
@property (nonatomic, strong) IBOutlet UIView *secondTransparentButtonView;
@property (nonatomic, strong) NSString *versionString;
@property (nonatomic, strong) NSString *buildString;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) IBOutlet UILabel *helpControllerVersionLabel;
@property (strong, nonatomic) IBOutlet BDIconImageView *customIconView;

-(IBAction)dismissInformationViewController:(id)sender;
-(IBAction)toggleVersionBuild:(UIButton *)sender;
-(IBAction)supportButtonPushed:(id)sender;

@end // interface BDInformationViewController ()

@implementation BDHelpViewController
// private
@synthesize infoWebView;
@synthesize versionButton;
@synthesize emailSupportButton;
@synthesize doneButton;
@synthesize transparentButtonView;
@synthesize secondTransparentButtonView;
@synthesize versionString;
@synthesize buildString;@synthesize activityIndicatorView;
@synthesize helpControllerVersionLabel;
@synthesize customIconView = customIconView_;

// Public
@synthesize supportDictionary=supportDictionary_;
@synthesize doneButtonPushedCallbackBlock=doneButtonPushedCallbackBlock_;
@synthesize emailButtonPushedCallbackBlock=emailButtonPushedCallbackBlock_;
@synthesize customIconFileName = customIconFileName_;


-(id)init{
    NSLog(@"init");
    
    return [self initWithDoneButtonCallbackBlock: nil
                 emailButtonPushedCallbackBlock: nil];
}

- (id)initWithDoneButtonCallbackBlock:(buttonPushedCallbackBlock)doneButtonBlock
                       emailButtonPushedCallbackBlock:(buttonPushedCallbackBlock)emailButtonBlock{
   NSLog(@"initWithDoneButtonCallbackBlock");
    NSString *nibName=nil;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        nibName=@"BDHelpViewController";
    }else {
        nibName=@"BDHelpViewController_iPad";
    }
    self = [super initWithNibName:nibName bundle:nil];
    
    if (self) {
        // Custom initialization
        supportDictionary_=nil;
		doneButtonPushedCallbackBlock_=[doneButtonBlock copy];
		emailButtonPushedCallbackBlock_=[emailButtonBlock copy];
    }
    return self;
}

-(NSDictionary *)supportDictionary{
    //	NSLog(@"using support dictionary");
	if (supportDictionary_==nil) {
		NSDictionary *theSupportDictionary=[[NSDictionary alloc] initWithObjectsAndKeys:@"http://bigdiggy.wordpress.com/support",BDSupportURLStringKey,
											@"Support for this app is provided by via email and via the support website.",BDSupportStringKey,
											@"yourEmailAddress@gmail.com",BDSupportEmailStringKey,
											@"basic",BDURLRejectStringKey,nil];
		self.supportDictionary=theSupportDictionary;
		
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"BDInformationViewController Error" 
                                                            message: @"You have not supplied the necessary information in the BDInformationViewController supportDictionary!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
		[alertView show];
		
	}
	return supportDictionary_;
}

-(void)loadDocument:(NSString*)documentName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:documentName ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy: NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:1 ];
    [self.infoWebView loadRequest:request];
}


#pragma mark -
#pragma mark View Management

- (void)viewDidLoad {
    [super viewDidLoad];
    [BDLowerToolBarView class];
    [BDIconImageView class];
    
	self.versionString=[NSString stringWithFormat:@"v%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
	self.buildString=[NSString stringWithFormat:@"Build: %@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]];
	[versionButton setTitle:versionString forState:UIControlStateNormal];
	versionButton.tag=0;
	[activityIndicatorView startAnimating];
	self.infoWebView.opaque=NO;
	self.view.backgroundColor=[UIColor clearColor];
	self.infoWebView.backgroundColor=[UIColor clearColor];
	self.transparentButtonView.alpha=0.7;
	self.secondTransparentButtonView.alpha=0.3;
	
	self.helpControllerVersionLabel.text=[NSString stringWithFormat:@"BD Help %@",BDHelpViewControllerVersion];;
	self.helpControllerVersionLabel.alpha=1.0;
    
    self.customIconView.imageFileName=self.customIconFileName;
	
	
}

-(void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	
	if ( self.emailButtonPushedCallbackBlock==nil || self.doneButtonPushedCallbackBlock==nil ) {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"BDInformationViewController Error" 
															 message: @"Either emailButtonPushedCallbackBlock or doneButtonPushedCallbackBlock have not been set by the calling class/view"
															delegate:nil
												   cancelButtonTitle:@"Ok"
												   otherButtonTitles:nil];
		[alertView show];
	}
}

- (void)viewDidUnload {
    [self setCustomIconView:nil];
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.infoWebView=nil;
	self.versionButton=nil;
	self.emailSupportButton=nil;
	self.doneButton=nil;
	self.transparentButtonView=nil;
	self.secondTransparentButtonView=nil;
	self.activityIndicatorView=nil;
	self.helpControllerVersionLabel=nil;
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
//		return UIInterfaceOrientationIsPortrait(interfaceOrientation);
//	}
	return YES;
	
}

#pragma mark -
#pragma mark IBAction Methods
-(IBAction)toggleVersionBuild:(UIButton *)sender{
	if (sender.tag==0) {
		[sender setTitle:buildString forState:UIControlStateNormal];
		sender.tag=1;
	}else {
		[sender setTitle:versionString forState:UIControlStateNormal];
		sender.tag=0;
	}	
}

-(IBAction)dismissInformationViewController:(id)sender{
	
    NSString *userDefaultsBoolKey=[self.supportDictionary objectForKey:BDUserDefaultsBoolKey];
	if (userDefaultsBoolKey!=nil) {
		[[NSUserDefaults standardUserDefaults] setBool:YES forKey:userDefaultsBoolKey];
	}
    
    if (doneButtonPushedCallbackBlock_!=nil)
        dispatch_async(dispatch_get_main_queue(), ^{
            self.doneButtonPushedCallbackBlock();
        });
        
	
	
}

-(IBAction)supportButtonPushed:(id)sender
{
	// open a dialog with two custom buttons
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:[self.supportDictionary objectForKey:BDSupportStringKey]
															 delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",@"")
                                               destructiveButtonTitle:nil
													otherButtonTitles:NSLocalizedString(@"Go to Website",@""), NSLocalizedString(@"Send Email",@""), nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	//	actionSheet.destructiveButtonIndex = 1;	// make the second button red (destructive)
	[actionSheet showInView:self.view]; // show from our table view (pops up in the middle of the table)
}



#pragma mark -
#pragma mark UIWebView Delegate Methods

- (void)webViewDidFinishLoad:(UIWebView *)webView{
 	[activityIndicatorView stopAnimating];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
    if ([[[request URL] absoluteString] rangeOfString:[self.supportDictionary objectForKey:BDURLRejectStringKey]].location==NSNotFound)
	{
 		[[UIApplication sharedApplication] openURL:[request URL]];
		return NO;
	}   
    return YES;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark UIActionSheet Delegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	switch (buttonIndex) {
		case 0:
			// User Touched the "Go to Website button"
			[self.infoWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self.supportDictionary objectForKey:BDSupportURLStringKey]]]];
			break;
		case 1:
			// User touched the Email Button
			if (emailButtonPushedCallbackBlock_!=nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.emailButtonPushedCallbackBlock();
                });
            }
            break;

		default:
			break;
	}

}

@end
