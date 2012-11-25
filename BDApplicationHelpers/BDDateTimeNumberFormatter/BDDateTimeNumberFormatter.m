//
//  BDDateTimeNumberFormatter.m
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


#import "BDDateTimeNumberFormatter.h"


@implementation BDDateTimeNumberFormatter

#pragma mark -
#pragma mark Date and Decimal Formatter

- (NSDateFormatter *)dateFormatterUTCTimeZone {
	static NSDateFormatter *dateFormatterUTCTimeZone=nil;
	if (dateFormatterUTCTimeZone == nil) {
		dateFormatterUTCTimeZone=[[NSDateFormatter alloc] init];
        [dateFormatterUTCTimeZone setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
        [dateFormatterUTCTimeZone setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    }
	return dateFormatterUTCTimeZone;
}

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
    [currencyFormatter setRoundingMode:NSRoundDown];
    
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
//    NSLocale *locale=[NSLocale currentLocale];
//    [percentageFormatter setLocale:locale];
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
//        [plainDecimalFormatter setRoundingMode:NSNumberFormatterRoundHalfUp];
	}
	//	NSLog(@"decimalNumberFormatter being used");
//	NSLocale *locale=[NSLocale autoupdatingCurrentLocale];
//    [plainDecimalFormatter setLocale:locale];
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
//    [sciFiFormatter setLocale:[NSLocale autoupdatingCurrentLocale]];
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
