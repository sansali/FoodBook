//
//  HomeViewController.m
//  FoodBook
//
//  Created by sansali on 15/9/15.
//  Copyright (c) 2015年 sansali. All rights reserved.
//

#import "HomeViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "FoodBookDetailViewController.h"
#import "SearchViewController.h"
#import "HXSegmentedControl.h"
#import "UIImageView+WebCache.h"
#import "TMQuiltView.h"
#import "EGORefreshTableFooterView.h"
#import "TMPhotoQuiltViewCell.h"
#import "SearchResultViewController.h"
#import "FoodBookData.h"
#import "UIImageView+WebCache.h"

@interface HomeViewController ()<TMQuiltViewDataSource,TMQuiltViewDelegate,EGORefreshTableHeaderDelegate,EGORefreshTableDelegate,UISearchBarDelegate>
{
    HXSegmentedControl *_segmentedControl;
    TMQuiltView *qtmquitView;
    //EGOHeader
    EGORefreshTableHeaderView *_refreshHeaderView;
    //EGOFoot
    EGORefreshTableFooterView *_refreshFooterView;
    //
    BOOL _reloading;
    int page;
    bool isFinished;
}
//@property (nonatomic, retain) NSMutableArray *images;
@property (nonatomic, retain) NSMutableArray *data;

@end

@implementation HomeViewController
//@synthesize images = _images;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"食谱";
    [self initNavBarView];
    [self createNavRightBtn];
    [self initData];
    qtmquitView = [[TMQuiltView alloc] initWithFrame:CGRectMake(0, 44, SCREENWIDTH  , SCREENHEIGHT - 88 - 49)];
    qtmquitView.delegate = self;
    qtmquitView.dataSource = self;
    
    [self.view addSubview:qtmquitView];
    
    [qtmquitView reloadData];
    [self createHeaderView];
    [self performSelector:@selector(testFinishedLoadData) withObject:nil afterDelay:0.0f];
    [self requestData];
    
}

-(void)initData{
    _data = [[NSMutableArray alloc] initWithCapacity:0];
    page = 1;
}

-(void)initNavBar{
    
}

-(void)requestData{
    
    [self requestServiceGetWithURL:[NSString stringWithFormat:@"http://106.185.26.36:8080/yimian/app/food/loadfoods.do?page=%d&rows=20&type=1",page] withParam:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *respone = responseObject;
        bool success = [respone objectForKey:@"success"];
        if (success) {
            NSArray *rows = [respone objectForKey:@"rows"];
            
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
            
            if (rows.count == 20) {
                isFinished = NO;
            }else{
                isFinished = YES;
            }
        }
        NSLog(@"%@",respone);
        [qtmquitView reloadData];

        if (page == 1) {

        }else{
            [self removeFooterView];
        }
        [self testFinishedLoadData];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
}

-(void)createNavRightBtn{
    
    UIView *titleView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
    titleLab.textColor = [UIColor whiteColor];
    titleLab.text = @"一麵";
    [titleView addSubview:titleLab];
    
    
    
    UISearchBar *_searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(45, 0, SCREENWIDTH - 60, 44)];
    _searchBar.placeholder = @"搜索食谱";
    _searchBar.delegate = self;
    
//    UIView *imageView = [[UIView alloc] initWithFrame:CGRectMake(60, 0, SCREENWIDTH - 60, 44)];
//    imageView.backgroundColor  = [UIColor getColor:@"f0f0f0"];
//    [_searchBar insertSubview:imageView atIndex:1];
//    [_searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
//    [_searchBar sizeToFit];
//
    [titleView addSubview:_searchBar];
    
    if (VERSION >= 7.1) {
        [[[[_searchBar.subviews objectAtIndex:0] subviews] objectAtIndex:0] removeFromSuperview ];
    }
    self.navigationItem.titleView = titleView;
}

