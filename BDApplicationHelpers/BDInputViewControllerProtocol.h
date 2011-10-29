//
//  BDInputViewControllerProtocol.h
//  How Many Days
//
//  Created by Tim Taylor on 10/29/2011.
//  Copyright 2011 Big Diggy SW. All rights reserved.
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
enum  {
	BDInputViewTypeNothing=-200,
	BDInputViewTypeNumberKeyPad=200,
	BDInputViewTypePicker,
    BDInputViewTypeCombinedViewController,
};
typedef NSInteger BDInputViewType;

enum {
    BDInputViewAnimationTypeNothing=-300,
    BDInputViewAnimationTypeSlideFromBottom=300,
}; typedef NSInteger BDInputViewAnimationType;

typedef void(^dismissCallBackBlock)(void);

/** A protocol used to direct the behavior of a viewController subclass via call backs as well as to interrogate it for specific information having to do with it's presentation within a viewController container.
 */


@protocol BDInputViewControllerProtocol
@required
/** Used to set the callback block that will use the parent viewController to dismiss this child input viewController.
  @param callbackBlock The block that will use the parent viewController supplied code that will dismiss the child input viewController.
*/
-(void)setDismissViewControllerCallbackBlock:(dismissCallBackBlock)callbackBlock;

/** Used by the parent viewController to interrogate the receiver about what type of inputView type the controller contains.
 @return The BDInputViewType of the subclass of BDInputViewController.
 */
-(BDInputViewType)inputViewType;
@optional
/** Used by the parent viewController to interrogate the receiver about what type of animation to be used to present the subclass of BDInputViewController.
 @return The BDInputViewAnimationType of the subclass of BDInputViewController.  The default is BDInputViewAnimationTypeSlideFromBottom.
 */
-(BDInputViewAnimationType)preferredInputViewAnimationType;

@end
