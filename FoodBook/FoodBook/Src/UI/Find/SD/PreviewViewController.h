//
//  PreviewViewController.h
//  TengChuDisclose
//
//  Created by SongDong on 2014-03-12.
//  Copyright (c) 2014 TengChu. All rights reserved.
//  图片预览器

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@protocol PreviewViewControllerDelegate <NSObject>

-(void)removeImgWithIndex:(int)index;

@end

@interface PreviewViewController : BaseViewController<UIScrollViewDelegate>
{
    
    __unsafe_unretained id<PreviewViewControllerDelegate> m_delegate;
    
}

@property(nonatomic, assign) int currentImageIndex;   //传入参数 首先显示第几张图片  默认从数组第一个（0）开始显示
@property(nonatomic,assign)id<PreviewViewControllerDelegate> m_delegate;
@property BOOL isHiddenDelete;

- (id)initWithAssets:(NSMutableArray *)assets;
- (id)initWithImages:(NSMutableArray *)images;

@end
