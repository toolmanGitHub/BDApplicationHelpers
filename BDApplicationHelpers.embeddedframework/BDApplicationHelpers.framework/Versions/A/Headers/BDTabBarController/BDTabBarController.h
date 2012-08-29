//
//  BDTabBarController.h
//  How Many Days
//
//  Created by Tim Taylor on 1/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDInputViewController.h"

typedef void(^BDdidSelectViewControllerBlock)(UITabBarController *, UIViewController *);
typedef void(^BDdidEndCustomizingViewControllersBlock)(UITabBarController *,NSArray *, BOOL);
typedef void(^BDshouldSelectViewControllerBlock)(UITabBarController *, UIViewController *);
typedef void(^BDwillBeginCustomizingViewControllersBlock)(UITabBarController *, NSArray *);
typedef void(^BDwillEndCustomizingViewControllersBlock)(UITabBarController *, NSArray *, BOOL);
/** A tab bar controller that uses block callbacks rather than delegates.  When used on the iPhone or iPod Touch.  Check the header file file to see what arguments the blocks take and what, if any, values are returned by the blocks.
 
 */
@interface BDTabBarController : UITabBarController <UITabBarControllerDelegate>{
	BDdidSelectViewControllerBlock didSelectViewControllerBlock;
	BDdidEndCustomizingViewControllersBlock didEndCustomizingViewControllersBlock;
	BDshouldSelectViewControllerBlock shouldSelectViewControllerBlock;
	BDwillBeginCustomizingViewControllersBlock willBeginCustomizingViewControllersBlock;
	BDwillEndCustomizingViewControllersBlock willEndCustomizingViewControllersBlock;
}
/** A block callback that executes code when a UITabBarItem is selected.
 
 */
@property (nonatomic,copy) BDdidSelectViewControllerBlock didSelectViewControllerBlock;
/** A block callback that executes code the customizing UITabBarItem is slected.
 
 */
@property (nonatomic,copy) BDdidEndCustomizingViewControllersBlock didEndCustomizingViewControllersBlock;
/** A block callback that executes code that notifies and aske permission to select a viewcontroller's UITabBarItem 
 */
@property (nonatomic,copy) BDshouldSelectViewControllerBlock shouldSelectViewControllerBlock;
/** A block callback that executes code when the UITabBarController is about to begin customizing. 
 */
@property (nonatomic,copy) BDwillBeginCustomizingViewControllersBlock willBeginCustomizingViewControllersBlock;
/** A block callback that executes code when the UITabBarController will end customizing the viewController UITabBarItems
 
 */
@property (nonatomic,copy) BDwillEndCustomizingViewControllersBlock willEndCustomizingViewControllersBlock;
@end
