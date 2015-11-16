//
//  MyNewsFeedViewController.m
//  FoodBook
//
//  Created by sansali on 15/9/17.
//  Copyright (c) 2015年 sansali. All rights reserved.
//

#import "MyNewsFeedViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "MoodTableViewCell.h"
#import "MoodData.h"
#import "PreviewViewController.h"
@interface MyNewsFeedViewController ()<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate,moodCellDelegate>
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSArray *data;


@end

@implementation MyNewsFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的动态";
    [self createTableView];
}

//yimian/app/blog/loadByUser.do?page=1&rows=10&token=144604243715615827546615

-(void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 44)];
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
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark table datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellName = @"MoodTableViewCell";
    MoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[MoodTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    [cell refreshViewWithData:_data[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MoodData *data = _data[indexPath.row];
    int itemWidth = (SCREENWIDTH  - 95)/3;
    
    return 60 + ([data.imgs count]%3==0?([data.imgs count]/3):[data.imgs count]/3+1)*(itemWidth + 5);

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

//点击图片预览
-(void)tapPreviewWithIndex:(int)index withData:(NSMutableArray *)data{
    PreviewViewController *previewCntroller = [[PreviewViewController alloc] initWithImages:data];
    //    previewCntroller.m_delegate = self;
    previewCntroller.isHiddenDelete = YES;
    previewCntroller.currentImageIndex = index;
    previewCntroller.hidesBottomBarWhenPushed  = YES;
    [self.navigationController pushViewController:previewCntroller animated:YES];
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
