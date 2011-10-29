//
//  BDDateTimeNumberFormatter.m
//  FriisIt
//
//  Created by Tim Taylor on 12/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BDDateTimeNumberFormatter.h"


@implementation BDDateTimeNumberFormatter

#pragma mark -
#pragma mark Date and Decimal Formatter

+ (NSDateFormatter *)dateFormatter {
	static NSDateFormatter *dateFormatter=nil;
	if (dateFormatter == nil) {
		dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateStyle:NSDateFormatterShortStyle];
	}
	return dateFormatter;
}

+ (NSDateFormatter *)timeFormatter {
	static NSDateFormatter *timeFormatter=nil;
	if (timeFormatter == nil) {
		timeFormatter = [[NSDateFormatter alloc] init];
		[timeFormatter setTimeStyle:NSDateFormatterMediumStyle];
    }
	return timeFormatter;
}

+ (NSDateFormatter *)dateAndTimeFormatter {	
    static NSDateFormatter *dateAndTimeFormatter=nil;
	if (dateAndTimeFormatter == nil) {
		dateAndTimeFormatter = [[NSDateFormatter alloc] init];
		[dateAndTimeFormatter setDateStyle:NSDateFormatterShortStyle];
		[dateAndTimeFormatter setTimeStyle:NSDateFormatterShortStyle];
    }
    //	NSLog(@"Using dateAndTimeFormatter");
	return dateAndTimeFormatter;
}

