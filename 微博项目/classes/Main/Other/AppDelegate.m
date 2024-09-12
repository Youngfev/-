//
//  AppDelegate.m
//  微博项目
//
//  Created by Youngfev on 15/12/4.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "AppDelegate.h"
#import "HWTabbarViewController.h"
#import "HWNewFeatureController.h"
#include "HWOAuthController.h"
#import "HWAccount.h"
#import "HWAccountTool.h"
#import "SDWebImageManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;

    HWAccount *account = [HWAccountTool account];
    
    if (account) {
        
        NSString *key = @"CFBundleVersion";
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];//从沙盒中读取info.plist中的版本，专用于读取info.plist
        NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];//从沙盒中读取版本号
        if ([lastVersion isEqualToString:currentVersion]) {
                HWTabbarViewController *tabBarVC = [[HWTabbarViewController alloc]init];//
                self.window.rootViewController = tabBarVC;
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];//将版本号存储到沙盒
            [[NSUserDefaults standardUserDefaults] synchronize];//立即存储进沙盒
            HWNewFeatureController *newFeature = [[HWNewFeatureController alloc] init];
            self.window.rootViewController = newFeature;
        }
        
    }else{
        self.window.rootViewController = [[HWOAuthController alloc] init];
    }
    
    [self.window makeKeyAndVisible];
    
    
    //注册角标
//    float sysVersion=[[UIDevice currentDevice]systemVersion].floatValue;
//    
//    if (sysVersion>=8.0) {
    
        UIUserNotificationType type=UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
        
        UIUserNotificationSettings *setting=[UIUserNotificationSettings settingsForTypes:type categories:nil];
        
        [[UIApplication sharedApplication]registerUserNotificationSettings:setting];
        
//    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
#warning 后台运行
    __block UIBackgroundTaskIdentifier task = [application beginBackgroundTaskWithExpirationHandler:^{
        [application endBackgroundTask:task];
    }];
}


-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    //取消下载
    [manager cancelAll];
    
    //清除内存中的所有图片
    [manager.imageCache clearMemory];
}

@end