-(void)searchBtnclick:(UIButton *)sender{
    SearchViewController *vc = [[SearchViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)initNavBarView {
    
    _segmentedControl   = [[HXSegmentedControl alloc] initWithItems:@[@" 经典 ",@" 百搭 ",@" 暗黑 "]];
//    _segmentedControl.tintColor = [UIColor whiteColor];
    [_segmentedControl setSegmentChangedCallBack:^(NSInteger index) {
        
    }];
    [self.view addSubview:_segmentedControl];
}
//＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
//初始化刷新视图
//＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#pragma mark
#pragma methods for creating and removing the header view

-(void)createHeaderView{
    if (_refreshHeaderView && [_refreshHeaderView superview]) {
        [_refreshHeaderView removeFromSuperview];
    }
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -60, SCREENWIDTH, 60)];
    _refreshHeaderView.delegate = self;
    
    [qtmquitView addSubview:_refreshHeaderView];
//    [qtmquitView insertSubview:_refreshHeaderView belowSubview:_moodTableView];
    
    [_refreshHeaderView refreshLastUpdatedDate];
}

-(void)testFinishedLoadData{
    
    [self finishReloadingData];
    [self setFooterView];
}

#pragma mark -
#pragma mark method that should be called when the refreshing is finished
- (void)finishReloadingData{
    
    //  model should call this when its done loading
    _reloading = NO;
    
    if (_refreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:qtmquitView];
    }
    
    if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:qtmquitView];
        [self setFooterView];
    }
    
    // overide, the actula reloading tableView operation and reseting position operation is done in the subclass
}

-(void)setFooterView{
    //    UIEdgeInsets test = self.aoView.contentInset;
    // if the footerView is nil, then create it, reset the position of the footer
    CGFloat height = MAX(qtmquitView.contentSize.height, qtmquitView.frame.size.height);
    if (_refreshFooterView && [_refreshFooterView superview])
    {
        // reset position
        _refreshFooterView.frame = CGRectMake(0.0f,
                                              height,
                                              qtmquitView.frame.size.width,
                                              self.view.bounds.size.height);
    }else
    {
        // create the footerView
        _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:
                              CGRectMake(0.0f, height,
                                         qtmquitView.frame.size.width, self.view.bounds.size.height)];
        _refreshFooterView.delegate = self;
        [qtmquitView addSubview:_refreshFooterView];
    }
    
    if (_refreshFooterView)
    {
        [_refreshFooterView refreshLastUpdatedDate];
    }
}


-(void)removeFooterView
{
    if (_refreshFooterView && [_refreshFooterView superview])
    {
        [_refreshFooterView removeFromSuperview];
    }
    _refreshFooterView = nil;
}

//===============
//刷新delegate
#pragma mark -
#pragma mark data reloading methods that must be overide by the subclass

//刷新调用的方法
-(void)refreshView
{
    NSLog(@"刷新完成");
    [self testFinishedLoadData];
    
}
//加载调用的方法
-(void)getNextPageView
{
//    for(int i = 0; i < 10; i++) {
//        [_images addObject:[NSString stringWithFormat:@"%d.jpeg", i % 10 + 1]];
//    }

    [self requestData];
    
    [qtmquitView reloadData];
    [self removeFooterView];
    [self testFinishedLoadData];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_refreshHeaderView)
    {
        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }
    
    if (_refreshFooterView)
    {
        [_refreshFooterView egoRefreshScrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (_refreshHeaderView)
    {
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
    
    if (_refreshFooterView)
    {
        [_refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}


#pragma mark -
#pragma mark EGORefreshTableDelegate Methods
//header
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    return _reloading; // should return if data source model is reloading
}
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    return [NSDate date]; // should return date data source was last changed

}
//start refresh
-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view{
    [self beginToReloadData:EGORefreshHeader];
}



//footer
- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos{
    [self beginToReloadData:EGORefreshFooter];

}

- (NSDate*)egoRefreshTableDataSourceLastUpdated:(UIView*)view{
    return [NSDate date]; // should return date data source was last changed

}

- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView*)view{
    
    return _reloading; // should return if data source model is reloading
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)imageAtIndexPath:(NSIndexPath *)indexPath {
    
    FoodBookData *data  = _data[indexPath.row];
    return [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:data.img]]];//[UIImage imageNamed:[self.data objectAtIndex:indexPath.row]];
}

