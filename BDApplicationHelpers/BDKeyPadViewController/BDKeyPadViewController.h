//
//  BDKeyPadViewController.h
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


#import <UIKit/UIKit.h>
#import "BDInputViewController.h"

enum  {
	BDNumberFormatterTypeNothing=-100,
	BDNumberFormatterTypeDecimal=100,
	BDNumberFormatterTypeCurrency,
	BDNumberFormatterTypePercentage,
};
typedef NSInteger BDNumberFormatterType;

/** A View Controller that provides a calculator like keypad useful for data entry.  When used on an iPhone or iPod touch, the keypad will have a done button in place of the double zero.  Swiping left or right over the number field applies the +/- operator.
 
 */


@interface BDKeyPadViewController : BDInputViewController <UITextFieldDelegate>{
   
}

/** The number of fractional digits.
 
 */
@property (nonatomic) NSUInteger numberDecimalPlaces;

/** The Type of number that is being manipulated.  i.e. decimal, currency or percentage.
 
 */
@property (nonatomic) BDNumberFormatterType numberFormatType;

/** The callback block used to update the calling viewController's UI. This block is called when the value on the keypad has changed.
 
 */
@property (copy) stringTagOutputCallbackBlock outputCallbackBlock;

/** The number string that populates the keypad textfield.
 
 */
@property (nonatomic,strong) NSString *popoverTextFieldString;

/** Label used to describe what the keypad is being used for.  i.e. Interest Rate or Transmit Power
 
 */
@property (nonatomic,strong) IBOutlet UILabel *keyPadTitleLabel;

/** Initializes an instance of BDKeyPadViewController
 
 @return An initialized BDKeyPadViewController or nil if unsuccessful.
 */
-(id)init;

@end
