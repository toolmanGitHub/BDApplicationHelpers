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
#import <BDApplicationHelpers/BDApplicationHelpers.h>
#import <BDApplicationHelpers/BDDateTimeNumberFormatter.h>
#import "BDPickerViewRowView.h"

@implementation ViewController
@synthesize helpViewController = helpViewController_;
@synthesize popoverController = popoverController_;
@synthesize keyPadViewController = keyPadViewController_;
@synthesize keyPadOutputDecimalLabel;
@synthesize keyPadOutputCurrencyLabel;
@synthesize keyPadOutputPercentageLabel;
@synthesize pickerViewController = pickerViewController_;
@synthesize pickerViewControllerViewForRow = pickerViewControllerViewForRow_;
@synthesize tabBarController = tabBarController_;


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
    self.keyPadOutputCurrencyLabel.text=[[BDDateTimeNumberFormatter currencyDecimalFormatterWithLocal:[NSLocale currentLocale]] stringFromNumber:[NSNumber numberWithDouble: 3.16]];
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

#pragma mark -
#pragma mark UIViewController Container Methods
- (BOOL)automaticallyForwardAppearanceAndRotationMethodsToChildViewControllers{
    return YES;
}

-(void)slideIntoPlaceInputViewController:(UIViewController *)viewController
{
    __weak __block ViewController *weakSelf=self;
    [((BDInputViewController *)viewController) setDismissViewControllerCallbackBlock:^{
        ViewController *strongSelf=weakSelf;
        [strongSelf slideOutOfPlaceInputViewController: viewController];
    }];
    CGRect inputViewFrame=viewController.view.frame;
    CGFloat inputViewHeight=inputViewFrame.size.height;
    
    CGRect newFrame=CGRectMake(0, self.view.frame.size.height, inputViewFrame.size.width, inputViewFrame.size.height);
    
    viewController.view.frame=newFrame;
    // [viewController willMoveToParentViewController:self];
    [self addChildViewController:viewController];
    
    CGRect offSetRect=CGRectOffset(newFrame, 0, -inputViewHeight);
    
    [self.view addSubview:viewController.view];
    [UIView animateWithDuration:0.2 animations:^{
        viewController.view.frame=offSetRect;
    }
                     completion:^(BOOL finished){
                         [viewController didMoveToParentViewController:self];
                     }];
    
    
    
}

-(void)slideOutOfPlaceInputViewController:(UIViewController *)viewController{
    CGRect inputViewFrame=viewController.view.frame;
    CGFloat inputViewHeight=inputViewFrame.size.height;
    
    CGRect offSetRect=CGRectOffset(inputViewFrame, 0, +inputViewHeight);
    
    [viewController willMoveToParentViewController:nil];
    [UIView animateWithDuration:0.2 animations:^{
        viewController.view.frame=offSetRect;
    }
                     completion:^(BOOL finished){
                         [viewController.view removeFromSuperview];
                         [viewController removeFromParentViewController];
                         // We also need to make sure that the viewControllers are no longer retained by the 
                         // BDTabBarController because we will get an exception if they have more than
                         // one rootViewController.  i.e. if we try to use the BDKeyPadViewController by
                         // itself just after using the BDTabBarController
                         if ([viewController isKindOfClass:[BDTabBarController class]]) {
                             NSLog(@"setting tabBarController to nil");
                             self.tabBarController=nil;
                         }
                     }];
    
}

#pragma mark -
#pragma mark IBActions

- (IBAction)showHelpViewController:(id)sender {
    
    __block __weak ViewController *weakSelf = self;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        // We are on an iPhone
        self.helpViewController.doneButtonPushedCallbackBlock=^{
            ViewController *strongSelf=weakSelf;
            [strongSelf dismissModalViewControllerAnimated:YES];
        };
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{
            self.helpViewController.emailButtonPushedCallbackBlock=^{
                ViewController *strongSelf=weakSelf;
                NSLog(@"emailButtonPushedCallback Block");
                [strongSelf dismissModalViewControllerAnimated:NO];
                [strongSelf displayMailComposer];
            };
            self.helpViewController.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentModalViewController:self.helpViewController animated:YES];
                [self.helpViewController loadDocument: @"appHelpScreeniPhone.html"];
            });
        });
        
        
    }else{
        // We are on an iPad
        UIButton *theButton=sender;
        
        // setup popoverController
        [self.popoverController setContentViewController:self.helpViewController];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{
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
                [self.helpViewController loadDocument: @"appHelpScreeniPad.html"];
                
            });

        });
        
                
    }
    
        

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
    
    // Populate the right hand image view, if you want, with a custom icon.
    // The left hand image view is the app's icon.
       self.helpViewController.customIconFileName=@"customIcon.png";
    
    self.helpViewController.supportDictionary=[NSDictionary dictionaryWithObjectsAndKeys:@"http://bigdiggy.wordpress.com/support",BDSupportURLStringKey,
											   @"Support for Wonderful app is provided by via email and via the support website.",BDSupportStringKey,
											   @"yourSupportAddress@wonderfulapp.com",BDSupportEmailStringKey,
											   @"app",BDURLRejectStringKey,nil];
    
    
      helpViewController_.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
		
	return helpViewController_;
}


