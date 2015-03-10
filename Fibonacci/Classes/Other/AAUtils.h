//
//  AAUtils.h
//  Fibonacci
//
//  Created by Akil Ash on 2/11/15.
//  Copyright (c) 2015 Akil Ash. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface AAUtils : NSObject

+ (BOOL)isiOS8;

@end
