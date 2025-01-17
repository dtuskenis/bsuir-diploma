//
//  AppDelegate.m
//  Cookbook
//
//  Created by Tuskenis, Denis on 1/15/15.
//  Copyright (c) 2015 Qulix Systems. All rights reserved.
//

#import "AppDelegate.h"

#import "ConfigurationManager.h"
#import "ScreenManager.h"
#import "SearchManager.h"
#import "ServiceManager.h"
#import "ServiceProvider.h"
#import "RecipesManager.h"
#import "UIColor+Custom.h"
#import "UIImage+Solid.h"

@interface AppDelegate () <ServiceProvider>

@property (nonatomic, strong) ScreenManager *screenManager;
@property (nonatomic, strong) NSMutableDictionary *services;

@end

@implementation AppDelegate

- (instancetype)init {
    self = [super init];
    if (self) {
        self.services = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark -
#pragma mark ServiceProvider

- (id)getServiceWithClass:(Class)serviceClass {
    return [self.services objectForKey:NSStringFromClass(serviceClass)];
}

- (void)registerService:(id)service withClass:(Class)serviceClass {
    [self.services setObject:service forKey:NSStringFromClass(serviceClass)];
}

#pragma mark -
#pragma mark UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // Global appearance
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithSize:CGSizeMake(320, 64) color:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    [[UINavigationBar appearance] setTintColor:[UIColor applicationTintColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:18.0],
                                                           NSForegroundColorAttributeName : [UIColor applicationTintColor]
                                                           }];
    
    // Applications services
    RecipesManager *recipesManager = [[RecipesManager alloc] initWithServiceManager:[ServiceManager sharedInstance]];
    [self registerService:recipesManager withClass:[RecipesManager class]];
    
    SearchManager *seachManager = [[SearchManager alloc] initWithServiceManager:[ServiceManager sharedInstance]];
    [self registerService:seachManager withClass:[SearchManager class]];
    
    ConfigurationManager *configurationManager = [[ConfigurationManager alloc] initWithServiceManager:[ServiceManager sharedInstance]];
    [self registerService:configurationManager withClass:[ConfigurationManager class]];
    
    // Start UI
    self.screenManager = [[ScreenManager alloc] initWithServiceProvider:self];
    [self.screenManager initializeWindow];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
