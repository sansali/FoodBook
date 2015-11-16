//
//  InformationHeadTableViewCell.m
//  FoodBook
//
//  Created by sansali on 15/10/12.
//  Copyright © 2015年 sansali. All rights reserved.
//

#import "InformationHeadTableViewCell.h"

@implementation InformationHeadTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
        _iconImgView.layer.cornerRadius = 3;
        _iconImgView.clipsToBounds = YES;
        _iconImgView.image = [UIImage imageNamed:@"person"];
        _iconImgView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_iconImgView];
        
        //account
        UILabel *accountLab = [Tools createLabWithFrame:CGRectMake(100, 0, 200, 50) withTitle:@"一麵账号" withTitleSize:16.0 withTextColor:[UIColor getColor:@"333333"]];
        [self addSubview:accountLab];
        
        _accountLabel = [Tools createLabWithFrame:CGRectMake(170, 0, SCREENWIDTH - 180, 50) withTitle:@"xxx" withTitleSize:16.0 withTextColor:[UIColor getColor:@"333333"]];
        _accountLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_accountLabel];
        
        //line
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(100, 50, SCREENWIDTH - 100, 0.5)];
        lineView.backgroundColor = LINECOLOR;
        [self addSubview:lineView];
        
        //register time

        UILabel *timeLab = [Tools createLabWithFrame:CGRectMake(100, 50, 200, 50) withTitle:@"注册时间" withTitleSize:16 withTextColor:[UIColor getColor:@"333333"]];
        [self addSubview:timeLab];
        
        _registerTimeLabel = [Tools createLabWithFrame:CGRectMake(170, 50, SCREENWIDTH - 180, 50) withTitle:@"xxx" withTitleSize:16 withTextColor:[UIColor getColor:@"333333"]];
        _registerTimeLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_registerTimeLabel];
        
        UIView *lineViewBottom = [[UIView alloc] initWithFrame:CGRectMake(10, 99, SCREENWIDTH - 10, 0.5)];
        lineViewBottom.backgroundColor = LINECOLOR;
        [self addSubview:lineViewBottom];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
