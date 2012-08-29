//
//  BDDateTimeNumberFormatter.h
//  FriisIt
//
//  Created by Tim Taylor on 12/14/09.
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


#import <Foundation/Foundation.h>
/** A class that combines the functionality of NSNumberFormatter and NSDateFormatter
 */

@interface BDDateTimeNumberFormatter : NSObject {
	
}
/** Provides a NSDateFormatter.
 
 @return Returns an NSDateFormatter formatted with the NSDateFormatterShortStyle style
 */
+(NSDateFormatter *)dateFormatter;
/** Provides a NSDateFormatter.
 
 @return Returns an NSDateFormatter formatted with the NSDateFormatterMediumStyle style
 */
+(NSDateFormatter *)timeFormatter;
/** Provides a NSDateFormatter that combines the formatting of timeFormatter and dateFormatter.
 
 @return Returns an NSDateFormatter.
 */
+(NSDateFormatter *)dateAndTimeFormatter;
/** Initializes a BDInformationViewController with two blocks that define the behavior for when the user taps the "Done" UIButton or the "Email" button.  Will return nil if unsuccessful.
 
 @return An NSNumberFormatter that will limit the fractional digits to numDigits.
 @param numDigits The number of Digits that the fractional digits should be limited to.
 */
+(NSNumberFormatter *)plainDecimalFormatterWithNumberOfFractionalDigits:(int)numDigits;
/** Provides a NSNumberFormatter that provides decimals to two places.
 
 @return Returns an NSNumberFormatter.
 */
+(NSNumberFormatter *)decimalNumberFormatter;
/** Provides a NSNumberFormatter that provides a whole number.
 
 @return Returns an NSNumberFormatter.
 */
+(NSNumberFormatter *)wholeNumberFormatter;
/** Provides a NSNumberFormatter that provides a currency formatter.
 
 @return Returns an NSNumberFormatter.
 */
+(NSNumberFormatter *)currencyDecimalFormatter;
/** Provides a NSNumberFormatter that provides a currency formatter for the passed locale.
 @param locale The locale required to provide the necessary formatting.
 @return Returns an NSNumberFormatter.
 */
+(NSNumberFormatter *)currencyDecimalFormatterWithLocal:(NSLocale *)locale;
/** Provides a NSNumberFormatter that provides a flexible number of fractional digits
 @param numDigits The fractional number of digits for the number formatter.
 @return Returns an NSNumberFormatter.
 */
+(NSNumberFormatter *)percentageDecimalFormatterWithNumberOfFractionalDigits:(NSInteger)numDigits;
/** Provides a NSNumberFormatter that provides a number formatted to scientific notation with the requested number of significant digits.
 @param numDigits The fractional number of digits for the number formatter.
 @return Returns an NSNumberFormatter.
 */
+(NSNumberFormatter *)sciFiNumberFormatterWithFractionalNumberOfDigits:(NSInteger)numDigits;
@end
