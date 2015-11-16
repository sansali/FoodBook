//
//  User.h
//  FoodBook
//
//  Created by sansali on 15/9/16.
//  Copyright (c) 2015年 sansali. All rights reserved.
//

#import "BaseModel.h"

@interface User : BaseModel

@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *phone;
@property(nonatomic,copy)NSString *name;
@property(nonatomic)int sex;
@property(nonatomic,copy)NSString *introduce;
@property(nonatomic)long long registerTime;
@property(nonatomic,copy)NSString *birthday;
@property(nonatomic,copy)NSString *remark;
@property(nonatomic,copy)NSString *img;
@property(nonatomic,copy)NSString *token;



@end
