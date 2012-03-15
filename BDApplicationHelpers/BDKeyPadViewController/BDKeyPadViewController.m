    //
//  BDKeyPadViewController.m
//  How Many Days
//
//  Created by Tim Taylor on 8/4/10.
//  Copyright 2010 Big Diggy SW. All rights reserved.
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

#import "BDKeyPadViewController.h"
#import "BDDateTimeNumberFormatter.h"

#define ANIMATIONDURATION 0.5
#define FOCUS_INDICATOR_NORMAL_POSITION_IPHONE 295.0
#define FOCUS_INDICATOR_NORMAL_POSITION_IPAD 291

enum  {
	BDKeyPadButtonIdentifierCancel=-1,
	BDKeyPadButtonIdentifierBackspace=-2,
	BDKeyPadButtonIdentifierDoubleZero=-3,
	BDKeyPadButtonIdentifierDone=-4,
};
typedef NSInteger BDKeyPadButtonIdentifier;

@interface BDKeyPadViewController ()
@property (nonatomic,strong) IBOutlet UITextField *popoverTextField;
@property (nonatomic,strong) IBOutlet UIImageView *focusIndicator;

@property (nonatomic,strong) NSTimer *keyStrokeTimer;
@property (nonatomic,strong) IBOutlet UIButton *cancelDoneButton;

@property (nonatomic,strong) IBOutlet UIView *swipeInterceptorView;

-(IBAction)keyPadButtonPressed:(id)sender;
-(void)animateFocusIndicator;
-(void)alertForPotentialLargeNumber;
-(void)useDoneButton;
-(void)enterForegroundActions;
// Text Input Handling
//- (NSDecimalNumber *)unlocalizedDoubleForString:(NSString *)string;
- (NSString *)stringByAppendingCharacters:(NSString *)aCharacters toText:(NSString *)text characterLimit:(int)characterLimit;



    
@end

@implementation BDKeyPadViewController

// Private
@synthesize popoverTextField;
@synthesize focusIndicator;
@synthesize keyStrokeTimer;
@synthesize cancelDoneButton;
@synthesize swipeInterceptorView;

//Public
@synthesize numberDecimalPlaces=numberDecimalPlaces_;
@synthesize outputCallbackBlock;
@synthesize numberFormatType;
@synthesize popoverTextFieldString;
@synthesize keyPadTitleLabel;

#pragma mark -
#pragma mark Initialization Methods
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)init{
    NSString *nibName=@"BDKeyPadViewController_iPad";
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        nibName=@"BDKeyPadViewController_iPhone";
    }
    self = [super initWithNibName:nibName bundle:nil];
    if (self) {
    	doneButtonPushedCallbackBlock=nil;
        outputCallbackBlock=nil;
        numberFormatType=BDNumberFormatterTypeNothing;
        [self enterForegroundActions];
    }
    return self;
}


