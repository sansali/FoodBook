//
//  InformationTableViewCell.m
//  FoodBook
//
//  Created by sansali on 15/10/12.
//  Copyright © 2015年 sansali. All rights reserved.
//

#import "InformationTableViewCell.h"

@implementation InformationTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor getColor:@"ffffff"];
        
        _titleLabel = [Tools createLabWithFrame:CGRectMake(10, 0, 100, 60) withTitle:@"" withTitleSize:16.0 withTextColor:[UIColor getColor:@"585858"]];
        [self addSubview:_titleLabel];
        
        _valueTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(55, 15, SCREENWIDTH - 65, 30)];
        _valueTextFiled.borderStyle = UITextBorderStyleNone;
        _valueTextFiled.delegate  = self;
//        _valueTextFiled.layer.cornerRadius = 3.0;
//        _valueTextFiled.clipsToBounds = YES;
//        _valueTextFiled.backgroundColor = [UIColor getColor:@"cccccc"];
        _valueTextFiled.font = [UIFont systemFontOfSize:16.0];
        [_valueTextFiled setEnabled:NO];
        [self addSubview:_valueTextFiled];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 59, SCREENWIDTH - 10, 0.5)];
        lineView.backgroundColor = LINECOLOR;
        [self addSubview:lineView];
    }
    return self;
}

-(void)editIng:(BOOL)isEditing{
    if (isEditing) {
        _valueTextFiled.borderStyle = UITextBorderStyleLine;
        _valueTextFiled.enabled = YES;

    }else{
        _valueTextFiled.borderStyle = UITextBorderStyleNone;
        _valueTextFiled.enabled = NO;

    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
