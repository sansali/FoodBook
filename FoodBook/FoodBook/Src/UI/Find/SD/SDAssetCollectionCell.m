//
//  SDAssetCollectionCell.m
//  TengChuDisclose
//
//  Created by SongDong on 2014-03-11.
//  Copyright (c) 2014 TengChu. All rights reserved.
//

#import "SDAssetCollectionCell.h"

#define Length 102.0

@interface SDAssetCollectionCell()
{
     UIImage *videoIcon;
     UIImage *selectedIcon;
}

@property (nonatomic, strong) ALAsset *asset;
@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) UIImageView *imageView;    //图片
@property (nonatomic, strong) UIImageView *videoImageView;   //视频的标记icon
@property (nonatomic, strong) UIImageView *selectedIconView;    //选中时候的钩钩Icon

@end

@implementation SDAssetCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        videoIcon  = [UIImage imageNamed:@"CTAssetsPickerVideo"];
        selectedIcon     = [UIImage imageNamed:@"CTAssetsPickerChecked"];
        
        //图片
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, Length, Length)];
        [self.contentView addSubview:self.imageView];
        
        //选中的钩钩
        self.selectedIconView =  [[UIImageView alloc] initWithFrame:CGRectMake((Length-selectedIcon.size.width)-2.0
                                                                               , 2,
                                                                               selectedIcon.size.width,
                                                                               selectedIcon.size.height)];
        [self.selectedIconView setImage:selectedIcon];
        [self.contentView addSubview:self.selectedIconView];
        
        //视频标记
        self.videoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((Length-videoIcon.size.width)/2.0
                                                                            , (Length-videoIcon.size.height)/2.0,
                                                                            videoIcon.size.width,
                                                                            videoIcon.size.height)];
        [self.videoImageView setImage:videoIcon];
        self.videoImageView.hidden = YES;
        [self.contentView addSubview:self.videoImageView];
    }
    return self;
}

- (void)updateWithAsset:(ALAsset *)asset
{
    self.asset = asset;
    self.type = [asset valueForProperty:ALAssetPropertyType];
    
    [self updateState];
    //图片
    UIImage *image = [UIImage imageWithCGImage:asset.thumbnail];
    [self.imageView setImage:image];
}

-(void)updateState
{
    if (self.selected)
    {
        self.selectedIconView.image = [UIImage imageNamed:@"CTAssetsPickerChecked"];
    }
    else
    {
        self.selectedIconView.image = [UIImage imageNamed:@"CTAssetsPickerCheck"];
    }
    
    if ([self.type isEqual:ALAssetTypeVideo])
    {
        self.videoImageView.hidden = NO;
    }
    else
    {
        self.videoImageView.hidden = YES;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}*/

@end
