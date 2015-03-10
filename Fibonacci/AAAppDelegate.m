//
//  AppDelegate.m
//  Fibonacci
//
//  Created by Akil Ash on 1/27/15.
//  Copyright (c) 2015 Akil Ash. All rights reserved.
//

#import "AAAppDelegate.h"
#import "AAAppearanceSetup.h"

@interface AAAppDelegate ()

@end

@implementation AAAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	//	Setup default appearances
	[AAAppearanceSetup setAppearances];
	
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
	
    return YES;
}

@end
