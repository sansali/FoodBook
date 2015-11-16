//
//  SDAssetCollectionCell.h
//  TengChuDisclose
//
//  Created by SongDong 2014-03-11.
//  Copyright (c) 2014 TengChu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface SDAssetCollectionCell : UICollectionViewCell

- (void)updateWithAsset:(ALAsset *)asset;
-(void)updateState;

@end
