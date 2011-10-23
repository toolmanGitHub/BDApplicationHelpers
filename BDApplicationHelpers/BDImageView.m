//
//  BDImageView.m
//  How Many Days
//
//  Created by Tim Taylor on 10/22/11.
//  Copyright 2011 Big Diggy SW. All rights reserved.//

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


#import "BDImageView.h"

@interface BDImageView (){
    
}
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic,strong) UIColor *fillColor;
@property (nonatomic,strong) UIImage *iconImage;
@property CGFloat strokeWidth;
@property CGFloat cornerRadius;


-(void)drawRoundedRect:(CGRect)rect inContext:(CGContextRef)context;
-(void)drawBevelWithRect:(CGRect)rect inContext:(CGContextRef)context;


@end

@implementation BDImageView
@synthesize strokeColor = strokeColor_;
@synthesize fillColor = fillColor_;
@synthesize strokeWidth = strokeWidth_;
@synthesize cornerRadius = cornerRadius_;
@synthesize iconImage = iconImage_;


- (id)initWithCoder:(NSCoder *)decoder
{
//	NSLog(@"initWithCoder");
    if ( (self = [super initWithCoder:decoder]) ){
        self.backgroundColor = [UIColor clearColor];
        strokeColor_ = kDefaultStrokeColor;
		fillColor_ = kDefaultBevelFillColor;
        strokeWidth_ = kDefaultStrokeWidth;
        cornerRadius_ = kDefaultCornerRadius;
	}
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		
    }
    return self;
}


- (void)clipRoundedRect:(CGRect)rect inContext:(CGContextRef)context
{
	
    [self drawRoundedRect:rect inContext:context];
	//	CGContextDrawPath(context, kCGPathFillStroke);
	CGContextClip(context);
 //   CGContextFillPath(context);
}

-(void)drawRoundedRect:(CGRect)rect inContext:(CGContextRef)context{
	float radius = kDefaultCornerRadius;
  	CGContextSetLineWidth(context, self.strokeWidth);
    CGContextSetStrokeColorWithColor(context, self.strokeColor.CGColor);
	
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, CGRectGetMinX(rect) + radius, CGRectGetMinY(rect));
    CGContextAddArc(context, CGRectGetMaxX(rect) - radius, CGRectGetMinY(rect) + radius, radius, 3 * M_PI / 2, 0, 0);
    CGContextAddArc(context, CGRectGetMaxX(rect) - radius, CGRectGetMaxY(rect) - radius, radius, 0, M_PI / 2, 0);
    CGContextAddArc(context, CGRectGetMinX(rect) + radius, CGRectGetMaxY(rect) - radius, radius, M_PI / 2, M_PI, 0);
    CGContextAddArc(context, CGRectGetMinX(rect) + radius, CGRectGetMinY(rect) + radius, radius, M_PI, 3 * M_PI / 2, 0);
    
    CGContextClosePath(context);
	
}

-(UIImage *)iconImage;
{
    if (iconImage_!=nil)
        return iconImage_;

    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"Icon.png" ofType:nil];
    iconImage_ = [UIImage imageWithContentsOfFile:imagePath];
	return iconImage_;
}

-(void)drawBevelWithRect:(CGRect)rect inContext:(CGContextRef)context{
	CGFloat bevelSize=kDefaultBevelSize;
	
	
	CGRect bevelRect=CGRectMake(rect.size.width/2-bevelSize/2, rect.size.height/2, bevelSize, bevelSize);
	
	CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
	CGContextSetAlpha(context, 0.35);
	CGContextFillEllipseInRect(context, bevelRect);

}

- (void)drawRect:(CGRect)rect
{
  //   [super drawRect:rect];
	//NSLog(@"BDImageView drawRect Start");
	CGContextRef context = UIGraphicsGetCurrentContext(); 
	[self clipRoundedRect:self.bounds inContext:context];

	
	// NOTE
	// So that the images in this app appear right-side-up, we flip the context
	// In doing so we need to specify all of our Y positions relative to the height of the view.
	// The value we subtract from the height is the Y coordinate for the *bottom* of the image.
	CGFloat height = self.bounds.size.height;
	CGContextTranslateCTM(context, 0.0, height);
	CGContextScaleCTM(context, 1.0, -1.0);
	
	
	// Draw the image
	CGContextDrawImage(context, rect, [self.iconImage CGImage]);
	[self drawRoundedRect:rect inContext:context];
	CGContextDrawPath(context, kCGPathStroke);
	CGContextSetLineWidth(context, self.strokeWidth);
    CGContextSetStrokeColorWithColor(context, self.strokeColor.CGColor);
	
	[self drawBevelWithRect:rect inContext:context];
	
	
}






@end
