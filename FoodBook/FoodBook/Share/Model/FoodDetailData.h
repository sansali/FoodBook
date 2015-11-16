//
//  FoodDetailData.h
//  FoodBook
//
//  Created by sansali on 11/4/15.
//  Copyright © 2015 sansali. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodDetailData : NSObject

@property(nonatomic,strong)NSString *foodId;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *handleText;
@property(nonatomic,strong)NSArray *handleImg;
@property(nonatomic,strong)NSString *stewFoodText;
@property(nonatomic,strong)NSArray *stewFoodImgs;
@property(nonatomic,strong)NSArray *selfArr;

@property(nonatomic)int dislikeCount;
@property(nonatomic)int collectionCount;
@property(nonatomic)int evaCount;
@property(nonatomic)int enjoyCount;

@end
