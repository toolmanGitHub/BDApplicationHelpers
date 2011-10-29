//
//  BDHelpViewController.h
//  FriisIt
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


#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "blockTypes.h"


extern NSString *BDSupportURLStringKey;   // The Support URL for your app that will be opened in Safari when the UIActionSheet's button is pushed.
extern NSString *BDSupportStringKey;      // The Text used to populate the UIActionSheet's title property
extern NSString *BDSupportEmailStringKey; // The email address for app support used to populate the Mail Composer's to: address
extern NSString *BDURLRejectStringKey;    // The text that all of you help html files must include to prevent your App from opening up the URL in Safari.

/** A View Controller that provides a WebKit Based HTML Help System.

 BDHelpViewController is a self contained Webkit Based HTML Help System.  There are a couple of unique features to the BDHelpViewController.  First, the bottom of the view contains a toolbar with several buttons, and on the iPad version, two image views that are populated with the apps icons.  The toolbar contains buttons that show the version, provide support options, and dismiss the BDHelpViewController.  When pushed the version button will show the build number.  To enable this, the key CFBundleVersion in the applications plist file must be used.  The "Support" button, when pressed, brings up a UIAlertSheet with buttons that will either bring up an email view controller or send the user to the app's support web page via Safari.
 
 Second, the "Done" button and "Email Support" button utilize block call backs to allow the calling viewController control over how the UIViewController is dismissed and calls an email view controller.  This allows a great deal of flexibility in that the user interface idiom is not hard coded and is completely up to the developer.
 
 Because the BDHelpViewController utilizes a UIWebView, we can make use of a UIWebView Delegate method that allow us to either utilize html files within the main bundle or to visit a website via Safari.  To keep the UIWebView from launching Safari, use the BDURLRejectStringKey to set a string that must be in the title of each of your html help files.  The string is set denoted by the BDURLRejectStringKey in the supportDictionary instance variable.  In order to use Safari to view the App's support web page, ensure that the URL does not contain any text that is in the BDURLRejectStringKey.
 */

@interface BDHelpViewController : UIViewController <UIWebViewDelegate, UIActionSheetDelegate> {
		
}
/** Support dictionary that provides the basis for information that will populate the UIActionSheet when the Support Button is pushed
 
 */
@property (nonatomic, strong) NSDictionary *supportDictionary;

/** The call back block for the "Done" Pushbutton.  Use this block to dismiss the BDInformationViewController and perform other clean up.
 
 */
@property (nonatomic, copy) buttonPushedCallbackBlock doneButtonPushedCallbackBlock;

/** The call back block for the "Email" from the UIActionSheet.  The calling view controller should provide this block to dismiss the BDInformationViewController and show a MFMailComposeViewController.
 
 */
@property (nonatomic, copy) buttonPushedCallbackBlock emailButtonPushedCallbackBlock;

/** File name for the customer icon to be shown in the lower right corner when using the iPad.
 
 */
@property (nonatomic,strong) NSString *customIconFileName;

/** Initializes a BDInformationViewController
 
 @return An initialized BDInformationViewController or nil if unsuccessful.
 */
-(id)init;

/** Initializes a BDInformationViewController with two blocks that define the behavior for when the user taps the "Done" UIButton or the "Email" button.  Will return nil if unsuccessful.
 
 @return An initialized BDInformationViewController or nil if unsuccessful.
 @param doneButtonBlock The block to be executed when the BDInformationViewController's "Done" UIButton is pushed.
 @param emailButtonBlock The block to be executed when the "Support" UIButton's UIActionSheet's Email button is tapped.
 */
- (id)initWithDoneButtonCallbackBlock:(buttonPushedCallbackBlock)doneButtonBlock
       emailButtonPushedCallbackBlock:(buttonPushedCallbackBlock)emailButtonBlock;

/** Directs the View Controller's UIWebView to load a document.  This Method creates an NSURLRequest from the documentName NSString.  The document must be located in the application's main bundle.
 
 @param documentName The document, which must be located in the application's main bundle, that the View Controller's UIWebView will load. 
 */
-(void)loadDocument:(NSString*)documentName;
@end


