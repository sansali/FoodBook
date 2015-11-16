//
//  InformationLogoutTableViewCell.m
//  FoodBook
//
//  Created by sansali on 15/10/12.
//  Copyright © 2015年 sansali. All rights reserved.
//

#import "InformationLogoutTableViewCell.h"

@implementation InformationLogoutTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor getColor:@"ffffff"];
        UIButton *logoutBtn = [Tools createBtnWithFrame:CGRectMake(10, 10, SCREENWIDTH - 20, 40) withTitle:@"退出" withTitleSize:16];
        logoutBtn.backgroundColor = THEMECOLOR;
        logoutBtn.layer.cornerRadius = 3;
        [logoutBtn addTarget:self action:@selector(gotoLogout:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:logoutBtn];
       
    }
    return self;
}

-(void)gotoLogout:(UIButton *)sender{
    
    UIAlertView *loginOutAlertView = [[UIAlertView alloc] initWithTitle:nil message:@"是否确定退出登陆？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    loginOutAlertView.delegate = self;
    [loginOutAlertView show];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma market uialertviewdelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        UserCenter *userCenter = [UserCenter shareInstance] ;
        userCenter.loginUser = nil;
        _loginoutCallBack();
    }
}

@end
