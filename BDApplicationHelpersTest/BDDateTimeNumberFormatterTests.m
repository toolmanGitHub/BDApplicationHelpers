//
//  BDDateTimeNumberFormatterTests.m
//  applicationHelpers
//
//  Created by Tim Taylor on 8/30/12.
//
//

#import "BDDateTimeNumberFormatterTests.h"

@implementation BDDateTimeNumberFormatterTests

-(void)setUp{
    dateTimeNumberFormatter = [[BDDateTimeNumberFormatter alloc] init];
}

-(void)tearDown{
    dateTimeNumberFormatter = nil;
}

-(void)testThatClassExists{
    BDDateTimeNumberFormatter *newFormatter=[[BDDateTimeNumberFormatter alloc] init];
    STAssertNotNil(newFormatter, @"BDDateTimeNumberFormatter: alloc/init should not be nil");
}

-(void)testThatRightNSNumberIsReturnedFromPercentageFormatter{
    NSString *percentageString=@"3.145%";
    NSNumber *correctPercentageNumber=[NSNumber numberWithDouble:0.03145];
    
    NSNumberFormatter *numberFormatter=[BDDateTimeNumberFormatter percentageDecimalFormatterWithNumberOfFractionalDigits:3];
    
    STAssertTrue([correctPercentageNumber compare:[numberFormatter numberFromString:percentageString]]==NSOrderedSame, @"BDDateTimeNumberFormatter providing string to percentageFormatter should return correct number.  Got: %@",[numberFormatter numberFromString:percentageString]);
    
}

-(void)testThatRightNSStringIsReturnedFromPercentageFormatter{
    NSNumber *percentageNumber=[NSNumber numberWithDouble:0.03145];
    NSString *correctPercentageString=@"3.145%";
    
    NSNumberFormatter *numberFormatter=[BDDateTimeNumberFormatter percentageDecimalFormatterWithNumberOfFractionalDigits:3];
    
    STAssertTrue([correctPercentageString isEqualToString:[numberFormatter stringFromNumber:percentageNumber]], @"BDDateTimeNumberFormatter providing number to percentage formatter should return correct string.  Got:  %@",[numberFormatter stringFromNumber:percentageNumber]);
}

@end