- (IBAction)pickerButtonPushed:(id)sender{
    UIViewController *viewController=nil;
    CGSize viewControllerSize=CGSizeZero;
    
    viewController=self.pickerViewController;
    viewControllerSize=self.pickerViewController.view.frame.size;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self slideIntoPlaceInputViewController:viewController];
    }else {
        [self.popoverController setContentViewController:viewController];
        
        self.popoverController.popoverContentSize=viewControllerSize;
        [self.popoverController presentPopoverFromRect:((UIButton *)sender).bounds inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }

}

- (IBAction)showPickerWithViews:(id)sender {
   
        
    UIViewController *viewController=nil;
    CGSize viewControllerSize=CGSizeZero;
    
    viewController=self.pickerViewControllerViewForRow;
    viewControllerSize=self.pickerViewControllerViewForRow.view.frame.size;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self slideIntoPlaceInputViewController:viewController];
    }else {
        [self.popoverController setContentViewController:viewController];
        
        self.popoverController.popoverContentSize=viewControllerSize;
        [self.popoverController presentPopoverFromRect:((UIButton *)sender).bounds inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }


    
}


- (IBAction)combinedViewButtonPushed:(id)sender{
    UIViewController *viewController=nil;
    CGSize viewControllerSize=CGSizeZero;
    
    viewController=self.tabBarController;
    viewControllerSize=self.tabBarController.view.frame.size;
    self.keyPadViewController.keyPadTitleLabel.text=@"Combined View KeyPad";
    self.keyPadViewController.popoverTextFieldString=self.keyPadOutputDecimalLabel.text;
    self.keyPadViewController.numberFormatType=BDNumberFormatterTypeDecimal;
    
    __weak __block ViewController *weakSelf=self;
    self.keyPadViewController.outputCallbackBlock=^(NSString *stringText,NSInteger tag){
        ViewController *strongSelf=weakSelf;
        strongSelf.keyPadOutputDecimalLabel.text=stringText;
                
    };

    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self slideIntoPlaceInputViewController:viewController];
    }else {
        [self.popoverController setContentViewController:viewController];
        
        self.popoverController.popoverContentSize=viewControllerSize;
        [self.popoverController presentPopoverFromRect:((UIButton *)sender).bounds inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }

}


