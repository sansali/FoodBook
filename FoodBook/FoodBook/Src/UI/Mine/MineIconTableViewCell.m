//
//  MineIconTableViewCell.m
//  TengChuDisclose
//
//  Created by sansali on 8/11/15.
//  Copyright (c) 2015 TengChu. All rights reserved.
//

#import "MineIconTableViewCell.h"

@implementation MineIconTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 80, 80)];
        _iconImgView.layer.cornerRadius = 3;
        _iconImgView.layer.borderColor = [UIColor clearColor].CGColor;
        _iconImgView.clipsToBounds = YES;
        _iconImgView.image = [UIImage imageNamed:@"person"];
        _iconImgView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_iconImgView];
        
        _nickName = [Tools createLabWithFrame:CGRectMake(100, 45, 200, 30) withTitle:@"" withTitleSize:20.0 withTextColor:[UIColor getColor:@"333333"]];
        _nickName.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_nickName];
        _nickName.hidden = YES;
        
        _loginBtn = [Tools createBtnWithFrame:CGRectMake(100, 45, 80, 30) withTitle:@"点击登录" withTitleSize:20];
        [_loginBtn setTitleColor:[UIColor getColor:@"333333"] forState:UIControlStateNormal];
//        _loginBtn.layer.borderColor = [UIColor whiteColor].CGColor;
//        _loginBtn.layer.borderWidth = 1.0;

        _registerBtn = [Tools createBtnWithFrame:CGRectMake(SCREENWIDTH - 80, 45, 60, 30) withTitle:@"注册" withTitleSize:18];
        [_registerBtn setTitleColor:[UIColor getColor:@"555555"] forState:UIControlStateNormal];
        [self addSubview:_loginBtn];
        [self addSubview:_registerBtn];

        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
