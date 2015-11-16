//
//  BaseViewController.m
//  FoodBook
//
//  Created by sansali on 15/9/15.
//  Copyright (c) 2015年 sansali. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (VERSION>= 7.0)
    {
        #if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        #endif
    }
    
    [self initNavBar];
}

-(void)initNavBar
{
//    UIButton *goBackBtn = [[UIButton alloc] init];
//    goBackBtn.frame = CGRectMake(0.0, 0, 45 , 44);
//    [goBackBtn setImageEdgeInsets:UIEdgeInsetsMake(11, 5, 11, 25)];
//    [goBackBtn setBackgroundColor:[UIColor clearColor]];
//    [goBackBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//    [goBackBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted];
//    [goBackBtn addTarget:self action:@selector(goBackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackBtnClick)];
    leftItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void)goBackBtnClick{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)viewWillAppear:(BOOL)animated{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
