//
//  MyNiceViewController.m
//  FoodBook
//
//  Created by sansali on 15/9/17.
//  Copyright (c) 2015年 sansali. All rights reserved.
//

#import "MyNiceViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "FoodBookDetailViewController.h"
#import "FoodTableViewCell.h"
#import "FoodBookData.h"

@interface MyNiceViewController ()<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>
{
    int page;
}
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSMutableArray *data;
@end

@implementation MyNiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的赞";
    _data = [[NSMutableArray alloc] initWithCapacity:0];
    [self createTableView];
    [self refreshData];
    
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

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshData{
    
    [self requestServiceGetWithURL:[NSString stringWithFormat:@"http://106.185.26.36:8080/yimian/app/enjoy/loadEnjoys.do?page=%d&rows=20&token=%@",page,[UserCenter shareInstance].loginUser.token] withParam:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *respone = responseObject;
        bool success = [respone objectForKey:@"success"];
        if (success) {
            NSArray *rows = [respone objectForKey:@"rows"];
            
            if (page == 1) {
                [_data removeAllObjects];
                
            }
            for (int i = 0; i < rows.count; i++) {
                NSDictionary *rowData = rows[i];
                FoodBookData *dataa = [[FoodBookData alloc] init];
                dataa.name = rowData[@"fname"];
                
                NSNumber *idd = rowData[@"fid"];
                dataa.foodId = [NSString stringWithFormat:@"%d",[idd intValue]];
                dataa.flavor = rowData[@"flavor"];
                
                dataa.address = rowData[@"address"];
                dataa.uid = rowData[@"uid"];
                dataa.img = rowData[@"img"];
                
                [_data addObject:dataa];
            }
            
            //            if (rows.count >= 20) {
            //                isFinished = NO;
            //            }else{
            //                isFinished = YES;
            //            }
        }
        NSLog(@"%@",respone);
        
        //        isReloading = NO;
        //        [egoRefreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:moodTableView];
        [_tableView     reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        isReloading = NO;
        //        [egoRefreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:moodTableView];
        [_tableView reloadData];
    }];
}



#pragma mark table datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    FoodBookDetailViewController *vc = [[FoodBookDetailViewController alloc] init];
    vc.data = _data[indexPath.row];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController: vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellName = @"FoodTableViewCell";
    FoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[FoodTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    [cell refreshViewWithData:_data[indexPath.row]];
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
