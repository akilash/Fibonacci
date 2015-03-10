//
//  AANumberItem.h
//  Fibonacci
//
//  Created by Akil Ash on 2/7/15.
//  Copyright (c) 2015 Akil Ash. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BigInteger.h"

@interface AANumberItem : NSObject

@property (nonatomic, strong, readonly) BigInteger * bigInteger;

- (instancetype)initWithBigInteger:(BigInteger *)bigInteger;

- (NSString *)stringValueForBase10;

@end
