//
//  UserCenter.h
//  FoodBook
//
//  Created by sansali on 15/9/16.
//  Copyright (c) 2015年 sansali. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface UserCenter : NSObject

@property(nonatomic,strong)User *loginUser;
@property(nonatomic) BOOL isLogined;

+(UserCenter *)shareInstance;

@end
