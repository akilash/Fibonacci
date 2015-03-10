//
//  AANumberItem.m
//  Fibonacci
//
//  Created by Akil Ash on 2/7/15.
//  Copyright (c) 2015 Akil Ash. All rights reserved.
//

#import "AANumberItem.h"

@interface AANumberItem ()

@property (nonatomic, strong, readwrite) BigInteger * bigInteger;

@end

@implementation AANumberItem

- (instancetype)initWithBigInteger:(BigInteger *)bigInteger {
	
	if (self = [super init]) {
		_bigInteger = bigInteger;
	}
	
	return self;
}

- (NSString *)stringValueForBase10 {

	return [self.bigInteger toRadix:10];
}

@end
