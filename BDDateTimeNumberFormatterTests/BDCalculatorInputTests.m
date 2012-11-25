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
    
    NSString *existingText=@"31.45%";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctPercentageString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should divide by 10 and remove digit with empty string.  Expected:  %@, Got: %@",correctPercentageString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithEmptyStringInput_GreatBritainTestOne{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypePercentage;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    
    
    
    NSString *correctPercentageString=@"3.14%";
    
    NSString *existingText=@"31.45%";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctPercentageString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should divide by 10 and remove digit with empty string.  Expected:  %@, Got: %@",correctPercentageString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithEmptyStringInput_FinlandTestOne{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypePercentage;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"fi_FI"];
    
    
    
    NSString *correctPercentageString=@"3,14 %";
    
    
    NSString *existingText=@"31,45 %";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"" toText:existingText];
    NSLog(@"   resultString=%@, length=%d",resultString,[resultString length]);
    NSLog(@"    isEqual:  %@",[resultString isEqualToString:correctPercentageString] ?@"YES":@"NO");
    STAssertTrue([resultString isEqualToString:correctPercentageString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should divide by 10 and remove digit with empty string.  Expected:  %@, Got: %@",correctPercentageString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithEmptyStringInput_JapanTestOne{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypePercentage;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    
    NSString *correctPercentageString=@"3.14%";
    
    
    NSString *existingText=@"31.45%";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"" toText:existingText];
    NSLog(@"   resultString=%@, length=%d",resultString,[resultString length]);
    NSLog(@"    isEqual:  %@",[resultString isEqualToString:correctPercentageString] ?@"YES":@"NO");
    STAssertTrue([resultString isEqualToString:correctPercentageString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should divide by 10 and remove digit with empty string.  Expected:  %@, Got: %@",correctPercentageString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithEmptyStringInput_GermanyTestOne{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypePercentage;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];
    
    NSString *correctPercentageString=@"3,14 %";
    
    
    NSString *existingText=@"31,45%";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"" toText:existingText];
    NSLog(@"   resultString=%@, length=%d",resultString,[resultString length]);
    NSLog(@"    isEqual:  %@",[resultString isEqualToString:correctPercentageString] ?@"YES":@"NO");
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

-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithEmptyStringInput_GreatBritainTestTwo{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypePercentage;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    
    NSString *correctPercentageString=@"6.66%";
    
    NSString *existingText=@"66.67%";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctPercentageString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should divide by 10 and remove digit with empty string.  Expected:  %@, Got: %@",correctPercentageString,resultString);
    
}


-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithEmptyStringInput_FinlandTestTwo{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypePercentage;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"fi_FI"];
    
    NSString *correctPercentageString=@"6,66 %";
    
    NSString *existingText=@"66,67 %";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctPercentageString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should divide by 10 and remove digit with empty string.  Expected:  %@, Got: %@",correctPercentageString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithEmptyStringInput_JapanTestTwo{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypePercentage;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    
    NSString *correctPercentageString=@"6.66%";
    
    NSString *existingText=@"66.67%";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctPercentageString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should divide by 10 and remove digit with empty string.  Expected:  %@, Got: %@",correctPercentageString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithEmptyStringInput_GermanyTestTwo{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypePercentage;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];
    
    NSString *correctPercentageString=@"6,66 %";
    
    NSString *existingText=@"66,67 %";
    
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
    
    NSString *correctPercentageString=@"7.00%";
    
    NSString *existingText=@"0.70%";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"0" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctPercentageString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctPercentageString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithInputCharacter_GreatBritainTestOne{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypePercentage;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    
    NSString *correctPercentageString=@"31.45%";
    
    NSString *existingText=@"3.14%";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"5" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctPercentageString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctPercentageString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithInputCharacter_GreatBritainTestTwo{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypePercentage;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    
    NSString *correctPercentageString=@"7.00%";
    
    NSString *existingText=@"0.70%";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"0" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctPercentageString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctPercentageString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithInputCharacter_FinlandTestOne{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypePercentage;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"fi_FI"];
    
    NSString *correctPercentageString=@"31,45 %";
    
    NSString *existingText=@"3,14 %";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"5" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctPercentageString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctPercentageString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithInputCharacter_FinlandTestTwo{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypePercentage;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"fi_FI"];
    
    NSString *correctPercentageString=@"7,00 %";
    
    NSString *existingText=@"0,70 %";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"0" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctPercentageString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctPercentageString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithInputCharacter_JapanTestOne{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypePercentage;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    
    NSString *correctPercentageString=@"31.45%";
    
    NSString *existingText=@"3.14%";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"5" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctPercentageString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctPercentageString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithInputCharacter_JapanTestTwo{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypePercentage;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    
    NSString *correctPercentageString=@"7.00%";
    
    NSString *existingText=@"0.70%";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"0" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctPercentageString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctPercentageString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithInputCharacter_GermanyTestOne{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypePercentage;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];
    
    NSString *correctPercentageString=@"31,45 %";
    
    NSString *existingText=@"3,14 %";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"5" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctPercentageString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctPercentageString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithInputCharacter_GermanyTestTwo{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypePercentage;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];
    
    NSString *correctPercentageString=@"7,00 %";
    
    NSString *existingText=@"0,70 %";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"0" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctPercentageString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctPercentageString,resultString);
    
}




-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithInputCharacter_TestThree{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypePercentage;
    
    NSString *correctPercentageString=@"66.67%";
    
    NSString *existingText=@"6.66%";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"7" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctPercentageString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctPercentageString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithInputCharacter_TestFour{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:3];
    calculatorInput.numberFormatterType=BDNumberFormatterTypePercentage;
    
    NSString *correctPercentageString=@"66.678%";
    
    NSString *existingText=@"6.667%";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"8" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctPercentageString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctPercentageString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithInputCharacter_GreatBritainTestThree{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypePercentage;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    
    NSString *correctPercentageString=@"66.67%";
    
    NSString *existingText=@"6.66%";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"7" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctPercentageString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctPercentageString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithInputCharacter_GreatBritainTestFour{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:3];
    calculatorInput.numberFormatterType=BDNumberFormatterTypePercentage;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    
    NSString *correctPercentageString=@"66.678%";
    
    NSString *existingText=@"6.667%";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"8" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctPercentageString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctPercentageString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithInputCharacter_FinlandTestThree{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypePercentage;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"fi_FI"];
    
    NSString *correctPercentageString=@"66,67 %";
    
    NSString *existingText=@"6,66%";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"7" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctPercentageString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctPercentageString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithInputCharacter_FinlandTestFour{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:3];
    calculatorInput.numberFormatterType=BDNumberFormatterTypePercentage;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"fi_FI"];
    
    NSString *correctPercentageString=@"66,678 %";
    
    NSString *existingText=@"6,667 %";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"8" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctPercentageString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctPercentageString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithInputCharacter_GermanyTestThree{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypePercentage;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];
    
    NSString *correctPercentageString=@"66,67 %";
    
    NSString *existingText=@"6,66%";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"7" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctPercentageString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctPercentageString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithInputCharacter_GermanyTestFour{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:3];
    calculatorInput.numberFormatterType=BDNumberFormatterTypePercentage;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];
    
    NSString *correctPercentageString=@"66,678 %";
    
    NSString *existingText=@"6,667 %";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"8" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctPercentageString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctPercentageString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithInputCharacter_JapanTestThree{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypePercentage;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    
    NSString *correctPercentageString=@"66.67%";
    
    NSString *existingText=@"6.66%";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"7" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctPercentageString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctPercentageString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithInputCharacter_JapanTestFour{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:3];
    calculatorInput.numberFormatterType=BDNumberFormatterTypePercentage;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    
    NSString *correctPercentageString=@"66.678%";
    
    NSString *existingText=@"6.667%";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"8" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctPercentageString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctPercentageString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithInputCharacter_ChinaTestThree{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypePercentage;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    
    NSString *correctPercentageString=@"66.67%";
    
    NSString *existingText=@"6.66%";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"7" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctPercentageString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctPercentageString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithInputCharacter_ChinaTestFour{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:3];
    calculatorInput.numberFormatterType=BDNumberFormatterTypePercentage;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    
    NSString *correctPercentageString=@"66.678%";
    
    NSString *existingText=@"6.667%";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"8" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctPercentageString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctPercentageString,resultString);
    
}




-(void)testThatCalculatorInputReturnsCorrectPercentageStringWithInputCharacter_TestFive{
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

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithEmptyString_GreatBritainTestOne{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    
    NSString *correctDecimalString=@"3.14";
    
    NSString *existingText=@"31.45";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should divide by 10 and remove digit with empty string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithEmptyString_GreatBritainTestTwo{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    
    NSString *correctDecimalString=@"6.66";
    
    NSString *existingText=@"66.67";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"" toText:existingText];
    
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should divide by 10 and remove digit with empty string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithEmptyString_GreatBritainTestThree{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:3];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    
    NSString *correctDecimalString=@"6.667";
    
    NSString *existingText=@"66.678";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should divide by 10 and remove digit with empty string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
    
}


-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithEmptyString_FinlandTestOne{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"fi_FI"];
    NSString *correctDecimalString=@"3,14";
    
    NSString *existingText=@"31,45";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should divide by 10 and remove digit with empty string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithEmptyString_FinlandTestTwo{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"fi_FI"];
    NSString *correctDecimalString=@"6,66";
    
    NSString *existingText=@"66,67";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"" toText:existingText];
    
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should divide by 10 and remove digit with empty string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithEmptyString_FinlandThreeTwo{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:3];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"fi_FI"];
    NSString *correctDecimalString=@"6,667";
    
    NSString *existingText=@"66,678";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should divide by 10 and remove digit with empty string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithEmptyString_GermanyTestOne{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];
    NSString *correctDecimalString=@"3,14";
    
    NSString *existingText=@"31,45";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should divide by 10 and remove digit with empty string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithEmptyString_GermanyTestTwo{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];
    NSString *correctDecimalString=@"6,66";
    
    NSString *existingText=@"66,67";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"" toText:existingText];
    
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should divide by 10 and remove digit with empty string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithEmptyString_GermanyThreeTwo{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:3];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];
    NSString *correctDecimalString=@"6,667";
    
    NSString *existingText=@"66,678";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should divide by 10 and remove digit with empty string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithEmptyString_JapanTestOne{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    
    NSString *correctDecimalString=@"3.14";
    
    NSString *existingText=@"31.45";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should divide by 10 and remove digit with empty string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithEmptyString_JapanTestTwo{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    
    NSString *correctDecimalString=@"6.66";
    
    NSString *existingText=@"66.67";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"" toText:existingText];
    
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should divide by 10 and remove digit with empty string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithEmptyString_JapanTestThree{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:3];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    
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

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithInputCharacter_GreatBritainTestOne{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    
    NSString *correctDecimalString=@"31.45";
    
    NSString *existingText=@"3.14";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"5" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithInputCharacter_GreatBritainTestTwo{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    
    NSString *correctDecimalString=@"66.67";
    
    NSString *existingText=@"6.66";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"7" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithInputCharacter_GreatBritainTestThree{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:3];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    
    NSString *correctDecimalString=@"66.678";
    
    NSString *existingText=@"6.667";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"8" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithInputCharacter_FinlandTestOne{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"fi_FI"];
    
    NSString *correctDecimalString=@"31,45";
    
    NSString *existingText=@"3,14";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"5" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithInputCharacter_FinlandTestTwo{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"fi_FI"];
    
    NSString *correctDecimalString=@"66,67";
    
    NSString *existingText=@"6,66";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"7" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithInputCharacter_FinlandTestThree{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:3];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"fi_FI"];
    
    NSString *correctDecimalString=@"66,678";
    
    NSString *existingText=@"6,667";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"8" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithInputCharacter_GermanyTestOne{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];
    
    NSString *correctDecimalString=@"31,45";
    
    NSString *existingText=@"3,14";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"5" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithInputCharacter_GermanyTestTwo{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];
    
    NSString *correctDecimalString=@"66,67";
    
    NSString *existingText=@"6,66";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"7" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithInputCharacter_GermanyTestThree{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:3];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];
    
    NSString *correctDecimalString=@"66,678";
    
    NSString *existingText=@"6,667";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"8" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithInputCharacter_JapanTestOne{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    
    NSString *correctDecimalString=@"31.45";
    
    NSString *existingText=@"3.14";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"5" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithInputCharacter_JapanTestTwo{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    
    NSString *correctDecimalString=@"66.67";
    
    NSString *existingText=@"6.66";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"7" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithInputCharacter_JapanTestThree{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:3];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    
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

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithInputCharacter_TestFive{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    
    NSString *correctDecimalString=@"0.07";
    
    NSString *existingText=@"0.00";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"7" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctDecimalString,resultString);

}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithInputCharacter_TestSix{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    
    NSString *correctDecimalString=@"7.00";
    
    NSString *existingText=@"0.70";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"0" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithInputCharacter_GreatBritainTestFour{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:3];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    
    NSString *correctDecimalString=@"31.458";
    
    NSString *existingText=@"3.145";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"8" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithInputCharacter_GreatBritainTestFive{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    
    NSString *correctDecimalString=@"0.07";
    
    NSString *existingText=@"0.00";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"7" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithInputCharacter_GreatBritainTestSix{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    
    NSString *correctDecimalString=@"7.00";
    
    NSString *existingText=@"0.70";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"0" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithInputCharacter_FinlandTestFour{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:3];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"fi_FI"];
    
    NSString *correctDecimalString=@"31,458";
    
    NSString *existingText=@"3,145";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"8" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithInputCharacter_FinlandTestFive{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"fi_FI"];
    
    NSString *correctDecimalString=@"0,07";
    
    NSString *existingText=@"0,00";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"7" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithInputCharacter_FinlandTestSix{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"fi_FI"];
    
    NSString *correctDecimalString=@"7,00";
    
    NSString *existingText=@"0,70";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"0" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithInputCharacter_GermanyTestFour{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:3];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];
    
    NSString *correctDecimalString=@"31,458";
    
    NSString *existingText=@"3,145";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"8" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithInputCharacter_GermanyTestFive{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];
    
    NSString *correctDecimalString=@"0,07";
    
    NSString *existingText=@"0,00";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"7" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithInputCharacter_GermanyTestSix{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];
    
    NSString *correctDecimalString=@"7,00";
    
    NSString *existingText=@"0,70";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"0" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithInputCharacter_JapanTestFour{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:3];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    
    NSString *correctDecimalString=@"31.458";
    
    NSString *existingText=@"3.145";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"8" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithInputCharacter_JapanTestFive{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    
    NSString *correctDecimalString=@"0.07";
    
    NSString *existingText=@"0.00";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"7" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctDecimalString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctDecimalString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectDecimalStringWithInputCharacter_JapanTestSix{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeDecimal;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    
    NSString *correctDecimalString=@"7.00";
    
    NSString *existingText=@"0.70";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"0" toText:existingText];
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

-(void)testThatCalculatorInputReturnsCorrectCurrencyStringWithEmptyString_FinlandTestOne{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeCurrency;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"fi_FI"];
    NSString *correctString=@"3,14 €";
    
    NSString *existingText=@"31,45 €";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should divide by 10 and remove digit with empty string.  Expected:  %@, Got: %@",correctString,resultString);
    
    
}

-(void)testThatCalculatorInputReturnsCorrectCurrencyStringWithEmptyString_FinlandTestTwo{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeCurrency;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"fi_FI"];
    NSString *correctString=@"6,66 €";
    
    NSString *existingText=@"66,67 €";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"" toText:existingText];
    
    STAssertTrue([resultString isEqualToString:correctString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should divide by 10 and remove digit with empty string.  Expected:  %@, Got: %@",correctString,resultString);
    
    
}

-(void)testThatCalculatorInputReturnsCorrectCurrencyStringWithEmptyString_GermanyTestOne{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeCurrency;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];
    NSString *correctString=@"3,14 €";
    
    NSString *existingText=@"31,45 €";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should divide by 10 and remove digit with empty string.  Expected:  %@, Got: %@",correctString,resultString);
    
    
}

-(void)testThatCalculatorInputReturnsCorrectCurrencyStringWithEmptyString_GermanyTestTwo{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeCurrency;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];
    NSString *correctString=@"6,66 €";
    
    NSString *existingText=@"66,67 €";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"" toText:existingText];
    
    STAssertTrue([resultString isEqualToString:correctString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should divide by 10 and remove digit with empty string.  Expected:  %@, Got: %@",correctString,resultString);
    
    
}

-(void)testThatCalculatorInputReturnsCorrectCurrencyStringWithEmptyString_GreatBritainTestOne{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeCurrency;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    NSString *correctString=@"£3.14";
    
    NSString *existingText=@"£31.45";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should divide by 10 and remove digit with empty string.  Expected:  %@, Got: %@",correctString,resultString);
    
    
}

-(void)testThatCalculatorInputReturnsCorrectCurrencyStringWithEmptyString_GreatBritainTestTwo{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeCurrency;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    NSString *correctString=@"£6.66";
    
    NSString *existingText=@"£66.67";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"" toText:existingText];
    
    STAssertTrue([resultString isEqualToString:correctString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should divide by 10 and remove digit with empty string.  Expected:  %@, Got: %@",correctString,resultString);
    
    
}

-(void)testThatCalculatorInputReturnsCorrectCurrencyStringWithEmptyString_JapanTestOne{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeCurrency;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    NSString *correctString=@"￥314";
    
    NSString *existingText=@"￥3,145";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should divide by 10 and remove digit with empty string.  Expected:  %@, Got: %@",correctString,resultString);
    
    
}

-(void)testThatCalculatorInputReturnsCorrectCurrencyStringWithEmptyString_JapanTestTwo{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeCurrency;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    NSString *correctString=@"￥666";
    
    NSString *existingText=@"￥6667";
    
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

-(void)testThatCalculatorInputReturnsCorrectCurrencyStringWithInputCharacter_TestThree{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeCurrency;
    
    NSString *correctString=@"$0.70";
    
    NSString *existingText=@"$0.07";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"0" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectCurrencyStringWithInputCharacter_JapanTestOne{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeCurrency;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    
    NSString *correctString=@"￥3,145";
    
    NSString *existingText=@"￥314";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"5" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectCurrencyStringWithInputCharacter_JapanTestTwo{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeCurrency;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    
    NSString *correctString=@"￥6,667";
    
    NSString *existingText=@"￥666";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"7" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectCurrencyStringWithInputCharacter_JapanTestThree{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeCurrency;
     calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    
    NSString *correctString=@"￥70";
    
    NSString *existingText=@"￥7";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"0" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectCurrencyStringWithInputCharacter_GreatBritainTestOne{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeCurrency;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    
    NSString *correctString=@"£31.45";
    
    NSString *existingText=@"£3.14";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"5" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectCurrencyStringWithInputCharacter_GreatBritainTestTwo{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeCurrency;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    
    NSString *correctString=@"£66.67";
    
    NSString *existingText=@"£6.66";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"7" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectCurrencyStringWithInputCharacter_GreatBritainTestThree{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeCurrency;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    
    NSString *correctString=@"£0.70";
    
    NSString *existingText=@"£0.07";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"0" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectCurrencyStringWithInputCharacter_FinlandTestOne{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeCurrency;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"fi_FI"];
    
    NSString *correctString=@"31,45 €";
    
    NSString *existingText=@"3,14 €";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"5" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectCurrencyStringWithInputCharacter_FinlandTestTwo{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeCurrency;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"fi_FI"];
    
    NSString *correctString=@"66,67 €";
    
    NSString *existingText=@"6,66 €";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"7" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectCurrencyStringWithInputCharacter_FinlandTestThree{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeCurrency;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"fi_FI"];
    
    NSString *correctString=@"0,70 €";
    
    NSString *existingText=@"0,07 €";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"0" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectCurrencyStringWithInputCharacter_GermanyTestOne{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeCurrency;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];
    
    NSString *correctString=@"31,45 €";
    
    NSString *existingText=@"3,14 €";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"5" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectCurrencyStringWithInputCharacter_GermanyTestTwo{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeCurrency;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];
    
    NSString *correctString=@"66,67 €";
    
    NSString *existingText=@"6,66 €";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"7" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctString,resultString);
    
}

-(void)testThatCalculatorInputReturnsCorrectCurrencyStringWithInputCharacter_GermanyTestThree{
    calculatorInput.numberOfDecimalPlaces=[NSNumber numberWithInteger:2];
    calculatorInput.numberFormatterType=BDNumberFormatterTypeCurrency;
    calculatorInput.currentLocale=[[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];
    
    NSString *correctString=@"0,70 €";
    
    NSString *existingText=@"0,07 €";
    
    NSString *resultString=[calculatorInput calculatorInputStringByAppendingCharacters:@"0" toText:existingText];
    STAssertTrue([resultString isEqualToString:correctString], @"BDCalculatorInput stringByAppendingCharacters:toText: method should multiply by 10 and add the input digit string.  Expected:  %@, Got: %@",correctString,resultString);
    
}
@end
