//
//  BDDateTimeNumberFormatter.h
//  FriisIt
//
//  Created by Tim Taylor on 12/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

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
+(NSNumberFormatter *)decimalNumberFormatter;
+(NSNumberFormatter *)wholeNumberFormatter;
+(NSNumberFormatter *)currencyDecimalFormatter;
+(NSNumberFormatter *)currencyDecimalFormatterWithLocal:(NSLocale *)locale;
+(NSNumberFormatter *)percentageDecimalFormatterWithNumberOfFractionalDigits:(NSInteger)numDigits;
+(NSNumberFormatter *)sciFiNumberFormatterWithFractionalNumberOfDigits:(NSInteger)numDigits;
@end
