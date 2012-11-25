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
    NSString *resultString;
    switch (self.numberFormatterType) {
        case BDNumberFormatterTypePercentage:
            resultString=[self percentageInputStringByAppendingCharacters:aCharacters toText:text];
            break;
        case BDNumberFormatterTypeDecimal:
            resultString=[self decimalInputStringByAppendingCharacters:aCharacters toText:text];
            break;
        case BDNumberFormatterTypeCurrency:
            resultString=[self currencyInputStringByAppendingCharacters:aCharacters toText:text];
            break;
    }
    return resultString;
}

-(NSString *)currencyInputStringByAppendingCharacters:(NSString *)aCharacters toText:(NSString *)text{
    NSNumberFormatter *numberFormatter=[BDDateTimeNumberFormatter currencyDecimalFormatterWithLocal:self.currentLocale];
    
    NSDecimalNumberHandler *decimalNumberHandler=[[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundDown scale:numberFormatter.maximumFractionDigits raiseOnExactness:YES raiseOnOverflow:YES raiseOnUnderflow:YES raiseOnDivideByZero:NO];
    
    NSNumber *numberFromText=[numberFormatter numberFromString:text];
    NSDecimalNumber *decimalNumberFromText=[NSDecimalNumber decimalNumberWithDecimal:[numberFromText decimalValue]];
    
    NSDecimalNumber *resultDecimalNumber;
    if ([aCharacters isEqualToString:@""]) {
        resultDecimalNumber=[decimalNumberFromText decimalNumberByMultiplyingByPowerOf10:-1 withBehavior:decimalNumberHandler];
    }else{
        NSDecimal addendOne=[[decimalNumberFromText decimalNumberByMultiplyingByPowerOf10:1 withBehavior:decimalNumberHandler] decimalValue];
        NSDecimal addendTwo=[[[NSDecimalNumber decimalNumberWithString:aCharacters] decimalNumberByMultiplyingByPowerOf10:-(numberFormatter.maximumFractionDigits) withBehavior:decimalNumberHandler] decimalValue];
        resultDecimalNumber=[NSDecimalNumber decimalNumberWithString:@"31.45"];
        NSDecimal result;
        NSDecimalAdd(&result, &addendOne, &addendTwo, NSRoundDown);
        resultDecimalNumber=[NSDecimalNumber decimalNumberWithDecimal:result];
    }
    
    return [numberFormatter stringFromNumber:resultDecimalNumber];
    
}



-(NSString *)decimalInputStringByAppendingCharacters:(NSString *)aCharacters toText:(NSString *)text{
    
    NSInteger numberOfDecimalPlaces=self.numberOfDecimalPlaces.integerValue;
    NSNumberFormatter *numberFormatter=[BDDateTimeNumberFormatter plainDecimalFormatterWithNumberOfFractionalDigits:numberOfDecimalPlaces];
    numberFormatter.locale=self.currentLocale;
    
    NSDecimal addendOne;
    NSDecimal addendTwo;
    NSScanner *scanner =[NSScanner scannerWithString:text];
    scanner.locale=self.currentLocale;
    NSDecimal decimalFromText;
    NSDecimal result;
    [scanner scanDecimal:&decimalFromText];
    if ([aCharacters isEqualToString:@""]) {
        result=[[[NSDecimalNumber decimalNumberWithDecimal:decimalFromText] decimalNumberByMultiplyingByPowerOf10:-1] decimalValue];
    }else{
        addendOne=[[[NSDecimalNumber decimalNumberWithDecimal:decimalFromText] decimalNumberByMultiplyingByPowerOf10:1] decimalValue];
        addendTwo=[[[NSDecimalNumber decimalNumberWithString:aCharacters] decimalNumberByMultiplyingByPowerOf10:-numberOfDecimalPlaces] decimalValue];
        NSDecimalAdd(&result, &addendOne, &addendTwo, NSRoundPlain);
    }
    
    NSLog(@"result:  %@",[NSDecimalNumber decimalNumberWithDecimal:result]);
    
    return [numberFormatter stringFromNumber:[NSDecimalNumber decimalNumberWithDecimal:result]];
}

-(NSString *)percentageInputStringByAppendingCharacters:(NSString *)aCharacters toText:(NSString *)text{
    NSNumberFormatter *numberFormatter=nil;
    NSInteger numberOfDecimalPlaces=self.numberOfDecimalPlaces.integerValue;
    
    NSScanner *scanner=[NSScanner scannerWithString:text];
    scanner.locale=self.currentLocale;
    
    NSDecimal decimal;
    NSDecimal result;
    [scanner scanDecimal:&decimal];
    
    NSDecimal rightOperand;
    NSDecimalNumber *resultNumber;
    if ([aCharacters isEqualToString:@""]) {
  
        rightOperand=[[NSDecimalNumber decimalNumberWithString:@"1000"] decimalValue];
        NSDecimalDivide(&result, &decimal, &rightOperand, NSRoundPlain);
        resultNumber=[NSDecimalNumber decimalNumberWithDecimal:result];
    }else{
        rightOperand=[[NSDecimalNumber decimalNumberWithString:@"10"] decimalValue];
        NSDecimalDivide(&result, &decimal, &rightOperand, NSRoundPlain);
        NSDecimal addIn;
        NSDecimal leftOperand2=[[NSDecimalNumber decimalNumberWithString:aCharacters] decimalValue];
        NSDecimal rightOperand2=[[[NSDecimalNumber decimalNumberWithString:@"1"] decimalNumberByMultiplyingByPowerOf10:(numberOfDecimalPlaces+2)] decimalValue];
        NSDecimalDivide(&addIn, &leftOperand2, &rightOperand2, NSRoundPlain);
        NSDecimal result2;
        NSDecimalAdd(&result2, &result, &addIn, NSRoundPlain);
        resultNumber=[NSDecimalNumber decimalNumberWithDecimal:result2];
        
    }
    
    numberFormatter=[BDDateTimeNumberFormatter percentageDecimalFormatterWithNumberOfFractionalDigits:numberOfDecimalPlaces];
    numberFormatter.locale=self.currentLocale;
    
    return [numberFormatter stringFromNumber:resultNumber];

}

-(NSLocale *)currentLocale{
    if (_currentLocale) {
        return _currentLocale;
    }
    _currentLocale=[NSLocale currentLocale];
    return _currentLocale;
}

@end
