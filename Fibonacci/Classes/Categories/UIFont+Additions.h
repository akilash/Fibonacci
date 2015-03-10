//
//  UIFont+Additions.h
//  Fibonacci
//
//  Created by Akil Ash on 2/6/15.
//  Copyright (c) 2015 Akil Ash. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * This category is used to abstract fonts used throughout the app.
 * References to fonts not currently used in the UI are included in
 * the app, as I plan to further develop this project.
 *
 */

@interface UIFont (AAAdditions)

+ (UIFont *)bebasNeueFontOfSize:(CGFloat)size;

+ (UIFont *)freightSansFontOfSize:(CGFloat)size;

+ (UIFont *)cooperHewittBookFontOfSize:(CGFloat)size;

@end
