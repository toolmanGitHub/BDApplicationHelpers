//
//  BDPickerViewController.m
//  How Many Days
//
//  Created by Tim Taylor on 7/28/10.
//  Copyright (c) 2011 Big Diggy SW. All rights reserved.
//
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


#import "BDPickerViewController.h"

@interface BDPickerViewController () 

@property (nonatomic,strong) IBOutlet UIPickerView *pickerView;
@property (nonatomic,strong) IBOutlet UILabel *pickerViewLabel;
@property (nonatomic,strong) IBOutlet UIButton *doneButton;

-(void)useDoneButton;
-(IBAction)doneButtonPushed:(id)sender;

@end

@implementation BDPickerViewController
// Private
@synthesize pickerView;
@synthesize pickerViewLabel;
@synthesize doneButton;

// Public
@synthesize numberOfComponentsInPickerViewBlock;
@synthesize numberOfRowsInComponentBlock;
@synthesize rowHeightForComponentBlock;
@synthesize widthForComponentBlock;
@synthesize titleForRowBlock;
@synthesize didSelectRowComponentBlock;

#pragma mark -
#pragma mark BDInputViewControllerProtocol methods

-(BDInputViewType)inputViewType{
    return BDInputViewTypePicker;
}
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    	doneButtonPushedCallbackBlock=nil;
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
						doneButtonPushedCallbackBlock:(buttonPushedCallbackBlock)doneButtonBlock
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		doneButtonPushedCallbackBlock=doneButtonBlock;
    }
    return self;
}

-(id)init{
    NSString *nibName=@"BDPickerViewController_iPad";;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        nibName=@"BDPickerViewController_iPhone";
    }
    self = [super initWithNibName:nibName bundle:nil];
    if (self) {
        doneButtonPushedCallbackBlock=nil;
    }
    return self;
}



/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self useDoneButton];
    }
    
}


-(void)useDoneButton{
	[self.doneButton setTitle:NSLocalizedString(@"Done",@"Done") forState:UIControlStateNormal];
	self.doneButton.hidden=NO;
}


#pragma mark -
#pragma mark IBActions

-(IBAction)doneButtonPushed:(id)sender{
       self.doneButtonPushedCallbackBlock();
}

#pragma mark -
#pragma mark   UIPickerView Data Source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView{
	if (numberOfComponentsInPickerViewBlock!=nil) {
		return numberOfComponentsInPickerViewBlock(thePickerView);
	}else {
		[NSException raise:@"BDPickerViewController Exception" format:@"BDPickerNumberOfRowsInComponentBlock numberOfRowsInComponentBlock"];
	}
	return 0;
	
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component{
	if (numberOfRowsInComponentBlock!=nil) {
		return numberOfRowsInComponentBlock(thePickerView,component);
	}else {
		[NSException raise:@"BDPickerViewController Exception" format:@"BDPickerNumberOfRowsInComponentBlock numberOfRowsInComponentBlock"];
	}
	return 0;
}

#pragma mark   UIPickerView Delegate
- (CGFloat)pickerView:(UIPickerView *)thePickerView rowHeightForComponent:(NSInteger)component{
 	if (rowHeightForComponentBlock!=nil) {
		return rowHeightForComponentBlock(thePickerView,component);
	}
	return 35.0;
}

- (CGFloat)pickerView:(UIPickerView *)thePickerView widthForComponent:(NSInteger)component{
	if (widthForComponentBlock!=nil) {
		return widthForComponentBlock(thePickerView,component);
	}
	else {
		[NSException raise:@"BDPickerViewController Exception" format:@"BDPickerWidthForComponentBlock widthForComponentBlock"];
	}
	return thePickerView.frame.size.width-25;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	if (titleForRowBlock!=nil) {
		return titleForRowBlock(thePickerView, row, component);
	}else {
		[NSException raise:@"BDPickerViewController Exception" format:@"BDPickerTitleForRowBlock titleForRowBlock not set"];
	}

	return @"something is wrong";
	
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
 	if (didSelectRowComponentBlock!=nil) {
		didSelectRowComponentBlock(thePickerView,row,component);
	}else {
		NSLog(@"No Block Specified for pickerViewDidSelectRowComponent");
	}

	
	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
 //   [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	self.pickerView=nil;
	self.pickerViewLabel=nil;
	self.doneButton=nil;
}




@end
