//
//  SearchView.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 2/14/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "SearchView.h"

#import "SearchResultCell.h"
#import "UIColor+Custom.h"
#import "UIImage+Solid.h"

@interface SearchView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *tableViewBottomSpace;

@end

@implementation SearchView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.tableView registerNib:[SearchResultCell cellNib] forCellReuseIdentifier:[SearchResultCell cellIdentifier]];
    [self.searchBar setBackgroundImage:[UIImage imageWithSize:self.searchBar.bounds.size color:[UIColor applicationDefaultColor]]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark Property

@synthesize searchResults = _searchResults;

- (void)setSearchResults:(NSArray *)searchResults {
    _searchResults = searchResults;
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark Public

- (void)beginRefreshing {
    
}

- (void)endRefreshing {
    
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:[SearchResultCell cellIdentifier] forIndexPath:indexPath];
    cell.item = self.searchResults[indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(searchView:didSelectRecipe:)]) {
        [self.delegate searchView:self didSelectRecipe:self.searchResults[indexPath.row]];
    }
}

#pragma mark -
#pragma mark NSNotification

- (void)keyboardWillShow:(NSNotification *)notification {
    NSTimeInterval animationDuration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:animationDuration animations:^{
        self.tableViewBottomSpace.constant = keyboardFrame.size.height;
        [self layoutIfNeeded];
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSTimeInterval animationDuration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:animationDuration animations:^{
        self.tableViewBottomSpace.constant = 0;
        [self layoutIfNeeded];
    }];
}

@end
