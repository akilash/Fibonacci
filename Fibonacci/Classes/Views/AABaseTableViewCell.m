//
//  AABaseTableViewCell.m
//  Fibonacci
//
//  Created by Akil Ash on 2/11/15.
//  Copyright (c) 2015 Akil Ash. All rights reserved.
//

#import "AABaseTableViewCell.h"

@implementation AABaseTableViewCell

#pragma mark - Cell creation methods

+ (UINib *)nib {
	return [UINib nibWithNibName:[self nibName] bundle:nil];
}

+ (NSString *)nibName {
	return [self cellIdentifier];
}

+ (NSString *)cellIdentifier {
	return NSStringFromClass([self class]);
}

+ (UITableViewCellStyle)cellStyle {
	return UITableViewCellStyleDefault;
}

+ (CGFloat)cellHeight {
	return 50.0f;
}

#pragma mark -

+ (instancetype)cellForTableView:(UITableView *)tableView
				 reuseIdentifier:(NSString *)reuseID {
	
	return [self cellForTableView:tableView
				  reuseIdentifier:reuseID
						  fromNib:nil];
}

+ (instancetype)cellForTableView:(UITableView *)tableView
						 fromNib:(UINib *)nib {
	
	return [self cellForTableView:tableView
				  reuseIdentifier:nil
						  fromNib:nib];
}

+ (instancetype)cellForTableView:(UITableView *)tableView {
	
	return [self cellForTableView:tableView
				  reuseIdentifier:nil
						  fromNib:nil];
}

+ (instancetype)cellForTableView:(UITableView *)tableView
				 reuseIdentifier:(NSString *)reuseID
						 fromNib:(UINib *)nib {
	
	NSParameterAssert(tableView);
	
	// Guarantees that we have a cell identifier.
	if (!reuseID) reuseID = [self cellIdentifier];
	
	// If this cell uses a nib, then it is registered with the table view.
	nib = nib ?: [[self class] nib];
	
	if (nib)
		[tableView registerNib:nib forCellReuseIdentifier:reuseID];
	
	// Dequeues the cell, if any exist. If UIStoryboard is used, then UIKit will
	// create a new cell at this point.
	id cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
	
	// Creates the cell if one doesn't exist.
	if (!cell) {
		
		// Tries to grab a nib, if it exists.
		if (!nib) nib = [self nib];
		
		// Creates the cell from the nib.
		NSArray * nibObjects = [nib instantiateWithOwner:nil options:nil];
		
		// Grabs the cell from the inflated nib, if exists.
		if ([nibObjects count] > 0) {
			
			// Sanity check for creation from a nib.
			// Assumes that the first root object is the desired cell.
			NSAssert2(([nibObjects count] > 0 &&
					   [[nibObjects objectAtIndex:0] isKindOfClass:[self class]]),
					  @"Nib '%@' does not appear to contain a valid %@",
					  [self nibName],
					  NSStringFromClass([self class]));
			
			cell = [nibObjects objectAtIndex:0];
		}
		else
			cell = [[self alloc] initWithStyle:[self cellStyle]
							   reuseIdentifier:reuseID];
	}
	
	return cell;
}

@end
