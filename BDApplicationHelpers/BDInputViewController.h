//
//  BDInputViewController.h
//  testInputView
//
//  Created by Tim on 10/28/11.
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

#import <UIKit/UIKit.h>
#import "BDInputViewControllerProtocol.h"
#import "blockTypes.h"

/** An abstract UIViewController Subclass that adopts the BDInputViewControllerProtocol.  Other types of wouldbe viewControllers that gather input can be based off of this class.  i.e. PickerViews, KeyPads, combined view controllers, etc.  
 
 All subclasses of BDInputViewControllers are meant to be used as child viewControllers that are contained in a parent viewController. Somewhat like how a subclass of UIViewController can be embedded in a UINavigationController or a UITabBarController.
 */
@interface BDInputViewController : UIViewController <BDInputViewControllerProtocol>
{
    buttonPushedCallbackBlock doneButtonPushedCallbackBlock;
}

/** Callback block used by, for example, a button's IBAction to send call the parent viewController's methods/code to dismiss this child view controller.
 @see BDInputViewControllerProtocol
 
 */
@property (copy) buttonPushedCallbackBlock doneButtonPushedCallbackBlock;


@end
