//
//  SDAssetViewController.h
//  TengChuDisclose
//
//  Created by SongDong on 2014-03-10.
//  Copyright (c) 2014 TengChu. All rights reserved.
//  点击图库下某个文件夹（group）进入，获取该group下得所有图片或视频

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "BaseViewController.h"
@class SDAssetPickerController;

@protocol SDAssetControllerDelegate <NSObject>

- (void)assetsPickerController:(SDAssetPickerController *)picker didFinishPickingAssets:(NSMutableArray *)assets;

@end

@interface SDAssetViewController : BaseViewController<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, assign) id<SDAssetControllerDelegate> delegate;

-(id)initWithAssetsGroup:(ALAssetsGroup *)theAssetsGroup;

@end
