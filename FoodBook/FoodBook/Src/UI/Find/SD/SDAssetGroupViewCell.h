//
//  SDAssetGroupViewCell.h
//  TengChuDisclose
//
//  Created by SongDong on 2014-03-10.
//  Copyright (c) 2014 TengChu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface SDAssetGroupViewCell : UITableViewCell

-(void)updateWithAssetsGroup:(ALAssetsGroup *)assetsGroup;

@end
