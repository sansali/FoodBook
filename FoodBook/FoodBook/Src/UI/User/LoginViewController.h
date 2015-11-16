//
//  LoginViewController.h
//  FoodBook
//
//  Created by sansali on 15/9/15.
//  Copyright (c) 2015年 sansali. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface LoginViewController : BaseViewController

@property(nonatomic) BOOL isPresent;
@property(nonatomic,copy) void(^loginCallBack)(BOOL success);

@end
