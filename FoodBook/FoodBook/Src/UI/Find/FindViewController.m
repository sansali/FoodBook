//
//  FindViewController.m
//  FoodBook
//
//  Created by sansali on 15/9/15.
//  Copyright (c) 2015年 sansali. All rights reserved.
//

#import "FindViewController.h"
#import "HXSegmentedControl.h"
#import "EditContentViewController.h"
#import "EditCoverViewController.h"

#import "FindFocusViewController.h"
#import "FindNewsFeedViewController.h"

#import "AppDelegate.h"

@interface FindViewController (){
    HXSegmentedControl *_segmentedControl;
    BOOL isMoodShow;

}

@property(nonatomic,retain)FindFocusViewController *foodVC;
@property(nonatomic,retain)FindNewsFeedViewController *moodVC;


@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"一麵";
    [self.navigationController.tabBarItem setTitle:@"发现"];
    self.view.backgroundColor = [UIColor getColor:@"f5f5fd"];
    
    [self createNavRightBtn];
    [self initSegmentView];
    
    _foodVC = [[FindFocusViewController alloc] init];
    _foodVC.nav = self.navigationController;
    _foodVC.view.hidden = YES;
    [self.view addSubview:_foodVC.view];
    
    _moodVC = [[FindNewsFeedViewController alloc] init];
    _moodVC.nav = self.navigationController;
    [self.view addSubview:_moodVC.view];
    
}

-(void)createNavRightBtn{
    
    UIView *titleView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleLab.textColor = [UIColor whiteColor];
    titleLab.text = @"一麵";
    [titleView addSubview:titleLab];
    
    UIButton *editContentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editContentBtn.frame = CGRectMake(SCREENWIDTH - 85,12.0, 23, 20.5);
    [editContentBtn setBackgroundColor:[UIColor clearColor]];
    [editContentBtn setBackgroundImage:[UIImage imageNamed:@"a-7_03"] forState:UIControlStateNormal];
    [editContentBtn setBackgroundImage:[UIImage imageNamed:@"a-7_03"] forState:UIControlStateHighlighted];

    [editContentBtn addTarget:self action:@selector(editFoodContent:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview: editContentBtn];
    
    UIButton *editCoverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editCoverBtn.frame = CGRectMake(SCREENWIDTH - 45, 12.0, 21.5, 20.5);
    [editCoverBtn setBackgroundColor:[UIColor clearColor]];
    [editCoverBtn setBackgroundImage:[UIImage imageNamed:@"a-7_05"] forState:UIControlStateNormal];
    [editCoverBtn setBackgroundImage:[UIImage imageNamed:@"a-7_05"] forState:UIControlStateHighlighted];

    [editCoverBtn addTarget:self action:@selector(editFoodCover:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview: editCoverBtn];
    
    self.navigationItem.titleView = titleView;
}

//发布心情
-(void)editFoodContent:(UIButton *)sender{
    if ([UserCenter shareInstance].loginUser.phone) {
        EditContentViewController *vc = [[EditContentViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        [AppDelegate showLoginVCWithLoginSuccessCallBack:^(BOOL success) {
            if (success) {
                EditContentViewController *vc = [[EditContentViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }];
    }
}

//发布食谱
-(void)editFoodCover:(UIButton *)sender{
    if ([UserCenter shareInstance].loginUser.phone) {
        EditCoverViewController *vc = [[EditCoverViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        [AppDelegate showLoginVCWithLoginSuccessCallBack:^(BOOL success) {
            if (success) {
                EditCoverViewController *vc = [[EditCoverViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }];
    }
}

- (void)initSegmentView {
    
    _segmentedControl   = [[HXSegmentedControl alloc] initWithItems:@[@"心情",@"食谱"]];
    [_segmentedControl setSegmentChangedCallBack:^(NSInteger segmentSelectedIndex) {
        if (segmentSelectedIndex == 0) {
            self.foodVC.view.hidden = YES;
            self.moodVC.view.hidden = NO;
        }else{
            self.foodVC.view.hidden = NO;
            self.moodVC.view.hidden = YES;
        }
    }];
    [self.view addSubview:_segmentedControl];
}

-(void)initNavBar{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark table datasource

//        static NSString *cellName = @"CookTableViewCell";
//        CookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
//        if (cell == nil) {
//            cell = [[CookTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;

@end
