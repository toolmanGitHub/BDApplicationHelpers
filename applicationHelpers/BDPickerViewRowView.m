//
//  BDPickerViewRowView.m
//  applicationHelpers
//
//  Created by Tim and Jennifer Taylor on 2/10/12.
//  Copyright (c) 2012 Big Diggy SW. All rights reserved.
//

#import "BDPickerViewRowView.h"
#import <QuartzCore/QuartzCore.h>
@implementation BDPickerViewRowView
@synthesize colorWell=colorWell_;
@synthesize colorLabel=colorLabel_;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        colorWell_=[[UIView alloc] initWithFrame:CGRectMake(12.0f, 7.0f, 50.0f, 25.0f)];
        CALayer *colorViewLayer=(CALayer *)self.colorWell.layer;
        //    colorViewLayer.borderWidth=1.0;
        //    colorViewLayer.borderColor=[UIColor lightGrayColor].CGColor;
        colorViewLayer.cornerRadius=4.0f;
        colorViewLayer.shadowColor=[UIColor blackColor].CGColor;
        colorViewLayer.shadowOpacity=0.5;
        colorViewLayer.shadowRadius=2.0f;
        colorViewLayer.shadowOffset=CGSizeMake(0.0f, 1.0f);
        colorLabel_=[[UILabel alloc] initWithFrame:CGRectMake(72.0, 9.0f, 120.0f, 21.0f)];
        colorLabel_.backgroundColor=[UIColor clearColor];
        [self addSubview:colorWell_];
        [self addSubview:colorLabel_];
    }
    return self;
}

-(void)awakeFromNib{
    CALayer *colorViewLayer=(CALayer *)self.colorWell.layer;
    //    colorViewLayer.borderWidth=1.0;
    //    colorViewLayer.borderColor=[UIColor lightGrayColor].CGColor;
    colorViewLayer.cornerRadius=4.0f;
    colorViewLayer.shadowColor=[UIColor blackColor].CGColor;
    colorViewLayer.shadowOpacity=0.5;
    colorViewLayer.shadowRadius=2.0f;
    colorViewLayer.shadowOffset=CGSizeMake(0.0f, 1.0f);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
