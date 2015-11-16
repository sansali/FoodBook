//
//  ImageLoadCollectionViewCell.h
//  TengChuDisclose
//
//  Created by SongDong on 2014-04-03.
//  Copyright (c) 2014 TengChu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageLoadCollectionViewCellDelegate <NSObject>

//删除
-(void)deleteImageWithIndex:(int)index;

//点击图片预览
-(void)tapPreviewWithIndex:(int)index;

@end

@interface ImageLoadCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong) UIImage *image;

- (void)updateWithImage:(UIImage *)image index:(int)index;

@property (nonatomic, assign) id<ImageLoadCollectionViewCellDelegate> delegate;

@end
