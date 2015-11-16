//
//  AppDelegate.h
//  FoodBook
//
//  Created by sansali on 9/15/15.
//  Copyright (c) 2015 sansali. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+(void)showLoginVCWithLoginSuccessCallBack:(void(^)(BOOL))callBack;
+(void)gotoHome;

@end

