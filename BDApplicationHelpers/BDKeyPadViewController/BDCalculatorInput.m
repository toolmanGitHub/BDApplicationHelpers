//
//  BDCalculatorInput.m
//  applicationHelpers
//
//  Created by Tim Taylor on 8/30/12.
//
//

#import "BDCalculatorInput.h"
#import "BDDateTimeNumberFormatter.h"

@implementation BDCalculatorInput
@synthesize numberOfDecimalPlaces = _numberOfDecimalPlaces;
@synthesize numberFormatterType = _numberFormatterType;
@synthesize currentLocale = _currentLocale;


- (NSString *)calculatorInputStringByAppendingCharacters:(NSString *)aCharacters toText:(NSString *)text{
    
    NSNumberFormatter *numberFormatter=nil;
    
    NSInteger numberOfDecimalPlaces=self.numberOfDecimalPlaces.integerValue;
    
    NSDecimalNumberHandler *roundingBehavior = nil;
    
    NSInteger calculationNumberOfDecimalPlaces=numberOfDecimalPlaces;
    
    switch (self.numberFormatterType) {
        case BDNumberFormatterTypePercentage:{
            calculationNumberOfDecimalPlaces=numberOfDecimalPlaces+2;
            
            numberFormatter=[BDDateTimeNumberFormatter percentageDecimalFormatterWithNumberOfFractionalDigits:numberOfDecimalPlaces];
            
//            roundingBehavior =[[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundPlain scale:(numberOfDecimalPlaces+2) raiseOnExactness:YES raiseOnOverflow:YES raiseOnUnderflow:YES raiseOnDivideByZero:NO];
            break;
        }
        case BDNumberFormatterTypeDecimal:{
            numberFormatter=[BDDateTimeNumberFormatter plainDecimalFormatterWithNumberOfFractionalDigits:numberOfDecimalPlaces];
            roundingBehavior = [[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundDown scale:(numberOfDecimalPlaces+1) raiseOnExactness:YES raiseOnOverflow:YES raiseOnUnderflow:YES raiseOnDivideByZero:NO];
            break;
        }
        case BDNumberFormatterTypeCurrency:{
            numberFormatter=[BDDateTimeNumberFormatter currencyDecimalFormatterWithLocal:self.currentLocale];
            calculationNumberOfDecimalPlaces=[numberFormatter maximumFractionDigits];
            
            roundingBehavior =[[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundDown scale:-(numberOfDecimalPlaces) raiseOnExactness:YES raiseOnOverflow:YES raiseOnUnderflow:YES raiseOnDivideByZero:NO];
            
            break;
        }
        default:
            break;
    }
    NSLog(@"numberFormatter:  %@",numberFormatter);
    NSNumber *numberFromText=[numberFormatter numberFromString:text];
    
    NSDecimalNumber *decimalFromText=[NSDecimalNumber decimalNumberWithDecimal:[numberFromText decimalValue]];
    
    NSLog(@"get ready");
    NSLog(@"max fractional digits:  %d",[numberFormatter maximumFractionDigits]);
    NSLog(@"min fractional digits:  %d",[numberFormatter minimumFractionDigits]);
    NSLog(@"original text=%@",text);
    NSLog(@"original NSNumber utext=%@",numberFromText);
    NSLog(@"original Decimal Text=%@",decimalFromText);
    NSDecimalNumber *returnDecimal=nil;
    if ([aCharacters isEqualToString:@""]) {
//        if (self.numberFormatterType==BDNumberFormatterTypeCurrency) {
//            returnDecimal = [decimalFromText decimalNumberByMultiplyingByPowerOf10:-1 withBehavior:roundingBehavior];
//            NSLog(@"roundingBehavior:  %@",roundingBehavior);
//        }else{
//            returnDecimal = [decimalFromText decimalNumberByMultiplyingByPowerOf10:-1];
//        }       
        returnDecimal = [decimalFromText decimalNumberByMultiplyingByPowerOf10:-1];
        NSLog(@"returnDecimal=%@",returnDecimal);
    }else{
        NSDecimalNumber *leftOperandDecimal=[decimalFromText decimalNumberByMultiplyingByPowerOf10:1];
        NSLog(@"leftOperandDecimal=%@",leftOperandDecimal);
        NSDecimalNumber *newDecimal=[NSDecimalNumber decimalNumberWithString:aCharacters];
        NSLog(@"newDecimal=%@",newDecimal);
        NSDecimalNumber *rightOperandDecimal=[newDecimal decimalNumberByMultiplyingByPowerOf10:-calculationNumberOfDecimalPlaces];
        NSLog(@"newDecimal=%@",rightOperandDecimal);
        
        returnDecimal=[rightOperandDecimal decimalNumberByAdding:leftOperandDecimal];
    }
    
    return [numberFormatter stringFromNumber:returnDecimal];
    
}

-(NSLocale *)currentLocale{
    if (_currentLocale) {
        return _currentLocale;
    }
    _currentLocale=[NSLocale currentLocale];
    return _currentLocale;
}

@end
