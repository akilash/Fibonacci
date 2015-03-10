//
//  AATableViewController.m
//  Fibonacci
//
//  Created by Akil Ash on 1/27/15.
//  Copyright (c) 2015 Akil Ash. All rights reserved.
//

#import "AATableViewController.h"
#import "AANumberTableViewCell.h"
#import "AAFibonacciGenerator.h"
#import "AANumberItem.h"
#import "UIFont+Additions.h"
#import "AAUtils.h"

static const NSInteger PRELOAD_THRESHOLD = 10;

static const CGFloat LABEL_SPACER = 5.0f;

static const CGFloat FOOTER_HEIGHT = 50.f;

@interface AATableViewController ()<AAFibonacciGeneratorDelegate>

@property (nonatomic, strong) AAFibonacciGenerator * fibonacciGenerator;

@property (nonatomic, strong) NSArray * numberList;

@property (nonatomic, strong) AANumberTableViewCell * sizingCell;

@end

@implementation AATableViewController

#pragma mark - Lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = NSLocalizedString(@"Fibonacci", @"view title");
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	
	self.numberList = [NSArray new];
	self.fibonacciGenerator = [AAFibonacciGenerator new];
	self.fibonacciGenerator.delegate = self;
	
	[self setupSizingCell];
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[self setupFooter];
	[self.fibonacciGenerator generateNextPagedSet];
}

#pragma mark - Configuration methods

- (void)setupSizingCell {
	self.sizingCell = [AANumberTableViewCell cellForTableView:self.tableView];
	self.sizingCell.userInteractionEnabled = NO;
	self.sizingCell.hidden = YES;
	[self.tableView addSubview:self.sizingCell];
}

- (void)setupFooter {
	
	UIActivityIndicatorView * activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
	[activityIndicator startAnimating];
	
	UIView * container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, FOOTER_HEIGHT)];
	[container addSubview:activityIndicator];
	self.tableView.tableFooterView = container;
	
	NSLayoutConstraint * constraint_H = [NSLayoutConstraint constraintWithItem:activityIndicator
																	 attribute:NSLayoutAttributeCenterX
																	 relatedBy:NSLayoutRelationEqual
																		toItem:container
																	 attribute:NSLayoutAttributeCenterX
																	multiplier:1.0f
																	  constant:0.0f];
	
	NSLayoutConstraint * constraint_V = [NSLayoutConstraint constraintWithItem:activityIndicator
																	 attribute:NSLayoutAttributeCenterY
																	 relatedBy:NSLayoutRelationEqual
																		toItem:container
																	 attribute:NSLayoutAttributeCenterY
																	multiplier:1.0f
																	  constant:0.0f];
	
	NSArray * constraints_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[view(20)]"
																	  options:NSLayoutFormatAlignAllBaseline
																	  metrics:nil
																		views:@{ @"view": activityIndicator}];
	
	NSArray * constraints_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[view(20)]"
																	  options:NSLayoutFormatAlignAllBaseline
																	  metrics:nil
																		views:@{ @"view": activityIndicator}];
	
	[container addConstraints:@[constraint_H, constraint_V]];
	[container addConstraints:constraints_H];
	[container addConstraints:constraints_V];
	
}

- (void)checkIfPreloadIsNeeded {
	
	for (UITableViewCell * cell in self.tableView.visibleCells) {
		NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
		
		if (indexPath.row >= self.numberList.count - PRELOAD_THRESHOLD &&
			self.fibonacciGenerator.state != AAFibonacciGeneratorStateIdle &&
			self.fibonacciGenerator.state != AAFibonacciGeneratorStateProcessing) {
			[self.fibonacciGenerator generateNextPagedSet];
		}
	}
}

#pragma mark - UITableViewDatasource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.numberList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	AANumberItem * numberItem = [self.numberList objectAtIndex:indexPath.row];
	AANumberTableViewCell * cell = [AANumberTableViewCell cellForTableView:tableView];
	[cell updateWithNumberItem:numberItem];
	
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	AANumberItem * numberItem = [self.numberList objectAtIndex:indexPath.row];
	[self.sizingCell updateWithNumberItem:numberItem];
	CGFloat height = [self.sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + LABEL_SPACER;
	
	return height;
}

#pragma mark - UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return [AANumberTableViewCell cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"Selected Index: %ld", (long)indexPath.row);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	[self checkIfPreloadIsNeeded];
}

#pragma mark - AAFibonacciGeneratorDelegate methods

- (void)onFibonacciNumbersGenerated:(NSArray *)list {
	
	if (![NSThread isMainThread]) {
		NSAssert(NO, @"This method MUST be called on the main thread");
		return;
	}
	
	//	AANote: The following statement where we mutate
	//	the self.numberList is undeniebly a critical section.
	//	We enforce concurrent mutual exclusion by asserting
	//	(returning from method on a release build) if this
	//	method is called on a thread that isn't the main thread.
	//	In doing so, we are enforcing a policy whereby public API
	//	delegate methods returning a "truth" with respect to data,
	//	is always called on the main thread.
	
	self.numberList = [self.numberList arrayByAddingObjectsFromArray:list];
	[self.tableView reloadData];
}

@end
