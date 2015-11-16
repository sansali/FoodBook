//
//  SearchViewController.m
//  FoodBook
//
//  Created by sansali on 15/9/16.
//  Copyright (c) 2015年 sansali. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchResultsViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"搜索条件";
    self.view.backgroundColor = [UIColor getColor:@"f5f5fd"];
    [self createChooseView];
    [self createComfirmBtn];
}

-(void)createChooseView{
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(15, 15, SCREENWIDTH - 30, 277)];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.layer.borderColor = [UIColor getColor:@"d6d5da"].CGColor;
    whiteView.layer.borderWidth = 1;
    whiteView.layer.cornerRadius = 1;
    [self.view addSubview:whiteView];
    
    NSArray *titles = @[@"名称：",@"食材：",@"口味：",@"烹制：",@"地域："];
    for (int i = 0; i <5; i++) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 37 + 40*i, 100, 16)];
        titleLabel.text = titles[i];
        titleLabel.textColor = [UIColor blackColor];
        [whiteView addSubview:titleLabel];
        
        UITextField *valueTextField = [[UITextField alloc]initWithFrame:CGRectMake(85, 30+40*i, SCREENWIDTH - 85 - 63 - 15, 30)];
        valueTextField.layer.borderColor = THEMECOLOR.CGColor;
        valueTextField.layer.borderWidth = 1;
        [whiteView addSubview:valueTextField];

    }
}

-(void)createComfirmBtn{
    UIButton *comfirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    comfirmBtn.frame = CGRectMake(15, 56 + 277, SCREENWIDTH - 30, 40);
    comfirmBtn.backgroundColor = THEMECOLOR;
    comfirmBtn.layer.borderColor = THEMECOLOR.CGColor;
    comfirmBtn.layer.borderWidth = 1;
    comfirmBtn.layer.cornerRadius = 5;
    [comfirmBtn setTitle:@"提交" forState:UIControlStateNormal];
    [comfirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [comfirmBtn addTarget:self action:@selector(comfirmBtnclick:) forControlEvents:UIControlEventTouchUpInside];
    [comfirmBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
    [self.view addSubview:comfirmBtn];
}

-(void)comfirmBtnclick:(UIButton *)sender{
    SearchResultsViewController *vc = [[SearchResultsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
