//
//  BDPickerViewControllerViewForRow.h
//  applicationHelpers
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


#import "BDPickerViewController.h"
typedef UIView *(^BDPickerViewForRowBlock)(UIPickerView *, NSInteger, NSInteger, UIView *);

/** This subclass of BDPickerViewController adds an additional block interface to handle the UIPickerView Delegate Protocol's pickerView:viewForRow:component:reuseView method.
 
 */
@interface BDPickerViewControllerViewForRow : BDPickerViewController{
    BDPickerViewForRowBlock viewForRowBlock;
}
/** A block that provides the view for a particular row and component.  This block is called when the BDPickerViewController instance's of UIPickerView Delegate implementation of pickerView:viewForRow:forComponent:reuseView is called. 
 
 */
@property (nonatomic,copy) BDPickerViewForRowBlock viewForRowBlock;
@end
