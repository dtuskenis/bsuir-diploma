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

@interface SearchView () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, weak) IBOutlet UIView *placeholderView;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *tableViewBottomSpace;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *searchBarHeight;

@property (nonatomic, assign) BOOL updateRequired;

@end

@implementation SearchView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.tableView registerNib:[SearchResultCell cellNib] forCellReuseIdentifier:[SearchResultCell cellIdentifier]];
    [self.searchBar setBackgroundImage:[UIImage imageWithSize:self.searchBar.bounds.size color:[UIColor clearColor]]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)layoutIfNeeded {
    self.searchBarHeight.constant = self.searchBar.hidden ? 0.0 : 44.0;
    [super layoutIfNeeded];
}

#pragma mark -
#pragma mark Property

@synthesize searchResults = _searchResults;

- (NSArray *)searchResults {
    if (_searchResults == nil) {
        _searchResults = @[];
    }
    return _searchResults;
}

- (void)setSearchResults:(NSArray *)searchResults {
    _searchResults = searchResults;
    [self.tableView reloadData];
    self.updateRequired = NO;
}

#pragma mark -
#pragma mark Public

- (void)beginRefreshing {
    
}

- (void)endRefreshing {
    if (self.searchResults.count > 0) {
        self.placeholderView.hidden = YES;
        if (self.searchResults.count < 20) {
            if ([self.delegate respondsToSelector:@selector(searchViewNeedMoreData:)]) {
                [self.delegate searchViewNeedMoreData:self];
            }
        }
    } else {
        self.placeholderView.hidden = NO;
    }
}

- (void)hideSearchBar {
    self.searchBar.hidden = YES;
    [self layoutIfNeeded];
}

- (void)hideKeyboard {
    [self.searchBar resignFirstResponder];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    BOOL needUpdate = ((scrollView.contentOffset.y + scrollView.bounds.size.height) / scrollView.contentSize.height) > 0.9;
    if (self.updateRequired == NO && needUpdate) {
        self.updateRequired = YES;
        if ([self.delegate respondsToSelector:@selector(searchViewNeedMoreData:)]) {
            [self.delegate searchViewNeedMoreData:self];
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self hideKeyboard];
}

#pragma mark -
#pragma mark UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([self.delegate respondsToSelector:@selector(searchView:didChangeSearchText:)]) {
        [self.delegate searchView:self didChangeSearchText:searchText];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
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
