//
//  SDAssetGroupViewCell.m
//  TengChuDisclose
//
//  Created by SongDong on 2014-03-10.
//  Copyright (c) 2014 TengChu. All rights reserved.
//

#import "SDAssetGroupViewCell.h"

@implementation SDAssetGroupViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

-(void)updateWithAssetsGroup:(ALAssetsGroup *)assetsGroup
{
    CGImageRef posterImage = assetsGroup.posterImage;
    size_t height = CGImageGetHeight(posterImage);
    float scle = height/78.0;
    
    self.imageView.image = [UIImage imageWithCGImage:posterImage scale:scle orientation:UIImageOrientationUp];
    self.textLabel.text = [assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    self.detailTextLabel.text = [NSString stringWithFormat:@"%d", [assetsGroup numberOfAssets]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
