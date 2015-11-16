//
//  MediaAddCollectionViewCell.h
//  TengChuDisclose
//
//  Created by SongDong on 2014-04-04.
//  Copyright (c) 2014 TengChu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MediaAddCollectionViewCellDelegate <NSObject>

@optional
-(void)addImage;

@end

@interface MediaAddCollectionViewCell : UICollectionViewCell

@property(nonatomic, assign) id<MediaAddCollectionViewCellDelegate> delegate;

@end
