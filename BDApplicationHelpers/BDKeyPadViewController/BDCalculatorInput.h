//
//  BDCalculatorInput.h
//  applicationHelpers
//
//  Created by Tim Taylor on 8/30/12.
//
//

#import <Foundation/Foundation.h>
enum  {
	BDNumberFormatterTypeNothing=-100,
	BDNumberFormatterTypeDecimal=100,
	BDNumberFormatterTypeCurrency,
	BDNumberFormatterTypePercentage,
};
typedef NSInteger BDNumberFormatterType;
@interface BDCalculatorInput : NSObject

@property (nonatomic,strong) NSNumber *numberOfDecimalPlaces;
@property (nonatomic) BDNumberFormatterType numberFormatterType;
@property (nonatomic,strong) NSLocale *currentLocale;

- (NSString *)calculatorInputStringByAppendingCharacters:(NSString *)aCharacters toText:(NSString *)text;
@end
