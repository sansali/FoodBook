//
//  UserCenter.m
//  FoodBook
//
//  Created by sansali on 15/9/16.
//  Copyright (c) 2015年 sansali. All rights reserved.
//

#import "UserCenter.h"

@implementation UserCenter

+(id)shareInstance{
    static UserCenter *instance;
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
        instance = [[UserCenter alloc] init];
    });
    return instance;
}

-(id)init{
    self = [super init];
    if (self) {
        _loginUser = [[User alloc] init];
    }
    return self;
}


@end
