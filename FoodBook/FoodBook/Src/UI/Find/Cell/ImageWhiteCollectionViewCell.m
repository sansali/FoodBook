//
//  ImageWhiteCollectionViewCell.m
//  TengChuDisclose
//
//  Created by sansali on 15/9/24.
//  Copyright © 2015年 TengChu. All rights reserved.
//

#import "ImageWhiteCollectionViewCell.h"

@implementation ImageWhiteCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 65, 65)];
        _titleLab.text = @"添加图片";
        _titleLab.textColor = [UIColor getColor:@"a1a1a1"];
        _titleLab.font = [UIFont systemFontOfSize:15.0];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLab];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}


-(void)viewTap:(UITapGestureRecognizer *)tap
{
    _tapCallBack();
}

@end
