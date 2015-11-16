//
//  MineTableViewCell.m
//  TengChuDisclose
//
//  Created by sansali on 8/11/15.
//  Copyright (c) 2015 TengChu. All rights reserved.
//

#import "MineTableViewCell.h"

@implementation MineTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor getColor:@"ffffff"];
        
        _iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(9, 15, 21, 21)];
        _iconImgView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_iconImgView];
        
        _titleLabel = [Tools createLabWithFrame:CGRectMake(38, 0, 200, 51) withTitle:@"" withTitleSize:17.0 withTextColor:[UIColor getColor:@"333333"]];
        [self addSubview:_titleLabel];
        
        _rightLabel = [Tools createLabWithFrame:CGRectMake(SCREENWIDTH - 150, 0, 140, 51) withTitle:@"" withTitleSize:17.0 withTextColor:[UIColor getColor:@"585858"]];
        _rightLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_rightLabel];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = LINECOLOR;
        lineView.frame = CGRectMake(0, 0, SCREENWIDTH, 0.5);
        [self addSubview:lineView];
        
        _valueTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(80, 11, SCREENWIDTH - 100, 29)];
        _valueTextFiled.textColor = [UIColor getColor:@"000000"];
        _valueTextFiled.borderStyle = UITextBorderStyleNone;
        _valueTextFiled.layer.cornerRadius = 3.0;
        _valueTextFiled.clipsToBounds = YES;
        _valueTextFiled.backgroundColor = [UIColor getColor:@"cccccc"];
        _valueTextFiled.font = [UIFont systemFontOfSize:17.0];
        [self addSubview:_valueTextFiled];
        _valueTextFiled.hidden = YES;
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
