//
//  FunTableViewCell.m
//  FoodBook
//
//  Created by sansali on 15/10/12.
//  Copyright © 2015年 sansali. All rights reserved.
//

#import "FunTableViewCell.h"

@implementation FunTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor getColor:@"f5f5fd"];
        
        UIImageView *foodImgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 12, 50, 50)];
        foodImgView.image = [UIImage imageNamed:@"314"];
        foodImgView.backgroundColor = [UIColor blackColor];
        [self addSubview:foodImgView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 18, SCREENWIDTH - 26 - 85, 16)];
        titleLabel.text = @"你大爷";
        titleLabel.textColor = [UIColor blackColor];
        [self addSubview:titleLabel];
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 40,SCREENWIDTH - 26 - 85, 16)];
        timeLabel.text = @"100人关注";
        timeLabel.textColor = [UIColor getColor:@"a1a1a1"];
        [self addSubview:timeLabel];
        
        UIButton  *_captchaBtn = [Tools createBtnWithFrame:CGRectMake(SCREENWIDTH - 95, 15, 70, 30) withTitle:@"相互关注" withTitleSize:16];
        _captchaBtn.layer.borderColor = [UIColor grayColor].CGColor;
        _captchaBtn.backgroundColor = [UIColor getColor:@"db013b"];
        _captchaBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
        _captchaBtn.layer.cornerRadius = 1.5;
        //    _registerBtn.layer.borderWidth = 1.0;
//        [_captchaBtn addTarget:self action:@selector(gotoRegister:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_captchaBtn];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
