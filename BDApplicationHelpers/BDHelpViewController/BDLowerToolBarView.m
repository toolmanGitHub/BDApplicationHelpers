//
//  BDLowerToolBarView.m
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


#import "BDLowerToolBarView.h"


@implementation BDLowerToolBarView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	CGContextRef context= UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, [[UIColor darkGrayColor] CGColor]);
	// Draw them with a 2.0 stroke width so they are a bit more visible.
	CGContextSetLineWidth(context, 0.75);
	
	// Draw a single line from left to right
	//CGContextMoveToPoint(context, 0, self.bounds.size.height-1.0);
	//CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height-1.0);
	//CGContextStrokePath(context);
	CGRect myRect=self.bounds;
	CGContextFillRect(context,CGRectMake(0, 1.0, myRect.size.width, 1.0));
	[super drawRect:rect];
	
    // Drawing code.
}


@end
