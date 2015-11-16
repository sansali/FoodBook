//
//  SearchResultViewController.m
//  TengChuDisclose
//
//  Created by sansali on 15/9/28.
//  Copyright © 2015年 TengChu. All rights reserved.
//

#import "SearchResultViewController.h"

@interface SearchResultViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    int page;
    UISearchBar *mySearchBar;
    BOOL haveMore;
    BOOL isReloading;
    int count;
}
@property(nonatomic,copy)NSMutableArray *data;
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation SearchResultViewController

-(void)viewWillAppear:(BOOL)animated{
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    page = 1;
    self.title = _keyWord;
    [self createTableView];
    [self getData];
}

-(void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 44)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    mySearchBar = [[UISearchBar alloc] init];
    mySearchBar.placeholder = @"搜索食谱";
    mySearchBar.delegate = self;
    [mySearchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [mySearchBar sizeToFit];
    UIView *imageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 44)];
    imageView.backgroundColor  = [UIColor getColor:@"f0f0f0"];
    [mySearchBar insertSubview:imageView atIndex:1];
    _tableView.tableHeaderView = mySearchBar;
    
}

-(void)getData{
    ;
}

-(NSDictionary *)parseJsonWithString:(NSString *)json{
    
    json = [json substringFromIndex:1];
    json = [json substringToIndex:json.length - 2];
    if (json && ![json isEqualToString:@""]) {
        
        NSDictionary *dic = nil;
        NSError *error;
        dic = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        
        if (dic && ![dic isKindOfClass:[NSNull class]] && [dic count] > 0) {
            return dic;
        }
        return nil;
    }
    else{
        NSLog(@"json is nil");
        return nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma market uitableview datasource & delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_data  && [_data count] > 0) {
        return [_data count] + 1;
    }else{
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headSectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 30)];
    headSectionView.backgroundColor = [UIColor getColor:@"e3e3e3"];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREENWIDTH/2.0, 14)];
    titleLab.font = [UIFont boldSystemFontOfSize:14.0];
    titleLab.textColor = [UIColor getColor:@"141414"];
    titleLab.text = @"一麵";
    [headSectionView addSubview:titleLab];
    
    UILabel *resultsLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2.0, 10, SCREENWIDTH/2.0 - 10, 14)];
    resultsLab.textColor = [UIColor getColor:@"838383"];
    resultsLab.textAlignment = NSTextAlignmentRight;
    resultsLab.font = [UIFont systemFontOfSize:13.0];
    resultsLab.text = [NSString stringWithFormat:@"%d个结果",count];
    [headSectionView addSubview:resultsLab];
    
    return headSectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

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

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
 
}

-(void)loadMore{
    page++;
    [self getData];
}

#pragma mark UISearchBar and UISearchDisplayController Delegate Methods
//searchBar开始编辑时改变取消按钮的文字
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
    NSArray *subViews;
    if (YES) {
        subViews = [(searchBar.subviews[0]) subviews];
    }
    else {
        subViews = searchBar.subviews;
    }
    for (id view in subViews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton* cancelbutton = (UIButton* )view;
            [cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
            break;
        }
    }
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    //準備搜尋前，把上面調整的TableView調整回全屏幕的狀態
    [UIView animateWithDuration:1.0 animations:^{
        _tableView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 44);
    }];
    return YES;
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    //搜尋結束後，恢復原狀
    [UIView animateWithDuration:1.0 animations:^{
        _tableView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-44);
    }];
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    
    if (searchBar.text && searchBar.text.length > 0) {
        [searchBar setShowsCancelButton:NO animated:YES];
        _keyWord = searchBar.text;
        self.title = _keyWord;
        page = 1;
        [self   getData];
        searchBar.text = @"";
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
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
