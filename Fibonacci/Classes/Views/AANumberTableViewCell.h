//
//  AANumberTableViewCell.h
//  Fibonacci
//
//  Created by Akil Ash on 2/6/15.
//  Copyright (c) 2015 Akil Ash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AANumberItem.h"
#import "AABaseTableViewCell.h"

@interface AANumberTableViewCell : AABaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel * numLabel;

@property (nonatomic, strong, readonly) AANumberItem * numberItem;

- (void)updateWithNumberItem:(AANumberItem *)numberItem;

@end
