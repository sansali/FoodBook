//
//  FoodBookData.h
//  FoodBook
//
//  Created by sansali on 15/9/23.
//  Copyright © 2015年 sansali. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodBookData : NSObject

@property(nonatomic,strong)NSString *name;
@property(nonatomic)int evaCount;
@property(nonatomic)int enjoyCount;
@property(nonatomic)int collectionCount;
@property(nonatomic,strong)NSString *flavor;
@property(nonatomic,strong)NSString *foodId;

@property(nonatomic,strong)NSString *address;
@property(nonatomic)long long createtime;
@property(nonatomic,strong)NSString *uimg;
@property(nonatomic,strong)NSString *uid;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *img;


@end
