//
//  AANumberTableViewCell.m
//  Fibonacci
//
//  Created by Akil Ash on 2/6/15.
//  Copyright (c) 2015 Akil Ash. All rights reserved.
//

#import "AANumberTableViewCell.h"
#import "UIFont+Additions.h"
#import "UIColor+Additions.h"

#define DEFAULT_CELL_FONT [UIFont cooperHewittBookFontOfSize:18.0f]

@interface AANumberTableViewCell ()

@property (nonatomic, strong, readwrite) AANumberItem * numberItem;

@end

@implementation AANumberTableViewCell

#pragma mark - Lifecycle methods

- (void)awakeFromNib {
	self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight;

	self.numLabel.text = @"";
	[self.numLabel setFont:DEFAULT_CELL_FONT];
	[self.numLabel setTextColor:[UIColor numberLabelColor]];
	self.numLabel.lineBreakMode = NSLineBreakByWordWrapping;
	self.numLabel.numberOfLines = 0;
}

-(void)prepareForReuse {
	self.numLabel.text = @"";
}

-(void)layoutSubviews {
	self.numLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.bounds);
}

#pragma mark - Configuration methods

- (void)updateWithNumberItem:(AANumberItem *)numberItem {
	self.numberItem = numberItem;
	self.numLabel.text = [numberItem stringValueForBase10];
	
	[self.numLabel setNeedsLayout];
	
	[self setNeedsUpdateConstraints];
	[self updateConstraintsIfNeeded];
}

@end
