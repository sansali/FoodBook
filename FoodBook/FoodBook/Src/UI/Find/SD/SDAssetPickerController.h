//
//  SDAssetPickerController.h
//  TengChuDisclose
//
//  Created by SongDong on 2014-03-10.
//  Copyright (c) 2014 TengChu. All rights reserved.
//  获取图库中得各个文件夹（group）

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "HXNavigationController.h"
#import "BaseViewController.h"
//赛选的条件，作为参数传入
typedef enum
{
    AllAssets = 0,
    AllPhotos,
    AllVideos
}AssetsType;

@interface SDAssetPickerController : HXNavigationController

@property(nonatomic, weak) id delegate;

-(id)initWithAssetsType:(AssetsType)assetsType;

@end

@interface SDAssetGroupViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong) NSMutableArray *groups;

@end
