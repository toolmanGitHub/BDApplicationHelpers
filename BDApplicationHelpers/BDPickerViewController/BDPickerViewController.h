//
//  BDPickerViewController.h
//  How Many Days
//
//  Created by Tim Taylor on 7/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BDInputViewController.h"

extern NSString *kBDKeyPadViewControllerDoneButtonPushedNotification;

typedef NSInteger (^BDPickerNumberOfComponentsInPickerViewBlock)(UIPickerView *);
typedef NSInteger (^BDPickerNumberOfRowsInComponentBlock)(UIPickerView *, NSInteger);
typedef CGFloat (^BDPickerRowHeightForComponentBlock)(UIPickerView *, NSInteger);
typedef CGFloat (^BDPickerWidthForComponentBlock)(UIPickerView *, NSInteger);
typedef NSString *(^BDPickerTitleForRowBlock)(UIPickerView *, NSInteger, NSInteger);
typedef void(^BDPickerDidSelectRowComponentBlock)(UIPickerView *, NSInteger, NSInteger);

@interface BDPickerViewController : BDInputViewController {
	UIPickerView *pickerView;
	UILabel *pickerViewLabel;
	UIButton *doneButton;
		
	BDPickerNumberOfRowsInComponentBlock numberOfRowsInComponentBlock;
	BDPickerNumberOfComponentsInPickerViewBlock numberOfComponentsInPickerViewBlock;
	BDPickerRowHeightForComponentBlock rowHeightForComponentBlock;
	BDPickerWidthForComponentBlock widthForComponentBlock;
	BDPickerTitleForRowBlock titleForRowBlock;
	BDPickerDidSelectRowComponentBlock didSelectRowComponentBlock;

}
@property (nonatomic,strong) IBOutlet UIPickerView *pickerView;
@property (nonatomic,strong) IBOutlet UILabel *pickerViewLabel;
@property (nonatomic,strong) IBOutlet UIButton *doneButton;
@property (nonatomic,copy) BDPickerNumberOfComponentsInPickerViewBlock numberOfComponentsInPickerViewBlock;
@property (nonatomic,copy) BDPickerNumberOfRowsInComponentBlock numberOfRowsInComponentBlock;
@property (nonatomic,copy) BDPickerRowHeightForComponentBlock rowHeightForComponentBlock;
@property (nonatomic,copy) BDPickerWidthForComponentBlock widthForComponentBlock;
@property (nonatomic,copy) BDPickerTitleForRowBlock titleForRowBlock;
@property (nonatomic,copy) BDPickerDidSelectRowComponentBlock didSelectRowComponentBlock;

-(IBAction)doneButtonPushed:(id)sender;
-(void)useDoneButton;


@end
