//
//  BDDateTimeNumberFormatter.h
//  FriisIt
//
//  Created by Tim Taylor on 12/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BDDateTimeNumberFormatter : NSObject {
	NSDateFormatter *dateFormatter;
	NSDateFormatter *timeFormatter;
	NSDateFormatter *dateAndTimeFormatter;
	//	NSNumberFormatter *currencyDecimalFormatter;
	//NSNumberFormatter *decimalNumberFormatter;

}
+(NSDateFormatter *)dateFormatter;
+(NSDateFormatter *)timeFormatter;
+(NSDateFormatter *)dateAndTimeFormatter;
+(NSNumberFormatter *)plainDecimalFormatterWithNumberOfFractionalDigits:(int)numDigits;
+(NSNumberFormatter *)decimalNumberFormatter;
+(NSNumberFormatter *)wholeNumberFormatter;
+(NSNumberFormatter *)currencyDecimalFormatter;
+(NSNumberFormatter *)currencyDecimalFormatterWithLocal:(NSLocale *)locale;
+(NSNumberFormatter *)percentageDecimalFormatterWithNumberOfFractionalDigits:(NSInteger)numDigits;
+(NSNumberFormatter *)sciFiNumberFormatterWithFractionalNumberOfDigits:(NSInteger)numDigits;
@end
