//
//  MineViewController.m
//  FoodBook
//
//  Created by sansali on 15/9/15.
//  Copyright (c) 2015年 sansali. All rights reserved.
//

#import "MineViewController.h"
#import "MineTableViewCell.h"
#import "MineIconTableViewCell.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "SettingViewController.h"
#import "InformationViewController.h"
#import "MyBlockViewController.h"
#import "MyFavoriteViewController.h"
#import "MyFunsViewController.h"
#import "MyNewsFeedViewController.h"
#import "MyNiceViewController.h"
#import "MyShoppingViewController.h"
#import "SafeSettingViewController.h"
#import "MyFocusViewController.h"
#import "MyFoodBookViewController.h"
#import "UIImageView+WebCache.h"

@interface MineViewController()<UITableViewDataSource,UITableViewDelegate>{
    

}

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation MineViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}

-(void)viewDidLoad{
    [self.navigationController.tabBarItem setTitle:@"我"];
    [self initNavBar];
    [self createTableView];
}

-(void)initNavBar{
    UIView *titleView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleLab.textColor = [UIColor whiteColor];
    titleLab.text = @"一麵";
    [titleView addSubview:titleLab];
   
    self.navigationItem.titleView = titleView;
}

-(void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT + 20) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.scrollsToTop = YES;
    _tableView.backgroundColor = [UIColor getColor:@"eaeaea"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    UIView *view = [UIView new];
    [_tableView setTableFooterView:view];
    
    [self.view addSubview:_tableView];
}

#pragma mark table datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 4;
            break;
            
        default:
            return 1;
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    switch (indexPath.section) {
        case 0:
        {
        }
            break;
        case 1:
        {
            if (indexPath.row == 0) {
                
                if ([UserCenter shareInstance].loginUser.phone) {
                    InformationViewController *vc = [[InformationViewController alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];

                }else{
                    [AppDelegate showLoginVCWithLoginSuccessCallBack:^(BOOL success) {
                        if (success) {
                            InformationViewController *vc = [[InformationViewController alloc] init];
                            vc.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:vc animated:YES];
                        }
                    }];
                }
                
                
            }else if(indexPath.row == 1) {
                MyShoppingViewController *vc = [[MyShoppingViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                //我的动态
                
                if ([UserCenter shareInstance].loginUser.phone) {
                    MyNewsFeedViewController *vc = [[MyNewsFeedViewController alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }else{
                    [AppDelegate showLoginVCWithLoginSuccessCallBack:^(BOOL success) {
                        if (success) {
                            MyNewsFeedViewController *vc = [[MyNewsFeedViewController alloc] init];
                            vc.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:vc animated:YES];
                        }
                    }];
                }
            }
        }
            break;
        case 2:
        {
            if (indexPath.row == 0) {
                //我的收藏
                if ([UserCenter shareInstance].loginUser.phone) {
                    MyFavoriteViewController *vc = [[MyFavoriteViewController alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }else{
                    [AppDelegate showLoginVCWithLoginSuccessCallBack:^(BOOL success) {
                        if (success) {
                            MyFavoriteViewController *vc = [[MyFavoriteViewController alloc] init];
                            vc.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:vc animated:YES];
                        }
                    }];
                }
                
                
            }else if(indexPath.row == 1) {
                //我的赞
                if ([UserCenter shareInstance].loginUser.phone) {
                    MyNiceViewController *vc = [[MyNiceViewController alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }else{
                    [AppDelegate showLoginVCWithLoginSuccessCallBack:^(BOOL success) {
                        if (success) {
                            MyNiceViewController *vc = [[MyNiceViewController alloc] init];
                            vc.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:vc animated:YES];
                        }
                    }];
                }
            }else if(indexPath.row == 2) {
                //我的黑
                if ([UserCenter shareInstance].loginUser.phone) {
                    MyBlockViewController *vc = [[MyBlockViewController alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }else{
                    [AppDelegate showLoginVCWithLoginSuccessCallBack:^(BOOL success) {
                        if (success) {
                            MyBlockViewController *vc = [[MyBlockViewController alloc] init];
                            vc.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:vc animated:YES];
                        }
                    }];
                }
            }else{
                //我的粉丝
                if ([UserCenter shareInstance].loginUser.phone) {
                    MyFunsViewController *vc = [[MyFunsViewController alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }else{
                    [AppDelegate showLoginVCWithLoginSuccessCallBack:^(BOOL success) {
                        if (success) {
                            MyFunsViewController *vc = [[MyFunsViewController alloc] init];
                            vc.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:vc animated:YES];
                        }
                    }];
                }
            }
        }
            break;
            
        default:
            break;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            //user login & register
            static NSString *cellName = @"MineIconTableViewCell";
            MineIconTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
            if (cell == nil) {
                cell = [[MineIconTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            }
            UserCenter *userCenter = [UserCenter shareInstance] ;
            
            if (userCenter.loginUser && userCenter.loginUser.name) {
//                cell.iconImgView.image = [UIImage imageNamed:@"person"];
                [cell.iconImgView setImageWithURL:[NSURL URLWithString:userCenter.loginUser.img] placeholderImage:[UIImage imageNamed:@"person"]];
                cell.loginBtn.hidden = YES;
                cell.registerBtn.hidden = YES;
                cell.nickName.hidden = NO;
                cell.nickName.text = userCenter.loginUser.name;
            }else{
                cell.iconImgView.image = [UIImage imageNamed:@"person"];
                cell.loginBtn.hidden = NO;
                cell.registerBtn.hidden = NO;
                cell.nickName.hidden = YES;
                [cell.loginBtn addTarget:self action:@selector(gotoLogin:) forControlEvents:UIControlEventTouchUpInside];
                [cell.registerBtn addTarget:self action:@selector(gotoRegister:) forControlEvents:UIControlEventTouchUpInside];
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
            break;
        case 1:
        case 2:
        {
            static NSString *cellName = @"MineTableViewCell";
            NSArray *rowTitle = @[@[@"我的信息",@"我的商城",@"我的动态"],@[@"我的收藏",@"我的赞",@"我的黑",@"我的粉"],@[@"其它"]];
            MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
            if (cell == nil) {
                cell = [[MineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            }
            cell.titleLabel.text = rowTitle[indexPath.section - 1][indexPath.row];
            cell.iconImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"me%ld%ld",(long)indexPath.section,(long)indexPath.row]];
                
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
            break;
        default:
            return nil;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return 120;
    }
    return 51;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

-(void)gotoLogin:(UIButton *)sender{
    LoginViewController *vc = [[LoginViewController alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    [vc setLoginCallBack:^(BOOL sucess) {
        [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];

    }];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)gotoRegister:(UIButton *)sender{
    RegisterViewController *vc = [[RegisterViewController alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)gotoSetting{
    SettingViewController *vc = [[SettingViewController alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
