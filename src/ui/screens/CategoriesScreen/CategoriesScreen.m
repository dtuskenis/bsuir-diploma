//
//  CategoriesScreen.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/18/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "CategoriesScreen.h"

#import "UIBarButtonItem+Custom.h"

@interface CategoriesScreen ()

@end

@implementation CategoriesScreen

- (instancetype)initWithConfigurationManager:(ConfigurationManager *)configurationManager
                               screenManager:(ScreenManager *)screenManager {
    self = [super initWithScreenManager:screenManager];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = NSLocalizedString(@"Categories", nil);
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem arrowsItemWithTarget:self action:@selector(arrowsButtonTouched:)];
}

#pragma mark -
#pragma mark Actions

- (IBAction)arrowsButtonTouched:(id)sender {
    [self.screenManager switchToSearchScreen];
}

@end
