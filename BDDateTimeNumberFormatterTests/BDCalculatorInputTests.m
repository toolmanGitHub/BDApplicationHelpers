//
//  BDCalculatorInputTests.m
//  applicationHelpers
//
//  Created by Tim Taylor on 8/30/12.
//
//

#import "BDCalculatorInputTests.h"

@implementation BDCalculatorInputTests

-(void)setUp{
    calculatorInput = [[BDCalculatorInput alloc] init];
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:1];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
}

-(void)tearDown{
    calculatorInput = nil;
}

-(void)testsThatCalculatorInputExists{
    BDCalculatorInput *newCalculatorInput=[[BDCalculatorInput alloc] init];
    STAssertNotNil(newCalculatorInput, @"BDCalculatorInput alloc/init should return a not nil object");
    
}

-(void)testThatCalculatorInputNumberOfDecimalPlacesPropertyExists{
    STAssertTrue([calculatorInput respondsToSelector:@selector(numberOfDecimalPlaces)], @"BDCalculatorInput should have numberOfDecimalPlaces property");
}

-(void)testThatNumberFormatterTypePropertyExists{
    STAssertTrue([calculatorInput respondsToSelector:@selector(numberFormatterType)], @"BDCalculatorInput should have numberFormatterType property");
}

-(void)testThatCalculatorInputStringByAppendingCharacters{
    STAssertTrue([calculatorInput respondsToSelector:@selector(calculatorInputStringByAppendingCharacters:toText:)], @"BDCalculatorInput should respond to stringByAppendingCharacters:toText:");
}

-(void)testThatCalculatorInputStringByAppendingCharactersReturnsString_TestOne{
    STAssertTrue([[calculatorInput calculatorInputStringByAppendingCharacters:@"3" toText:@"5.0"] isKindOfClass:[NSString class]], @"BDCalculatorInput stringByAppendingCharacters:toText: method should return a string");
}

-(void)testThatCalculatorInputStringByAppendingCharactersReturnsString_TestTwo{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:0];
    STAssertTrue([[calculatorInput calculatorInputStringByAppendingCharacters:@"3" toText:@"5"] isKindOfClass:[NSString class]], @"BDCalculatorInput stringByAppendingCharacters:toText: method should return a string");
}

#pragma mark -
#pragma mark Percentage Delete Character

-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithEmptyStringInput_TestOne{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypePercentage;
    
    NSString *correctPercentageString=@"3.14%";
    
    NSString *existingText=@"31.457%";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctPercentageString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should divide by 10 and remove digit with empty string.  Expected:  %@, Got: %@",correctPercentageString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithEmptyStringInput_TestTwo{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypePercentage;
    
    NSString *correctPercentageString=@"6.66%";
    
    NSString *existingText=@"66.67%";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctPercentageString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should divide by 10 and remove digit with empty string.  Expected:  %@, Got: %@",correctPercentageString,resultString);
    
}

#pragma mark -
#pragma mark Percentage Append Character
-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithInputCharacter_TestOne{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypePercentage;
    
    NSString *correctPercentageString=@"31.45%";
    
    NSString *existingText=@"3.14%";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"5" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctPercentageString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctPercentageString,resultString);

}

-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithInputCharacter_TestTwo{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypePercentage;
    
    NSString *correctPercentageString=@"66.67%";
    
    NSString *existingText=@"6.66%";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"7" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctPercentageString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctPercentageString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithInputCharacter_TestThree{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:3];
    calculatorInput.numberFormatterType=BDNumberFormatterTypePercentage;
    
    NSString *correctPercentageString=@"66.678%";
    
    NSString *existingText=@"6.667%";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"8" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctPercentageString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctPercentageString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithInputCharacter_TestFour{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:3];
    calculatorInput.numberFormatterType=BDNumberFormatterTypePercentage;
    
    NSString *correctPercentageString=@"31.458%";
    
    NSString *existingText=@"3.145%";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"8" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctPercentageString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctPercentageString,resultString);
    
}

#pragma mark -
#pragma mark Decimal Delete Character

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithEmptyString_TestOne{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    
    NSString *correctDecimalString=@"3.14";
    
    NSString *existingText=@"31.45";

    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should divide by 10 and remove digit with empty string.  Expected:  %@, Got: %@",correctDecimalString,resultString);

    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithEmptyString_TestTwo{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    
    NSString *correctDecimalString=@"6.66";
    
    NSString *existingText=@"66.67";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"" toText:existingText];
    
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should divide by 10 and remove digit with empty string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithEmptyString_ThreeTwo{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:3];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    
    NSString *correctDecimalString=@"6.667";
    
    NSString *existingText=@"66.678";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should divide by 10 and remove digit with empty string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
    
}

#pragma mark -
#pragma mark Decimal Append Character
-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithInputCharacter_TestOne{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    
    NSString *correctDecimalString=@"31.45";
    
    NSString *existingText=@"3.14";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"5" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithInputCharacter_TestTwo{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    
    NSString *correctDecimalString=@"66.67";
    
    NSString *existingText=@"6.66";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"7" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithInputCharacter_TestThree{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:3];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    
    NSString *correctDecimalString=@"66.678";
    
    NSString *existingText=@"6.667";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"8" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithInputCharacter_TestFour{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:3];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    
    NSString *correctDecimalString=@"31.458";
    
    NSString *existingText=@"3.145";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"8" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
}

#pragma mark -
#pragma mark Currency Delete Character

-(void)testThatCalculatorInputReturnsCorrectCurrencyStringWithEmptyString_TestOne{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeCurrency;
    
    NSString *correctString=@"$3.14";
    
    NSString *existingText=@"$31.45";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should divide by 10 and remove digit with empty string.  Expected:  %@, Got: %@",correctString,resultString);
    
    
}

-(void)testThatCalculatorInputReturnsCorrectCurrencyStringWithEmptyString_TestTwo{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeCurrency;
    
    NSString *correctString=@"$6.66";
    
    NSString *existingText=@"$66.67";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"" toText:existingText];
    
    STAssertTrue([resultString isEqualToString:correctString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should divide by 10 and remove digit with empty string.  Expected:  %@, Got: %@",correctString,resultString);
    
    
}


#pragma mark -
#pragma mark Currency Append Character
-(void)testThatCalculatorInputReturnsCorrectCurrencyStringWithInputCharacter_TestOne{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeCurrency;
    
    NSString *correctString=@"$31.45";
    
    NSString *existingText=@"$3.14";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"5" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectCurrencyStringWithInputCharacter_TestTwo{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeCurrency;
    
    NSString *correctString=@"$66.67";
    
    NSString *existingText=@"$6.66";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"7" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctString,resultString);
    
}

#pragma mark -
#pragma mark Currency No Decimal Delete Character

-(void)testThatCalculatorInputReturnsCorrectCurrencyStringWithEmptyString_TestOneYEN{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeCurrency;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    NSString *correctString=@"￥3";
    
    NSString *existingText=@"￥36";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should divide by 10 and remove digit with empty string.  Expected:  %@, Got: %@",correctString,resultString);
    
    
}

#pragma mark -
#pragma mark Currency No DecimalAppend Character
-(void)testThatCalculatorInputReturnsCorrectCurrencyStringWithInputCharacter_TestOneYEN{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeCurrency;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    NSString *correctString=@"￥3,145";
    
    NSString *existingText=@"￥314";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"5" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectCurrencyStringWithInputCharacter_TestTwoYEN{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeCurrency;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    NSString *correctString=@"￥6,667";
    
    NSString *existingText=@"￥666";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"7" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctString,resultString);
    
}









@end
