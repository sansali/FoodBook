//
//  SDZoomScrollView.h
//  TengChuDisclose
//
//  Created by SongDong on 2014-03-14.
//  Copyright (c) 2014 TengChu. All rights reserved.
//   图片缩放器

#import <UIKit/UIKit.h>

@interface SDZoomScrollView : UIScrollView<UIScrollViewDelegate>
{
    BOOL isAmplification;  //是否放大
}

@property(nonatomic, strong) UIImageView *imageView;

- (id)initWithFrame:(CGRect)frame image:(UIImage *)image;

@end