-(void)setNumberFormatType:(BDNumberFormatterType)theFormatType{
	NSRange currencySymbolRange;
	NSRange decimalSeparatorRange;
	CGSize theFontSize;
	CGFloat offset=0.0;
	CGFloat requiredFocusIndicatorLocation=0;
    self.popoverTextField.text=self.popoverTextFieldString;
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
  		requiredFocusIndicatorLocation=FOCUS_INDICATOR_NORMAL_POSITION_IPHONE;
	}else {
  		requiredFocusIndicatorLocation=FOCUS_INDICATOR_NORMAL_POSITION_IPAD;
	}
	
	NSRange spaceRange;
	NSString *currencySymbol=nil;
	NSString *decimalSeparator=nil;
    //NSLog(@"old numberformat:  %d, new format:  %d", numberFormatType,theFormatType);
	switch (theFormatType) {
		case BDNumberFormatterTypePercentage:
        {
            spaceRange=[self.popoverTextField.text rangeOfString:@" "];
			if (spaceRange.location==NSNotFound) {
				theFontSize=[@"%" sizeWithFont:self.popoverTextField.font];
			}else {
				theFontSize=[@" %" sizeWithFont:self.popoverTextField.font];
			}
			requiredFocusIndicatorLocation=requiredFocusIndicatorLocation-theFontSize.width;
			break;
        }
		case BDNumberFormatterTypeCurrency:
        {
            currencySymbol=[[BDDateTimeNumberFormatter currencyDecimalFormatter] currencySymbol];
            decimalSeparator=[[BDDateTimeNumberFormatter currencyDecimalFormatter] decimalSeparator];
            currencySymbolRange=[self.popoverTextField.text rangeOfString:currencySymbol];
            decimalSeparatorRange=[self.popoverTextField.text rangeOfString:decimalSeparator];
   		if (currencySymbolRange.location > decimalSeparatorRange.location) {
   			spaceRange=[self.popoverTextField.text rangeOfString:@" "];
				if (spaceRange.location==NSNotFound) {
   				theFontSize=[currencySymbol sizeWithFont:self.popoverTextField.font];
				}else {
   				theFontSize=[[NSString stringWithFormat:@" %@",currencySymbol] sizeWithFont:self.popoverTextField.font];
				}
            	requiredFocusIndicatorLocation=requiredFocusIndicatorLocation-theFontSize.width;
				
			}
            
			break;
        }
	}
	offset=self.focusIndicator.frame.origin.x-requiredFocusIndicatorLocation;
    
	self.focusIndicator.frame=CGRectOffset(self.focusIndicator.frame, -offset, 0);
	numberFormatType=theFormatType;
	
}

-(void)useDoneButton{
  	[self.cancelDoneButton setTitle:NSLocalizedString(@"Done",@"Done") forState:UIControlStateNormal];
	[self.cancelDoneButton setBackgroundImage:[UIImage imageNamed:@"doneButtonStateUp.png"] forState:UIControlStateNormal];
	self.cancelDoneButton.tag=BDKeyPadButtonIdentifierDone;
	
}

#pragma mark -
#pragma mark BDInputViewControllerProtocol methods
/*
-(void)setDismissViewControllerCallbackBlock:(dismissCallBackBlock)callbackBlock{
 // override if necessary.  Otherwise BDInputViewController handles it for you.
}
 */
-(BDInputViewType)inputViewType{
    return BDInputViewTypeNumberKeyPad;
}


#pragma mark -
#pragma mark View Lifecycle
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.swipeInterceptorView.backgroundColor=[UIColor clearColor];
    UISwipeGestureRecognizer *rightSwipe=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(textFieldSwiped:)];
    rightSwipe.direction=UISwipeGestureRecognizerDirectionRight;
    
    UISwipeGestureRecognizer *leftSwipe=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(textFieldSwiped:)];
    leftSwipe.direction=UISwipeGestureRecognizerDirectionLeft;
 
    self.swipeInterceptorView.opaque=YES;
    [self.swipeInterceptorView addGestureRecognizer:leftSwipe];
    [self.swipeInterceptorView addGestureRecognizer:rightSwipe];
    self.popoverTextField.text=popoverTextFieldString;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self useDoneButton];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(enterForegroundActions) 
                                                 name:UIApplicationWillEnterForegroundNotification 
                                               object:nil];
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
    //    NSLog(@"BDKeyPadViewController viewDidUnload start");
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationWillEnterForegroundNotification
                                                  object:nil];

    self.popoverTextField=nil;
	self.focusIndicator=nil;
	self.keyPadTitleLabel=nil;
	self.cancelDoneButton=nil;
    self.swipeInterceptorView=nil;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.popoverTextField.text=self.popoverTextFieldString;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self animateFocusIndicator];
	//NSLog(@"calling animatefocusIndicator ");
}



#pragma mark -
#pragma mark Application Events