+(NSNumberFormatter *)currencyDecimalFormatter{
	static NSNumberFormatter *currencyFormatter = nil;
	if ( currencyFormatter == nil) {
		//	NSLog(@"decimalNumberFormatterbeing inited");
		currencyFormatter = [[NSNumberFormatter alloc] init];
		[NSNumberFormatter setDefaultFormatterBehavior:NSNumberFormatterBehavior10_4];
		[currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
		[currencyFormatter setAlwaysShowsDecimalSeparator:YES];
        [currencyFormatter setLenient:YES];
        [currencyFormatter setGeneratesDecimalNumbers:YES];
	}
	[currencyFormatter setLocale:[NSLocale autoupdatingCurrentLocale]];
	return currencyFormatter;
}


+(NSNumberFormatter *)currencyDecimalFormatterWithLocal:(NSLocale *)locale{
	static NSNumberFormatter *currencyFormatter = nil;
	if ( currencyFormatter == nil) {
		//	NSLog(@"decimalNumberFormatterbeing inited");
		currencyFormatter = [[NSNumberFormatter alloc] init];
		[NSNumberFormatter setDefaultFormatterBehavior:NSNumberFormatterBehavior10_4];
		[currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        
        [currencyFormatter setLenient:YES];
        [currencyFormatter setGeneratesDecimalNumbers:YES];
	}
  	[currencyFormatter setLocale:locale];
    if ([currencyFormatter maximumFractionDigits]==0)
        [currencyFormatter setAlwaysShowsDecimalSeparator:NO];
    else
        [currencyFormatter setAlwaysShowsDecimalSeparator:YES];
    
    return currencyFormatter;
}

+(NSNumberFormatter *)percentageDecimalFormatterWithNumberOfFractionalDigits:(NSInteger)numDigits{
	static NSNumberFormatter *percentageFormatter = nil;
	//NSLog(@"percentageDecimalFormatterWithNumberOfFractionalDigits start");
	if ( percentageFormatter == nil) {
        //	NSLog(@"	decimalNumberFormatterbeing inited");
		percentageFormatter = [[NSNumberFormatter alloc] init];
		[NSNumberFormatter setDefaultFormatterBehavior:NSNumberFormatterBehavior10_4];
		[percentageFormatter setNumberStyle:NSNumberFormatterPercentStyle];
		[percentageFormatter setAlwaysShowsDecimalSeparator:YES];
        [percentageFormatter setLenient:YES];
        [percentageFormatter setGeneratesDecimalNumbers:YES];
        [percentageFormatter setRoundingMode:NSNumberFormatterRoundDown];
	}
    NSLocale *locale=[NSLocale autoupdatingCurrentLocale];
    [percentageFormatter setLocale:locale];
 	[percentageFormatter setMaximumFractionDigits:numDigits];
	[percentageFormatter setMinimumFractionDigits:numDigits];
    //	/NSLog(@"	percentageDecimal Formatter:  %@",[percentageFormatter description]);
    //	NSLog(@"percentageDecimalFormatterWithNumberOfFractionalDigits end");
	return percentageFormatter;
}


+(NSNumberFormatter *)plainDecimalFormatterWithNumberOfFractionalDigits:(int)numDigits{
	static NSNumberFormatter *plainDecimalFormatter=nil;
	if ( plainDecimalFormatter == nil) {
		//	NSLog(@"decimalNumberFormatterbeing inited");
		plainDecimalFormatter = [[NSNumberFormatter alloc] init];
		[NSNumberFormatter setDefaultFormatterBehavior:NSNumberFormatterBehavior10_4];
		[plainDecimalFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[plainDecimalFormatter setAlwaysShowsDecimalSeparator:NO];
        [plainDecimalFormatter setGeneratesDecimalNumbers:YES];
        [plainDecimalFormatter setRoundingMode:NSNumberFormatterRoundDown];
        //		[plainDecimalFormatter setRoundingMode:NSNumberFormatterRoundHalfUp];
	}
	//	NSLog(@"decimalNumberFormatter being used");
	NSLocale *locale=[NSLocale autoupdatingCurrentLocale];
    [plainDecimalFormatter setLocale:locale];
	[plainDecimalFormatter setMaximumFractionDigits:numDigits];
	[plainDecimalFormatter setMinimumFractionDigits:numDigits];
	return plainDecimalFormatter;
}


+(NSNumberFormatter *)decimalNumberFormatter{
	static NSNumberFormatter *decimalNumberFormatter = nil;
	if ( decimalNumberFormatter == nil ) {
        //	NSLog(@"decimalNumberFormatterbeing inited");
		decimalNumberFormatter = [[NSNumberFormatter alloc] init];
		[NSNumberFormatter setDefaultFormatterBehavior:NSNumberFormatterBehavior10_4];
		[decimalNumberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[decimalNumberFormatter setAlwaysShowsDecimalSeparator:NO];
		
		[decimalNumberFormatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		
		[decimalNumberFormatter setMaximumFractionDigits:2];
		[decimalNumberFormatter setMinimumFractionDigits:2];
	}
    //	NSLog(@"decimalNumberFormatter being used");
	
	return decimalNumberFormatter;
}

+(NSNumberFormatter *)sciFiNumberFormatterWithFractionalNumberOfDigits:(NSInteger)numDigits{
	static NSNumberFormatter *sciFiFormatter = nil;
	if ( sciFiFormatter == nil ) {
        //	NSLog(@"decimalNumberFormatterbeing inited");
		sciFiFormatter = [[NSNumberFormatter alloc] init];
		[NSNumberFormatter setDefaultFormatterBehavior:NSNumberFormatterBehavior10_4];
		[sciFiFormatter setNumberStyle:NSNumberFormatterScientificStyle];
		[sciFiFormatter setAlwaysShowsDecimalSeparator:YES];
        [sciFiFormatter setGeneratesDecimalNumbers:YES];
        [sciFiFormatter setExponentSymbol:@"e"];
		[sciFiFormatter setRoundingMode:NSNumberFormatterRoundDown];
	}
    //	NSLog(@"decimalNumberFormatter being used");
    [sciFiFormatter setLocale:[NSLocale autoupdatingCurrentLocale]];
	[sciFiFormatter setMaximumFractionDigits:numDigits];
    [sciFiFormatter setMinimumFractionDigits:numDigits];
	return sciFiFormatter;
}


+(NSNumberFormatter *)wholeNumberFormatter;{
	static NSNumberFormatter *wholeNumberFormatter=nil;
	if (wholeNumberFormatter==nil) {
		wholeNumberFormatter =[[NSNumberFormatter alloc] init];
		[NSNumberFormatter setDefaultFormatterBehavior:NSNumberFormatterBehavior10_4];
		[wholeNumberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[wholeNumberFormatter setAlwaysShowsDecimalSeparator:NO];
		[wholeNumberFormatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		[wholeNumberFormatter setMaximumFractionDigits:0];
		[wholeNumberFormatter setMinimumFractionDigits:0];
	}
	return wholeNumberFormatter;
}


@end