#pragma mark -
#pragma mark BDInputViewController Related
- (IBAction)keyPadButtonPushed:(id)sender {
    
    UIViewController *viewController=nil;
    CGSize viewControllerSize=CGSizeZero;
    
    NSInteger buttonInputViewType=((UIButton *)sender).tag;
    
    
    viewController=self.keyPadViewController;
    viewControllerSize=self.keyPadViewController.view.frame.size;
    self.keyPadViewController.keyPadTitleLabel.text=@"KeyPad only";

    
    switch (buttonInputViewType) {
        case 100:
            self.keyPadViewController.popoverTextFieldString=self.keyPadOutputDecimalLabel.text;
            break;
        case 101:
            // Currency
            self.keyPadViewController.popoverTextFieldString=self.keyPadOutputCurrencyLabel.text;
            break;
        case 102:
            // Percentage
            self.keyPadViewController.popoverTextFieldString=self.keyPadOutputPercentageLabel.text;
            break;
        default:
            break;
    }
    self.keyPadViewController.numberFormatType=buttonInputViewType;
    __weak __block ViewController *weakSelf=self;
    self.keyPadViewController.outputCallbackBlock=^(NSString *stringText,NSInteger tag){
        ViewController *strongSelf=weakSelf;
        switch (buttonInputViewType) {
            case 100:
                strongSelf.keyPadOutputDecimalLabel.text=stringText;
                break;
            case 101:
                // Currency
                strongSelf.keyPadOutputCurrencyLabel.text=stringText;
                break;
            case 102:
                // Percentage
                strongSelf.keyPadOutputPercentageLabel.text=stringText;
            default:
                break;
        }

    };
        
   
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self slideIntoPlaceInputViewController:viewController];
    }else {
        [self.popoverController setContentViewController:viewController];
        
        self.popoverController.popoverContentSize=viewControllerSize;
        [self.popoverController presentPopoverFromRect:((UIButton *)sender).bounds inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
    
}

#pragma mark -
#pragma mark BDKeyPadViewController
-(BDKeyPadViewController *)keyPadViewController{
    if (keyPadViewController_) {
        return keyPadViewController_;
    }
    
    keyPadViewController_=[[BDKeyPadViewController alloc] init];
    keyPadViewController_.numberFormatType=BDNumberFormatterTypeDecimal;
    keyPadViewController_.popoverTextFieldString=@"43.00";
    return keyPadViewController_;
    
}

#pragma mark -
#pragma mark BDPickerViewController


-(BDPickerViewController *)pickerViewController{
    if (pickerViewController_) {
        return pickerViewController_;
    }
    pickerViewController_=[[BDPickerViewController alloc] init];
    
    pickerViewController_.numberOfComponentsInPickerViewBlock=^(UIPickerView *thePickerView){
        NSInteger numberOfComponents=1;
        
        if (thePickerView.tag==0) {
            numberOfComponents=1;
        }
        
        return numberOfComponents;
    };
    pickerViewController_.numberOfRowsInComponentBlock=^(UIPickerView *thePickerView,NSInteger component){
        NSInteger numberOfRows=2;
        return numberOfRows;
    };
    pickerViewController_.widthForComponentBlock=^(UIPickerView *thePickerView, NSInteger component){
        CGFloat componentWidth=thePickerView.frame.size.width-25;
        
        
        return componentWidth;
        
    };
    
    pickerViewController_.titleForRowBlock=^(UIPickerView *thePickerView, NSInteger row, NSInteger component){
        NSString *titleForRow=@"";
        switch (row) {
            case 0:
                titleForRow=@"One";
                break;
            case 1:
                titleForRow=@"Two";
                break;
				
        }
        
        return titleForRow;
    };
    
    pickerViewController_.didSelectRowComponentBlock=^(UIPickerView *thePickerView, NSInteger row, NSInteger component){
        NSLog(@"didselectRowCOmponentBlock");
        NSLog(@"selected row:  %d",row);
    };
    return pickerViewController_;
    
}

-(BDPickerViewControllerViewForRow *)pickerViewControllerViewForRow{
    if (pickerViewControllerViewForRow_!=nil) {
        return pickerViewControllerViewForRow_;
    }
    pickerViewControllerViewForRow_=[[BDPickerViewControllerViewForRow alloc] init];
    CGSize pickerViewSize=self.pickerViewControllerViewForRow.view.frame.size;
    CGSize newPickerViewSize=CGSizeMake(360.0f, pickerViewSize.height);
    self.pickerViewControllerViewForRow.pickerViewLabel.text=@"Plot Symbol";
    CGRect pickerViewFrame=CGRectMake(0.0, 0.0f, newPickerViewSize.width, newPickerViewSize.height);
    self.pickerViewControllerViewForRow.view.frame=pickerViewFrame;
    
    pickerViewControllerViewForRow_.numberOfComponentsInPickerViewBlock=^(UIPickerView *thePickerView){
        NSInteger numberOfComponents=2;
        
        return numberOfComponents;
    };
    
    pickerViewControllerViewForRow_.numberOfRowsInComponentBlock=^(UIPickerView *thePickerView,NSInteger component){
        NSInteger numberOfRows=11;
        if (component==1) {
            numberOfRows=10;
        }
        return numberOfRows;
    };
    pickerViewControllerViewForRow_.widthForComponentBlock=^(UIPickerView *thePickerView, NSInteger component){
        CGFloat componentWidth=thePickerView.frame.size.width-280;
        if (component==1) {
            componentWidth=280.0f;
        }
        
        return componentWidth;
        
    };
    
    UIImage *star=[UIImage imageNamed:@"starPlotSymbol.png"];
    UIImage *cross=[UIImage imageNamed:@"crossPlotSymbol.png"];
    UIImage *dash=[UIImage imageNamed:@"dashPlotSymbol.png"];
    UIImage *diamond=[UIImage imageNamed:@"diamondPlotSymbol.png"];
    UIImage *ellipse=[UIImage imageNamed:@"ellipsePlotSymbol.png"];
    UIImage *hexagon=[UIImage imageNamed:@"hexagonPlotSymbol.png"];
    UIImage *pentagon=[UIImage imageNamed:@"pentagonPlotSymbol.png"];
    UIImage *plus=[UIImage imageNamed:@"plusPlotSymbol.png"];
    UIImage *rectangle=[UIImage imageNamed:@"rectanglePlotSymbol.png"];
    UIImage *snow=[UIImage imageNamed:@"snowPlotSymbol.png"];
    UIImage *triangle=[UIImage imageNamed:@"trianglePlotSymbol.png"];
    
    NSArray *images=[NSArray arrayWithObjects:star,cross, dash,diamond,ellipse,hexagon,pentagon,plus,rectangle,snow,triangle, nil];
    
    NSMutableArray *colors=[NSMutableArray array];
    
    [colors addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],@"color",@"Black",@"Label", nil]];
    [colors addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],@"color",@"Red",@"Label", nil]];
    [colors addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor orangeColor],@"color",@"Orange",@"Label", nil]];
    [colors addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor yellowColor],@"color",@"Yellow",@"Label", nil]];
    
    [colors addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor greenColor],@"color",@"Green",@"Label", nil]];
    [colors addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blueColor],@"color",@"Blue",@"Label", nil]];
    [colors addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor purpleColor],@"color",@"Purple",@"Label", nil]];
    [colors addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor magentaColor],@"color",@"Magenta",@"Label", nil]];
    [colors addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor brownColor],@"color",@"Brown",@"Label", nil]];
    [colors addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],@"color",@"White",@"Label", nil]];
    
    
    pickerViewControllerViewForRow_.viewForRowBlock=^(UIPickerView *thePickerView, NSInteger row, NSInteger component, UIView *theView){
        //    NSLog(@"    images array:  %@",images);
        switch (component) {
            case 0:
            {
                if (theView==nil) {
                    theView=[[UIImageView alloc] initWithImage:[images objectAtIndex:row]];
                    return theView;
                }
                ((UIImageView *)theView).image=[images objectAtIndex:row];
                return theView;
                break;
                
            }
            case 1:
            {
                if (theView==nil) {
                    theView=[[BDPickerViewRowView alloc] initWithFrame:CGRectMake(0.0, 0.0f, 280.0, 40.0f)];
                }
                
                NSDictionary *theDict=[colors objectAtIndex:row];
                ((BDPickerViewRowView *)theView).colorLabel.text=[theDict objectForKey:@"Label"];
                ((BDPickerViewRowView *)theView).colorWell.backgroundColor=[theDict objectForKey:@"color"];
                
                return theView;
                break;
                
            }
                
        }
        
        return nil;
        
    };
    
    pickerViewControllerViewForRow_.didSelectRowComponentBlock=^(UIPickerView *thePickerView, NSInteger row, NSInteger component){
        NSLog(@"didselectRowCOmponentBlock");
        NSLog(@"    selected row:  %d",row);
    };
    
    return pickerViewControllerViewForRow_;

}

#pragma mark -
#pragma mark BDTabBarController
-(BDTabBarController *)tabBarController{
    if (tabBarController_) {
        return tabBarController_;
    }
    tabBarController_=[[BDTabBarController alloc] init];
    CGSize viewControllerSize=self.keyPadViewController.view.frame.size;
    tabBarController_.view.frame=CGRectMake(0, 0, viewControllerSize.width, viewControllerSize.height+49.0f);
    [tabBarController_ setViewControllers:[NSArray arrayWithObjects:self.keyPadViewController,self.pickerViewController, nil] animated:NO];
    
    
    
    return tabBarController_;
}

#pragma mark -
#pragma mark UIPopoverController
-(UIPopoverController *)popoverController{
    if (popoverController_!=nil) {
        return popoverController_;
    }
    popoverController_=[[UIPopoverController alloc] initWithContentViewController:[[UIViewController alloc] init]];
    self.popoverController.delegate=self;
    return popoverController_;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    if ([popoverController.contentViewController isKindOfClass:[BDTabBarController class]]) {
        NSLog(@"setting tabBarController to nil");
        self.popoverController=nil;
        self.tabBarController=nil;
    }
    self.pickerViewController=nil;
}

@end
