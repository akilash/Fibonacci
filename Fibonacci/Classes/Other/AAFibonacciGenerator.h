//
//  AAFibonacciGenerator.h
//  Fibonacci
//
//  Created by Akil Ash on 2/6/15.
//  Copyright (c) 2015 Akil Ash. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * The states defined here are used to define the states
 * the AAFibonacciGenerator can transition.  
 * The -[AAFibonacciGenerator state] property captures the 
 * current state of this object who's lifecycle is managed
 * by the context that instantiates it.  Safeguards were put 
 * inplace to ensure thread-safety and generally optimal 
 * threading efficiency
 *
 */

typedef NS_ENUM(NSUInteger, AAFibonacciGeneratorState) {
	
	AAFibonacciGeneratorStateInitial = 0,
	
	AAFibonacciGeneratorStateIdle,
	
	AAFibonacciGeneratorStateProcessing,
	
	AAFibonacciGeneratorStateCompleted
};

@protocol AAFibonacciGeneratorDelegate <NSObject>

- (void)onFibonacciNumbersGenerated:(NSArray *)list;

@end

@interface AAFibonacciGenerator : NSObject

@property (atomic, assign) AAFibonacciGeneratorState state;

@property (nonatomic, weak) id<AAFibonacciGeneratorDelegate> delegate;

- (void)generateNextPagedSet;

@end
