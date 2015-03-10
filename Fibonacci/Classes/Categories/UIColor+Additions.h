//
//  UIColor+Additions.h
//  Fibonacci
//
//  Created by Akil Ash on 2/6/15.
//  Copyright (c) 2015 Akil Ash. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat kAARGBMax = 255.0f;

#define RGB(a, b, c) RGBA(a, b, c, 1.0f)

#define RGBA(a, b, c, d) [UIColor colorWithRed:(a / kAARGBMax) green:(b / kAARGBMax) blue:(c / kAARGBMax) alpha:d]

/**
 * This category is used to abstract commonly used colors 
 * used throughout the app
 *
 */

@interface UIColor (AAAdditions)

+ (UIColor *)numberLabelColor;

+ (UIColor *)navBarColor;

@end
