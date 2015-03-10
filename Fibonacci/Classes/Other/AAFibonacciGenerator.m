//
//  AAFibonacciGenerator.m
//  Fibonacci
//
//  Created by Akil Ash on 2/6/15.
//  Copyright (c) 2015 Akil Ash. All rights reserved.
//

#import "AAFibonacciGenerator.h"
#import "AANumberItem.h"
#import "BigInteger.h"

static const NSUInteger PRELOAD_THRESHOLD = 50;

static const NSUInteger PAGED_SET_THRESHOLD = 50;

@interface AAFibonacciGenerator ()

@property (nonatomic, strong) NSArray * fullList;

@property (nonatomic, strong) NSArray * lastPagedList;

@property (nonatomic, assign) NSUInteger currentOffset;

@property (nonatomic, strong) dispatch_queue_t serialQueue;

@end

@implementation AAFibonacciGenerator

- (instancetype)init {
	if ((self = [super init])) {
		
		_state = AAFibonacciGeneratorStateInitial;
		_serialQueue = dispatch_queue_create("com.akilash.FibonacciGenerator.serial", NULL);
		_currentOffset = 0;
		_fullList = [NSArray new];
		_lastPagedList = [NSArray new];
	}
	return self;
}

- (void)generateFibonacciWithOffset:(NSUInteger)offset {
	
	__weak AAFibonacciGenerator * weakSelf = self;
	
	dispatch_async(self.serialQueue, ^{
		AAFibonacciGenerator * strongSelf = weakSelf;
		
		if (!strongSelf) {
			NSAssert(NO, @"strongSelf is nil and thus, we have prematurely deallocated");
			return;
		}
		
		//	Transition the generator to the processing state
		strongSelf.state = AAFibonacciGeneratorStateProcessing;
		
		NSUInteger startIndex = 0;
		NSUInteger lastIndex = PRELOAD_THRESHOLD;
		NSMutableArray * list = [NSMutableArray new];
		BigInteger * a;
		BigInteger * b;
		
		if (offset != 0) {
			startIndex = strongSelf.currentOffset-1;
			lastIndex = startIndex + PAGED_SET_THRESHOLD;
			
			NSUInteger penultimateIndex = strongSelf.fullList.count-2;	//	Represents the second-to-last index; this is a summarization local variable
			BigInteger * lastBigInteger = [[strongSelf.fullList lastObject] bigInteger];
			BigInteger * penultimateBigInteger = [[strongSelf.fullList objectAtIndex:penultimateIndex] bigInteger];
			
			a = [BigInteger bigintWithBigInteger:penultimateBigInteger];
			b = [BigInteger bigintWithBigInteger:lastBigInteger];
			
		} else {
			
			a = [BigInteger bigintWithUnsignedInt32:0];
			b = [BigInteger bigintWithUnsignedInt32:1];
			
			//	Seed the list with the initial 2 values in the sequence
			[list addObjectsFromArray:@[[[AANumberItem alloc] initWithBigInteger:a],
										[[AANumberItem alloc] initWithBigInteger:b]]];
		}
		
		//	AANote: Using dynamic programming/iterative approach using
		//	loops instead of recursion to generate the fibonacci sequence.
		//	This algorithm is much faster than the extremely slow recursive approach
		//	but generally not as efficient with significant inputs as the Fast
		//	doubling approach.  In general, this approach uses less space than
		//	many alternatives and is optimally efficent enough for the exercise.
		
		for (; startIndex < lastIndex; startIndex++) {
			BigInteger * c = [a add:b];
			a = b;
			b = c;
			
			[list addObject:[[AANumberItem alloc] initWithBigInteger:b]];
		}
		
		//	Cache the generated list
		strongSelf.fullList = [strongSelf.fullList arrayByAddingObjectsFromArray:list];
		strongSelf.lastPagedList = list;
		strongSelf.currentOffset = strongSelf.fullList.count;
		
		//	Transition the generator to the completed state
		strongSelf.state = AAFibonacciGeneratorStateCompleted;
		
		dispatch_async(dispatch_get_main_queue(), ^{
			if (!strongSelf || !strongSelf.delegate) {
				NSAssert(NO, @"There has been a terminal failure, as an instance of AAFibonacciGenerator has been prematurely deallocated. Correct order of the outputted sequence will not be gauranteed.");
				return;
			}
			
			if ([strongSelf.delegate respondsToSelector:@selector(onFibonacciNumbersGenerated:)]) {
				[strongSelf.delegate onFibonacciNumbersGenerated:strongSelf.lastPagedList];
			}
		});
	});
}

#pragma mark - Pagination methods

- (void)generateNextPagedSet {
	
	@synchronized(self) {
		
		//	AANote: We must immediately transition the state
		//	to idle, as it awaits transition to the
		//	processing state.  Outside actors introspecting
		//	this object's state use that infomation to then
		//	prohibit subsequent enqueuing of processing work units
		//	until the last processing operation has completed.
		
		self.state = AAFibonacciGeneratorStateIdle;
		
		NSUInteger offset = self.currentOffset;
		
		NSLog(@"\nGENERATE NEXT PAGED SET\n");
		
		[self generateFibonacciWithOffset:offset];
	}
	
}

@end
