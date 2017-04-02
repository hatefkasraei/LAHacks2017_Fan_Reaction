//
//  CustomView.m
//  LAHacksFin
//
//  Created by Danny Peng on 4/1/17.
//  Copyright © 2017 Danny Peng. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (void)drawRect : (NSRect) dirtyRect {
    [super drawRect:dirtyRect];
    
    CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
    CGContextSetRGBFillColor(context, 0, 0, 0, 0.50);
    CGContextFillRect(context, NSRectToCGRect(dirtyRect));
    //CGContextMoveToPoint(context, 150, 150);
    
    
    
    
    
    self.layer.borderColor = [[NSColor whiteColor] CGColor];
    self.layer.borderWidth = 2.0F;
}

@end
