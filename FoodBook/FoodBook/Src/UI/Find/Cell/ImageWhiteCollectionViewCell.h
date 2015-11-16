//
//  ImageWhiteCollectionViewCell.h
//  TengChuDisclose
//
//  Created by sansali on 15/9/24.
//  Copyright © 2015年 TengChu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageWhiteCollectionViewCell : UICollectionViewCell

@property(nonatomic,copy) void(^tapCallBack)();
@property(nonatomic,copy)UILabel *titleLab;

@end
