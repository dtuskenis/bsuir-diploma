//
//  MenuView.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/12/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "MenuView.h"

#import "MenuViewCell.h"
#import "MenuViewItem.h"
#import "UIColor+Custom.h"

static NSString* const kContentSizeKey = @"contentSize";

@interface MenuView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *tableViewHeight;

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation MenuView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor applicationBackgroundColor];
    self.items = [NSMutableArray array];
    [self.tableView registerNib:[MenuViewCell cellNib] forCellReuseIdentifier:[MenuViewCell cellIdentifier]];
    [self.tableView addObserver:self forKeyPath:kContentSizeKey options:NSKeyValueObservingOptionNew context:NULL];
    [self.tableView setBackgroundColor:[[UIColor applicationDefaultColor] colorWithAlphaComponent:0.1]];
}

- (void)dealloc {
    [self.tableView removeObserver:self forKeyPath:kContentSizeKey];
}

- (void)addItemWithTitle:(NSString *)title icon:(UIImage *)icon action:(void (^)())action {
    MenuViewItem *item = [[MenuViewItem alloc] init];
    item.title = title;
    item.icon = icon;
    item.action = action;
    [self.items addObject:item];
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MenuViewCell cellIdentifier] forIndexPath:indexPath];
    
    cell.item = self.items[indexPath.row];
    cell.checked = (indexPath.row == self.selectedIndex);
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    MenuViewCell *previousCell = (MenuViewCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0]];
    MenuViewCell *selectedCell = (MenuViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    previousCell.checked = NO;
    selectedCell.checked = YES;
    
    self.selectedIndex = indexPath.row;
    
    [tableView reloadData];
    
    MenuViewItem *item = [self.items objectAtIndex:indexPath.row];
    if (item.action) {
        item.action();
    }
}

#pragma mark -
#pragma mark KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:kContentSizeKey] && object == self.tableView) {
        self.tableViewHeight.constant = self.tableView.contentSize.height;
        [self layoutIfNeeded];
    }
}

@end