- (NSInteger)quiltViewNumberOfCells:(TMQuiltView *)TMQuiltView {
    return [self.data count];
}

- (TMQuiltViewCell *)quiltView:(TMQuiltView *)quiltView cellAtIndexPath:(NSIndexPath *)indexPath {
    TMPhotoQuiltViewCell *cell = (TMPhotoQuiltViewCell *)[quiltView dequeueReusableCellWithReuseIdentifier:@"PhotoCell"];
    if (!cell) {
        cell = [[TMPhotoQuiltViewCell alloc] initWithReuseIdentifier:@"PhotoCell"];
    }
    
    FoodBookData *data  = _data[indexPath.row];
    [cell.photoView setImageWithURL:[NSURL URLWithString:data.img] placeholderImage:[UIImage imageNamed:@"person"]];//[self imageAtIndexPath:indexPath];
    cell.titleLabel.text = data.name;
    cell.likeLabel.text = [NSString stringWithFormat:@"%d",data.enjoyCount];
    cell.commentLabel.text = [NSString stringWithFormat:@"%d",data.evaCount];
    cell.favoriteLabel.text = [NSString stringWithFormat:@"%d",data.collectionCount];

    return cell;
}

#pragma mark - TMQuiltViewDelegate
- (NSInteger)quiltViewNumberOfColumns:(TMQuiltView *)quiltView {
    return 2;
}

- (CGFloat)quiltView:(TMQuiltView *)quiltView heightForCellAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%10 == 0) {
        return (SCREENWIDTH - 15)*0.75 - 30;
    }
    return (SCREENWIDTH - 15)*0.75;//[self imageAtIndexPath:indexPath].size.height / [self quiltViewNumberOfColumns:quiltView] + 40;
}

- (void)quiltView:(TMQuiltView *)quiltView didSelectCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"index:%d",indexPath.row);
    
    FoodBookDetailViewController *vc = [[FoodBookDetailViewController alloc] init];
    vc.data = _data[indexPath.row];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}





-(void)beginToReloadData:(EGORefreshPos)aRefreshPos{
    
    //  should be calling your tableviews data source model to reload
    _reloading = YES;
    
    if (aRefreshPos == EGORefreshHeader)
    {
        // pull down to refresh data
        [self performSelector:@selector(refreshView) withObject:nil afterDelay:2.0];
    }else if(aRefreshPos == EGORefreshFooter)
    {
        // pull up to load more data
        [self performSelector:@selector(getNextPageView) withObject:nil afterDelay:2.0];
    }
    
    // overide, the actual loading data operation is done in the subclass
}



#pragma mark UISearchBar and UISearchDisplayController Delegate Methods
//searchBar开始编辑时改变取消按钮的文字
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
//    [self showMaskView:YES];
    [searchBar setShowsCancelButton:YES animated:YES];
    
    NSArray *subViews;
//    if (IOS7_AND_LATER) {
        subViews = [(searchBar.subviews[0]) subviews];
//    }
//    else {
//        subViews = searchBar.subviews;
//    }
    for (id view in subViews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton* cancelbutton = (UIButton* )view;
            [cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
            break;
        }
    }
}



-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    //搜尋結束後，恢復原狀

    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    
    if (searchBar.text && searchBar.text.length > 0) {
        [searchBar setShowsCancelButton:NO animated:YES];
        
//        if (_delegate && [_delegate respondsToSelector:@selector(gotoSearchResultVC:)]) {
//            [_delegate gotoSearchResultVC:searchBar.text];
////            [_delegate showMaskView:NO];
//        }
        [self gotoSearchResultVC:searchBar.text];
        searchBar.text = @"";
        
    }
}

-(void)gotoSearchResultVC:(NSString *)keyWord{
    SearchResultViewController *vc = [[SearchResultViewController alloc ] init];
    vc.keyWord = keyWord;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
//    [_delegate showMaskView:NO];
    
}


@end
