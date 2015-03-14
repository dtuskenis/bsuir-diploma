//
//  DrawerView.h
//  Cookbook
//
//  Created by Tuskenis, Denis on 3/6/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawerView : UIView

@property (nonatomic, strong) IBOutlet UIView *leftView;
@property (nonatomic, strong) IBOutlet UIView *centerView;

- (void)showLeftSideAnimated:(BOOL)animated;
- (void)hideLeftSideAnimated:(BOOL)animated;

- (void)toggleLeftSideAnimated:(BOOL)animated;

@end
