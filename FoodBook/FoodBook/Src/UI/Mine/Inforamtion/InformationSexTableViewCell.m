//
//  InformationSexTableViewCell.m
//  FoodBook
//
//  Created by sansali on 15/10/12.
//  Copyright © 2015年 sansali. All rights reserved.
//

#import "InformationSexTableViewCell.h"

@implementation InformationSexTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor getColor:@"ffffff"];
        
        UILabel *titleLab = [Tools createLabWithFrame:CGRectMake(10, 0, SCREENWIDTH - 20, 60) withTitle:@"性别         女        男" withTitleSize:14.0 withTextColor:[UIColor getColor:@"585858"]];
        [self addSubview:titleLab];
        
        womanBtn = [Tools createBtnWithFrame:CGRectMake(45, 15, 30, 30) withTitle:@"" withTitleSize:16];
        [womanBtn setImage:[UIImage imageNamed:@"girl"] forState:UIControlStateNormal];
        [womanBtn setImage:[UIImage imageNamed:@"girl_s"] forState:UIControlStateSelected];
        [womanBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [womanBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:womanBtn];
        
        manBtn = [Tools createBtnWithFrame:CGRectMake(87, 17, 30, 30) withTitle:@"" withTitleSize:16];
        [manBtn setImage:[UIImage imageNamed:@"boy"] forState:UIControlStateNormal];
        [manBtn setImage:[UIImage imageNamed:@"boy_s"] forState:UIControlStateSelected];
        [manBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [manBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:manBtn];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 59, SCREENWIDTH - 10, 0.5)];
        lineView.backgroundColor = LINECOLOR;
        [self addSubview:lineView];
    }
    return self;
}

-(void)btnClick:(UIButton *)sender{
    
    if (_isEditing) {
        [sender setSelected:true];
        if (sender == womanBtn) {
            [manBtn setSelected:false];
            _btnCallBack(0);
        }else{
            [womanBtn setSelected:false];
            _btnCallBack(1);
        }
    }
}

-(void)setSex:(int)sex whitEditing:(BOOL)isEditIng{
    if (sex == 0) {
        [womanBtn setSelected:YES];
        [manBtn setSelected:NO];

    }else{
        [womanBtn setSelected:NO];
        [manBtn setSelected:YES];
    }
    _isEditing = isEditIng;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
