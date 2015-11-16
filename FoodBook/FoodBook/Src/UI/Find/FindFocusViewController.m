//
//  FindFocusViewController.m
//  FoodBook
//
//  Created by sansali on 15/9/24.
//  Copyright © 2015年 sansali. All rights reserved.
//

#import "FindFocusViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "CookTableViewCell.h"
#import "FoodBookData.h"
#import "PreviewViewController.h"
#import "FoodBookDetailViewController.h"

@interface FindFocusViewController ()<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>
{
    UITableView *moodTableView;
    BOOL isReloading;
    bool isFinished;
    EGORefreshTableHeaderView *egoRefreshHeaderView;
    int page;
}

@property(nonatomic,strong)NSMutableArray *data;
@end

@implementation FindFocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.frame = CGRectMake(0, 50, SCREENWIDTH, SCREENHEIGHT);
    [self createAll];
    [self refreshData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData{
    _data = [[NSMutableArray alloc] initWithCapacity:0];
    page = 1;
}

-(void)createAll{
    [self initData];
    [self createTableView];
}

-(void)createTableView{
    
    moodTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 50 - 44 - 49)];
    moodTableView.delegate = self;
    moodTableView.dataSource = self;
    moodTableView.backgroundColor = [UIColor clearColor];
    moodTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:moodTableView];
    
    UIView *view = [UIView new];
    [moodTableView setTableFooterView:view];
    
    egoRefreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:moodTableView.frame];
    egoRefreshHeaderView.delegate = self;
    [self.view insertSubview:egoRefreshHeaderView belowSubview:moodTableView];
}

-(void)initNavBar{
    
}

-(void)refreshData{
    
    [self requestServiceGetWithURL:[NSString stringWithFormat:@"http://106.185.26.36:8080/yimian/app/food/loadFoods.do?page=%d&rows=20",page] withParam:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
                dataa.name = rowData[@"name"];
                dataa.foodId = rowData[@"id"];
                NSNumber *enjoyCount = rowData[@"enjoyCount"];
                dataa.enjoyCount = [enjoyCount intValue];
                
                NSNumber *evaCount = rowData[@"evaCount"];
                dataa.evaCount = [evaCount intValue];
                
                NSNumber *collectionCount = rowData[@"collectionCount"];
                dataa.collectionCount = [collectionCount intValue];
                dataa.address = rowData[@"address"];
                NSNumber *time = rowData[@"createtime"];
                dataa.createtime = [time longLongValue];
                dataa.uimg = rowData[@"uimg"];
                dataa.uid = rowData[@"uid"];
                dataa.type = rowData[@"type"];
                dataa.img = rowData[@"img"];
                
                [_data addObject:dataa];
            }
            
            if (rows.count >= 20) {
                isFinished = NO;
            }else{
                isFinished = YES;
            }
        }
        NSLog(@"%@",respone);
        
        isReloading = NO;
        [egoRefreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:moodTableView];
        [moodTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        isReloading = NO;
        [egoRefreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:moodTableView];
        [moodTableView reloadData];
    }];
}

-(void)loadMoreData{
    page++;
    [self refreshData];
}



#pragma mark table datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count + 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    if (indexPath.row != _data.count) {
        FoodBookDetailViewController *vc = [[FoodBookDetailViewController alloc] init];
        vc.data = _data[indexPath.row];
        vc.hidesBottomBarWhenPushed = YES;
        [self.nav pushViewController:vc animated:YES];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == [_data count]) {
        if (isFinished) {
            static NSString *cellname = @"loadedCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellname];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
                cell.textLabel.font = [UIFont systemFontOfSize:17.0];
                cell.textLabel.textColor = [UIColor getColor:@"999999"];
            }
            cell.textLabel.text = @"已显示全部内容";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            if (!isReloading) {
                [self  loadMoreData];
                isReloading = YES;
            }
            static NSString *cellname = @"lastCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellname];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
                cell.textLabel.font = [UIFont systemFontOfSize:17.0];
                cell.textLabel.textColor = [UIColor getColor:@"999999"];
            }
            cell.textLabel.text = @"正在加载...";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            return cell;
        }
    }else{
        static NSString *cellName = @"MoodTableViewCell";
        CookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (cell == nil) {
            cell = [[CookTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.delegate = self;
        [cell refreshViewWithData:_data[indexPath.row]];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == _data.count) {
        return 44;
    }else{
        return 74;
    }
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
    [self.nav pushViewController:previewCntroller animated:YES];
}

#pragma ego delegate
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    isReloading  = YES;
    [self performSelector:@selector(refreshData) withObject:nil afterDelay:0.2];
    //    [self refreshData];
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    return isReloading;
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    return [NSDate date];
}

#pragma mark UIScrollViewDelegate Methods
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [egoRefreshHeaderView egoRefreshScrollViewWillBeginScroll:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [egoRefreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [egoRefreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

@end
