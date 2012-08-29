//
//  BDTabBarController.m
//  How Many Days
//
//  Created by Tim Taylor on 1/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BDTabBarController.h"


@implementation BDTabBarController
@synthesize didSelectViewControllerBlock;
@synthesize didEndCustomizingViewControllersBlock;
@synthesize shouldSelectViewControllerBlock;
@synthesize willBeginCustomizingViewControllersBlock;
@synthesize willEndCustomizingViewControllersBlock;


- (id)init{
	self = [super init];
	if (self) {
		self.delegate=self;
	}
	return self;
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark -
#pragma BDInputViewControllerProtocol


-(BDInputViewType)inputViewType{
    return BDInputViewTypeCombinedViewController;
}

#pragma mark -
#pragma mark UITabBarControllerDelegate methods
-(void)setDismissViewControllerCallbackBlock:(dismissCallBackBlock)callbackBlock{
    [self.viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ((BDInputViewController *)obj).doneButtonPushedCallbackBlock=callbackBlock;
    }];
}




// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
 	if (didSelectViewControllerBlock!=nil) {
		didSelectViewControllerBlock(tabBarController,viewController);
	}
	
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}




@end
