//
//  BDPickerViewController.m
//  How Many Days
//
//  Created by Tim Taylor on 7/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BDPickerViewController.h"
#import "BDInputViewController.h"

@interface BDPickerViewController () 

@property (nonatomic,strong) IBOutlet UIPickerView *pickerView;
@property (nonatomic,strong) IBOutlet UILabel *pickerViewLabel;
@property (nonatomic,strong) IBOutlet UIButton *doneButton;

-(void)useDoneButton;
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
-(void)dismissViewControllerCallbackBlock:(dismissCallBackBlock)callback{
    self.doneButtonPushedCallbackBlock=callback;
}
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
