//
//  AAAppearanceSetup.m
//  Fibonacci
//
//  Created by Akil Ash on 2/6/15.
//  Copyright (c) 2015 Akil Ash. All rights reserved.
//

#import "AAAppearanceSetup.h"
#import "UIFont+Additions.h"
#import "UIColor+Additions.h"

@implementation AAAppearanceSetup

+ (void)setAppearances {
	
	//	Set the text formatting attributes of the bar button items
	
	NSDictionary * titleTextAttributes = @{ NSForegroundColorAttributeName:[UIColor whiteColor],
											NSFontAttributeName:[UIFont bebasNeueFontOfSize:26.0f] };
	
	[[UINavigationBar appearance] setBarTintColor:[UIColor navBarColor]];
	
	[[UINavigationBar appearance] setTitleTextAttributes:titleTextAttributes];
	
	[[UINavigationBar appearance] setTintColor:[UIColor navBarColor]];
	
	[[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes: titleTextAttributes
																							forState:UIControlStateNormal];
	
	[[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal];
}

@end
