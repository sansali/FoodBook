//
//  FoodTableViewCell.m
//  FoodBook
//
//  Created by sansali on 15/10/13.
//  Copyright © 2015年 sansali. All rights reserved.
//

#import "CookTableViewCell.h"
#import "FoodBookData.h"
#import "UIImageView+WebCache.h"
@implementation CookTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor getColor:@"f5f5fd"];
        
        _uImgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 12, 50, 50)];
        _uImgView.image = [UIImage imageNamed:@"person"];
        [self addSubview:_uImgView];
        
        _contentLab = [[UILabel alloc] initWithFrame:CGRectMake(75, 18, SCREENWIDTH - 26 - 85, 16)];
        _contentLab.textColor = [UIColor blackColor];
        [self addSubview:_contentLab];
        
        _timeLab = [[UILabel alloc] initWithFrame:CGRectMake(75, 40,SCREENWIDTH - 26 - 85, 16)];
        _timeLab.textColor = [UIColor getColor:@"a1a1a1"];
        [self addSubview:_timeLab];
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(150, 12, SCREENWIDTH - 160, 50)];
        [_imgView setContentMode:UIViewContentModeScaleAspectFit];
        _imgView.image = [UIImage imageNamed:@"person"];
        [self addSubview:_imgView];
        
    }
    return self;
}

-(void)refreshViewWithData:(id)data{
    FoodBookData *nowData = (FoodBookData *)data;
    _contentLab.text = nowData.name;
    _timeLab.text = [Tools dataStringWithDate:[NSDate dateWithTimeIntervalSince1970:nowData.createtime/1000.0]];
    [_uImgView setImageWithURL:[NSURL URLWithString:nowData.uimg] placeholderImage:[UIImage imageNamed:@"person"]];
    [_imgView setImageWithURL:[NSURL URLWithString:nowData.img] placeholderImage:[UIImage imageNamed:@"person"]];

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