-(void)enterForegroundActions{
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    //    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

-(void)animateFocusIndicator{
	float alpha=1.0;
	
	self.focusIndicator.alpha=0.0;
	[UIView animateWithDuration:ANIMATIONDURATION delay:0
						options:(UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse|UIViewAnimationOptionAllowUserInteraction)
					 animations:^{
						 focusIndicator.alpha=alpha;
					 }
					 completion:nil];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(void)timerFireMethod:(NSTimer *)theTimer{
	self.keyStrokeTimer=nil;
	NSString *stringText=self.popoverTextField.text;
	NSInteger theTag=self.popoverTextField.tag;
	if (outputCallbackBlock!=nil) {
		outputCallbackBlock(stringText,theTag);
	}else {
		NSLog(@"BDKeyPadViewController->timerFireMethod: no outputCallbackBlock set!");
	}

	
}




-(void)alertForPotentialLargeNumber{
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Large Calculated Number Warning",@"")
														message:NSLocalizedString(@"You've entered a percentage which could potentially cause an unrealistically large number to be calculated.  You may want to change the value to something less than 100%.",@"")					
													   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
	
	
}

#pragma mark -
#pragma mark Text Input Methods

-(IBAction)keyPadButtonPressed:(id)sender{
	UIButton *button=sender;
	NSString *theDigit=nil;
	NSString *newString=nil;
	
    [self.keyStrokeTimer invalidate];
    self.keyStrokeTimer=nil;
    
	switch (button.tag) {
		case BDKeyPadButtonIdentifierCancel:
		{
            // reserved for future use.
            break;
        }
        case BDKeyPadButtonIdentifierBackspace:
        {
            newString=[self stringByAppendingCharacters:@""
												 toText:self.popoverTextField.text
										 characterLimit:15];
			self.popoverTextField.text=newString;
    		break;

        }
        case BDKeyPadButtonIdentifierDoubleZero:
        {
            NSInteger j;
            NSString *theOtherDigit=nil;
            NSString *theNewString=nil;
            for (j=1; j<=2; j++) {
                theOtherDigit=[NSString stringWithFormat:@"0"];
                theNewString=[self stringByAppendingCharacters:theOtherDigit
                                                        toText:self.popoverTextField.text
                                                characterLimit:15];
                self.popoverTextField.text=theNewString;
                if (numberFormatType==BDNumberFormatterTypePercentage) {
                    NSNumber *percentageValue=[[BDDateTimeNumberFormatter percentageDecimalFormatterWithNumberOfFractionalDigits:2] numberFromString:theNewString];
                    if (percentageValue.doubleValue>=1) {
                        [self alertForPotentialLargeNumber];
                    }
                    percentageValue=nil;
                    
                }
            }
            //		printf("%u, iCntr=%d\n", i,iCntr);
               
			newString=nil;
			theDigit=nil;
			break;

        }
		case BDKeyPadButtonIdentifierDone:
        {
            if (doneButtonPushedCallbackBlock!=nil) {
				doneButtonPushedCallbackBlock();
			}
            break;
        }
			
            
		default:
        {
            theDigit=[NSString stringWithFormat:@"%d",button.tag];
			newString=[self stringByAppendingCharacters:theDigit
												 toText:self.popoverTextField.text
										 characterLimit:15];
			self.popoverTextField.text=newString;
     		if (numberFormatType==BDNumberFormatterTypePercentage) {
				NSNumber *percentageValue=[[BDDateTimeNumberFormatter percentageDecimalFormatterWithNumberOfFractionalDigits:2] numberFromString:newString];
				if (percentageValue.doubleValue>=1) {
					[self alertForPotentialLargeNumber];
				}
				percentageValue=nil;
				
			}
			newString=nil;
			theDigit=nil;
			break;

        }
    }
    self.keyStrokeTimer=[NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:NO] ;
}

-(void)textFieldSwiped:(UISwipeGestureRecognizer *)gesture{
    NSNumberFormatter *theFormatter=nil;
	NSDecimalNumber *minusOneDecimal=[NSDecimalNumber decimalNumberWithString:@"-1"];
    NSDecimalNumber *theDecimalNumber=nil;
    if (self.numberFormatType==BDNumberFormatterTypeDecimal) {
        theFormatter=[BDDateTimeNumberFormatter plainDecimalFormatterWithNumberOfFractionalDigits:3];
        theDecimalNumber=(NSDecimalNumber *)[theFormatter numberFromString:self.popoverTextField.text];
        self.popoverTextField.text=[theFormatter stringFromNumber: [theDecimalNumber decimalNumberByMultiplyingBy:minusOneDecimal]];
        [self timerFireMethod:nil];
    }
    
}

/*
- (NSDecimalNumber *)unlocalizedDoubleForString:(NSString *)string{
	NSDecimal theDecimal;
	NSScanner *scanner = [NSScanner localizedScannerWithString:string];
    [scanner setLocale:[NSLocale currentLocale]];
	[scanner scanDecimal:&theDecimal];
	NSDecimalNumber *myDecimalNumber=[NSDecimalNumber decimalNumberWithDecimal:theDecimal];
	return myDecimalNumber;
}
*/
- (NSString *)stringByAppendingCharacters:(NSString *)aCharacters toText:(NSString *)text characterLimit:(int)characterLimit{
	
	NSInteger numberOfDecimalPlaces=numberDecimalPlaces_;
	
	// Assume currency is going to be the number formatter
	NSNumberFormatter *numberFormatter=[BDDateTimeNumberFormatter currencyDecimalFormatterWithLocal:[NSLocale currentLocale]];
    NSDecimalNumberHandler *roundingBehavior = nil;
    switch (self.numberFormatType){
        case BDNumberFormatterTypePercentage:
            numberFormatter=[BDDateTimeNumberFormatter percentageDecimalFormatterWithNumberOfFractionalDigits:2];
            roundingBehavior =[[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundPlain scale:(numberOfDecimalPlaces+1) raiseOnExactness:YES raiseOnOverflow:YES raiseOnUnderflow:YES raiseOnDivideByZero:NO];
            break;
        case BDNumberFormatterTypeDecimal:
            numberFormatter=[BDDateTimeNumberFormatter plainDecimalFormatterWithNumberOfFractionalDigits:numberOfDecimalPlaces];
           roundingBehavior = [[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundDown scale:(numberOfDecimalPlaces+1) raiseOnExactness:YES raiseOnOverflow:YES raiseOnUnderflow:YES raiseOnDivideByZero:NO];
            
            break;
        case BDNumberFormatterTypeCurrency:
            // we need to check to see if the currency has decimals, like Japan and the Yen which does not have decimals. 
            // the following line of code ensures we don't have that problem.
            
            numberOfDecimalPlaces=[numberFormatter maximumFractionDigits];
                        
            roundingBehavior =[[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundDown scale:(numberOfDecimalPlaces) raiseOnExactness:YES raiseOnOverflow:YES raiseOnUnderflow:YES raiseOnDivideByZero:NO];
            break;
    }
   
    NSNumber *numberFromText=[numberFormatter numberFromString:text];
    
    NSDecimalNumber *decimalFromText=[NSDecimalNumber decimalNumberWithDecimal:[numberFromText decimalValue]];

    NSDecimalNumber *returnDecimal=nil;
    if ([aCharacters compare:@""]==NSOrderedSame){
        returnDecimal=[decimalFromText decimalNumberByMultiplyingByPowerOf10:-1 withBehavior:roundingBehavior];
    }else{
        NSDecimalNumber *leftOperandDecimal=[decimalFromText decimalNumberByMultiplyingByPowerOf10:1];
        NSDecimalNumber *newDecimal=[NSDecimalNumber decimalNumberWithString:aCharacters];
        NSDecimalNumber *rightOperandDecimal=[newDecimal decimalNumberByMultiplyingByPowerOf10:-numberOfDecimalPlaces];
       
        returnDecimal=[rightOperandDecimal decimalNumberByAdding:leftOperandDecimal];
    }
    return [numberFormatter stringFromNumber:returnDecimal];
}
@end
