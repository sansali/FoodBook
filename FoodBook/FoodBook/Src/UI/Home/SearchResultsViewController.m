//
//  SearchResultsViewController.m
//  FoodBook
//
//  Created by sansali on 15/9/30.
//  Copyright © 2015年 sansali. All rights reserved.
//

#import "SearchResultsViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "FoodBookDetailViewController.h"
#import "FoodTableViewCell.h"

@interface SearchResultsViewController ()<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>

@property(nonatomic,retain)UITableView *tableView;

@end

@implementation SearchResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"搜索结果";
    self.view.backgroundColor = [UIColor getColor:@"f5f5fd"];
    [self createTableView];
}

-(void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, SCREENWIDTH, SCREENHEIGHT - 10 - 44)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    UIView *view = [UIView new];
    [_tableView setTableFooterView:view];
    
    EGORefreshTableHeaderView *_egoRefreshView = [[EGORefreshTableHeaderView alloc] initWithFrame:_tableView.frame];
    _egoRefreshView.delegate = self;
    [self.view insertSubview:_egoRefreshView belowSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark table datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    FoodBookDetailViewController *vc = [[FoodBookDetailViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController: vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellName = @"FoodTableViewCell";
    FoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[FoodTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 165;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
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
