//
//  CategoriesView.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/18/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "CategoriesView.h"

#import "CategoryCell.h"

@interface CategoriesView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation CategoriesView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.tableView registerNib:[CategoryCell cellNib] forCellReuseIdentifier:[CategoryCell cellIdentifier]];
}

#pragma mark -
#pragma mark Properties

- (void)setCategories:(NSArray *)categories {
    _categories = categories;
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:[CategoryCell cellIdentifier] forIndexPath:indexPath];
    
    cell.item = self.categories[indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CategoryCell *cell = (CategoryCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if ([self.delegate respondsToSelector:@selector(categoriesView:didSelectCategory:)]) {
        [self.delegate categoriesView:self didSelectCategory:cell.item];
    }
}

@end
