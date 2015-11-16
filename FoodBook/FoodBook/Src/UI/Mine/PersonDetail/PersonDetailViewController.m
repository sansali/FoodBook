//
//  PersonDetailViewController.m
//  FoodBook
//
//  Created by sansali on 15/10/13.
//  Copyright © 2015年 sansali. All rights reserved.
//

#import "PersonDetailViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "FoodTableViewCell.h"
#import "FoodBookDetailViewController.h"

@interface PersonDetailViewController ()<UITableViewDelegate,UITableViewDataSource,EGORefreshTableHeaderDelegate>

@property(nonatomic,retain)UITableView *tableView;

@end

@implementation PersonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 170)];
    headView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2.0 - 50, 15, 100, 100)];
    iconImgView.image = [UIImage imageNamed:@"person"];
    [headView addSubview:iconImgView];
    
    NSArray *titles = @[@"发布食谱",@"好友数",@"采纳食谱"];
    NSArray *values = @[@"10450",@"125",@"1245"];

    for (int i = 0; i < 3; i++) {
        UILabel *titleLab = [Tools createLabWithFrame:CGRectMake(i*SCREENWIDTH/3.0, 125, SCREENWIDTH/3.0, 16) withTitle:titles[i] withTitleSize:15.0 withTextColor:[UIColor blackColor]];
        titleLab.textAlignment = NSTextAlignmentCenter;
        [headView addSubview:titleLab];
        
        
        UILabel *valueLab = [Tools createLabWithFrame:CGRectMake(i*SCREENWIDTH/3.0, 146, SCREENWIDTH/3.0, 16) withTitle:values[i] withTitleSize:15.0 withTextColor:[UIColor blackColor]];
        valueLab.textAlignment = NSTextAlignmentCenter;
        [headView addSubview:valueLab];
    
    }
    _tableView.tableHeaderView = headView;
    
    
    EGORefreshTableHeaderView *_egoRefreshView = [[EGORefreshTableHeaderView alloc] initWithFrame:_tableView.frame];
    _egoRefreshView.delegate = self;
    [self.view insertSubview:_egoRefreshView belowSubview:_tableView];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
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
