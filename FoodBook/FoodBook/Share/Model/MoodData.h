//
//  MoodData.h
//  FoodBook
//
//  Created by sansali on 15/10/14.
//  Copyright © 2015年 sansali. All rights reserved.
//

#import "BaseModel.h"

@interface MoodData : BaseModel

@property(nonatomic,copy)NSString *moodId;
@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *state;
@property(nonatomic,copy)NSString *content;
@property(nonatomic)long long time;
@property(nonatomic,copy)NSArray *imgs;
@property(nonatomic,copy)NSString *uimg;

@end
