//
//  BDPickerViewController.h
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


#import "BDInputViewController.h"

extern NSString *kBDKeyPadViewControllerDoneButtonPushedNotification;

typedef NSInteger (^BDPickerNumberOfComponentsInPickerViewBlock)(UIPickerView *);
typedef NSInteger (^BDPickerNumberOfRowsInComponentBlock)(UIPickerView *, NSInteger);
typedef CGFloat (^BDPickerRowHeightForComponentBlock)(UIPickerView *, NSInteger);
typedef CGFloat (^BDPickerWidthForComponentBlock)(UIPickerView *, NSInteger);
typedef NSString *(^BDPickerTitleForRowBlock)(UIPickerView *, NSInteger, NSInteger);
typedef UIView *(^BDPickerViewForRowBlock)(UIPickerView *, NSInteger, NSInteger, UIView *);
typedef void(^BDPickerDidSelectRowComponentBlock)(UIPickerView *, NSInteger, NSInteger);

/** This subclass of BDInputViewController contains a UIPickerView and optional "Done" UIButton.  The Done UIButton is only available when using the class on an iPhone or iPod touch.  The unique thing about the implementation of the BDPickerViewController is that it encapsulates the delegate and datasource protocols for UIPickerView into callback blocks. Check the header file file to see what arguments the blocks take and what, if any, values are returned by the blocks.
 
 */
@interface BDPickerViewController : BDInputViewController {
    BDPickerNumberOfRowsInComponentBlock numberOfRowsInComponentBlock;
	BDPickerNumberOfComponentsInPickerViewBlock numberOfComponentsInPickerViewBlock;
	BDPickerRowHeightForComponentBlock rowHeightForComponentBlock;
	BDPickerWidthForComponentBlock widthForComponentBlock;
	BDPickerTitleForRowBlock titleForRowBlock;
	BDPickerDidSelectRowComponentBlock didSelectRowComponentBlock;
    BDPickerViewForRowBlock viewForRowBlock;

}
/** A UILabel for the pickerViewController
 
 */
@property (nonatomic,strong) IBOutlet UILabel *pickerViewLabel;
/** A block callback that provides the number of components to be used in the PickerView.  This block is called when the BDPickerViewController instance's of UIPickerViewDataSource Protocol implementation of numberOfComponentsInPickerView: is called.
 
 */
@property (nonatomic,copy) BDPickerNumberOfComponentsInPickerViewBlock numberOfComponentsInPickerViewBlock;
/** A block that provides the number of rows for a particular component.  This block is called when the BDPickerViewController instance's of UIPickerViewDataSource Protocol implementation of pickerView:numberOfRowsInComponent: is called.

 
 */
@property (nonatomic,copy) BDPickerNumberOfRowsInComponentBlock numberOfRowsInComponentBlock;
/** A block that provides the row height for a particular row and component.  This block is called when the BDPickerViewController instance's of UIPickerView Delegate implementation of pickerView:rowHeightForComponent is called.
 
 */
@property (nonatomic,copy) BDPickerRowHeightForComponentBlock rowHeightForComponentBlock;
/** A block that provides the width for a particular component.  This block is called when the BDPickerViewController instance's of UIPickerView Delegate implementation of pickerView:widthForComponent is called. 
 
 */
@property (nonatomic,copy) BDPickerWidthForComponentBlock widthForComponentBlock;
/** A block that provides the title for a particular row and component.  This block is called when the BDPickerViewController instance's of UIPickerView Delegate implementation of pickerView:titleForRow:forComponent: is called. 
 
 */
@property (nonatomic,copy) BDPickerTitleForRowBlock titleForRowBlock;

/** A block that provides the view for a particular row and component.  This block is called when the BDPickerViewController instance's of UIPickerView Delegate implementation of pickerView:viewForRow:forComponent:reuseView is called. 
 
 */
@property (nonatomic,copy) BDPickerViewForRowBlock viewForRowBlock;
/** A block that provides the executes when a components row is selected. This block is called when the BDPickerViewController instance's of UIPickerView Delegate implementation of pickerView:didSelectRow:inComponent is called. 

 
 */
@property (nonatomic,copy) BDPickerDidSelectRowComponentBlock didSelectRowComponentBlock;
/** Initializes an instance of BDPickerViewController
 
 @return An initialized BDKeyPadViewController or nil if unsuccessful.
 */
-(id)init;

@end
