//
//  UIFont+Additions.m
//  Fibonacci
//
//  Created by Akil Ash on 2/6/15.
//  Copyright (c) 2015 Akil Ash. All rights reserved.
//

#import "UIFont+Additions.h"

@implementation UIFont (AAAdditions)

+ (UIFont *)bebasNeueFontOfSize:(CGFloat)size
{
	return [UIFont fontWithName:@"BebasNeue" size:size];
}

+ (UIFont *)freightSansFontOfSize:(CGFloat)size
{
	return  [UIFont fontWithName:@"FreightSansCmpPro-Light" size:size];
}

+ (UIFont *)cooperHewittBookFontOfSize:(CGFloat)size
{
	return  [UIFont fontWithName:@"CooperHewitt-Book" size:size];
}

+ (UIFont *)fontWithFontString:(NSString *)fontString size:(CGFloat)size
{
	// Maps the cleaner font names than the font file names.
	NSDictionary * fontDict = @{
								@"Bebas": @"BebasNeue",
								@"FreightLight": @"FreightSansCmpPro-Light",
								@"CooperHewitt": @"CooperHewitt-Book"
								};
	
	NSString * fontName = fontDict[fontString];
	
	NSAssert(fontName, @"Unknown font: %@, expected one of %@", fontString, [fontDict allKeys]);
	
	return [UIFont fontWithName:fontName size:size];
}

@end

@implementation UILabel (Fonts)

- (void)setFontString:(NSString *)fontString
{
	UIFont *font = [UIFont fontWithFontString:fontString size:self.font.pointSize];
	
	if (font) {
		
		self.font = font;
	}
}

@end

@implementation UIButton (Fonts)

- (void)setFontString:(NSString *)fontString
{
	UIFont *font = [UIFont fontWithFontString:fontString size:self.titleLabel.font.pointSize];
	
	if (font) {
		
		self.titleLabel.font = font;
	}
}

@end

@implementation UINavigationBar (Fonts)

- (void)setFontString:(NSString *)fontString
{
	UIFont *font = [UIFont fontWithFontString:fontString size:30.f];
	
	if (font) {
		
		[self setTitleTextAttributes:@{
									   NSFontAttributeName: font,
									   NSForegroundColorAttributeName: [UIColor whiteColor]
									   }];
	}
}

@end
