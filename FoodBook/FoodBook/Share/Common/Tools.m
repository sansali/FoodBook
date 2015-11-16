//
//  Tools.m
//  FoodBook
//
//  Created by sansali on 15/9/16.
//  Copyright (c) 2015年 sansali. All rights reserved.
//

#import "Tools.h"

@implementation Tools

+(UILabel *)createLabWithFrame:(CGRect)frame withTitle:(NSString *)title withTitleSize:(float)size withTextColor:(UIColor *)color{
    UILabel *lab = [[UILabel alloc] initWithFrame:frame];
    lab.textColor = color;
    lab.text = title;
    lab.font = [UIFont systemFontOfSize:size];
    return lab;
}

+(UILabel *)createLabWithFrame:(CGRect)frame withAttributed:(NSAttributedString *)title withTitleSize:(float)size withTextColor:(UIColor *)color{
    UILabel *lab = [[UILabel alloc] initWithFrame:frame];
    lab.textColor = color;
    lab.attributedText = title;
//    lab.font = [UIFont systemFontOfSize:size];
    return lab;
}

+(UIButton *)createBtnWithFrame:(CGRect)frame withTitle:(NSString *)title withTitleSize:(float)size{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom ];
    btn.frame = frame;
    [btn.titleLabel setFont:[UIFont systemFontOfSize:size]];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateHighlighted];
    return btn;
}

+(void)showAlertWithTitle:(NSString *)title{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:title delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alert show];
}

+(NSString *)dataStringWithDate:(NSDate *)date{
    NSDate *nowDate = [NSDate date];
    double distanceTime = [nowDate timeIntervalSinceDate:date];
    
    if (distanceTime < 59*60) {
        return [NSString stringWithFormat:@"%d分钟前",(int)distanceTime/60];
    }else if(distanceTime < 24*60*60){
        return [NSString stringWithFormat:@"%d小时前",(int)distanceTime/60/60];

    }else{
        return [NSString stringWithFormat:@"%d天前",(int)distanceTime/60/60/24];
    }
}

@end
