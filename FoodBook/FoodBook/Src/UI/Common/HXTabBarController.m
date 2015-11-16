//
//  HXTabBarController.m
//  FoodBook
//
//  Created by sansali on 15/9/15.
//  Copyright (c) 2015年 sansali. All rights reserved.
//

#import "HXTabBarController.h"
#import "MineViewController.h"
#import "HomeViewController.h"
#import "FindViewController.h"

@interface HXTabBarController ()

@end

@implementation HXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    FindViewController *findVC = [[FindViewController alloc] init];
    HXNavigationController *homeNavc = [[HXNavigationController alloc] initWithRootViewController:homeVC];
    HXNavigationController *findNavc = [[HXNavigationController alloc] initWithRootViewController:findVC];
    HXNavigationController *mineNavc = [[HXNavigationController alloc] initWithRootViewController:[[MineViewController alloc] init]];
    
    UIImage *image0_unselected = [UIImage imageNamed:@"tabbarFood"];
    image0_unselected = [image0_unselected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image0_selected = [UIImage imageNamed:@"tabbarFoodSelected"];
    image0_selected = [image0_selected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *tabbarItem0 = [[UITabBarItem alloc] initWithTitle: NSLocalizedString(@"食谱", nil) image:image0_unselected selectedImage:image0_selected];
    homeVC.tabBarItem = tabbarItem0;
    
    UIImage *image1_unselected = [UIImage imageNamed:@"tabbarFind"];
    image1_unselected = [image1_unselected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image1_selected = [UIImage imageNamed:@"tabbarFindSelected"];
    image1_selected = [image1_selected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *tabbarItem1 = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"发现", nil) image:image1_unselected selectedImage:image1_selected];
    findNavc.tabBarItem = tabbarItem1;
    
    UIImage *image2_unselected = [UIImage imageNamed:@"tabbarMe"];
    image2_unselected = [image2_unselected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image2_selected = [UIImage imageNamed:@"tabbarMeSelected"];
    image2_selected = [image2_selected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *tabbarItem2 = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"我的", nil) image:image2_unselected selectedImage:image2_selected];
    mineNavc.tabBarItem = tabbarItem2;
    
    NSArray *viewControllers = [NSArray arrayWithObjects:homeNavc,findNavc,mineNavc,nil];
    self.viewControllers = viewControllers;
    
    self.tabBar.tintColor = [UIColor whiteColor];
    //字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor getColor:@"7e7e7e"],NSFontAttributeName : [UIFont systemFontOfSize:13.0] } forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : THEMECOLOR,NSFontAttributeName : [UIFont systemFontOfSize:13.0] } forState:UIControlStateSelected];

    self.tabBar.barTintColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
