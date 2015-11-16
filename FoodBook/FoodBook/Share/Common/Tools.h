//
//  Tools.h
//  FoodBook
//
//  Created by sansali on 15/9/16.
//  Copyright (c) 2015年 sansali. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject

+(UILabel *)createLabWithFrame:(CGRect)frame withTitle:(NSString *)title withTitleSize:(float)size withTextColor:(UIColor *)color;
+(UIButton *)createBtnWithFrame:(CGRect)frame withTitle:(NSString *)title withTitleSize:(float)size;
+(UILabel *)createLabWithFrame:(CGRect)frame withAttributed:(NSAttributedString *)title withTitleSize:(float)size withTextColor:(UIColor *)color;
+(void)showAlertWithTitle:(NSString *)title;
+(NSString *)dataStringWithDate:(NSDate *)date;
@end
