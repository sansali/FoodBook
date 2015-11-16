//
//  CommentViewController.m
//  FoodBook
//
//  Created by sansali on 11/2/15.
//  Copyright © 2015 sansali. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentTableViewCell.h"

@interface CommentViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"酸菜鱼";
    self.view.backgroundColor = [UIColor getColor:@"eeeeee"];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 285)];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(15, 15, SCREENWIDTH - 30, 210)];
    whiteView.layer.borderColor = [UIColor grayColor].CGColor;
    whiteView.layer.borderWidth = 1.0;
    [headerView addSubview:whiteView];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"综合评分   9.9"];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 4)];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, 4)];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, 6)];
    [string addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16.0] range:NSMakeRange(4, 6)];
    UILabel *editIntroduce = [Tools createLabWithFrame:CGRectMake(0, 20, SCREENWIDTH - 20, 20) withAttributed:string withTitleSize:14.0 withTextColor:[UIColor blackColor]];
    editIntroduce.textAlignment = NSTextAlignmentCenter;
    [whiteView addSubview:editIntroduce];
    
    NSArray *titles = @[@"形",@"色",@"香",@"味",@"养"];
    for (int i = 0; i < 5; i ++) {
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2.0 - 90 , 50+ i*30, 20, 30)];
        titleLab.textColor = [UIColor redColor];
        titleLab.text = titles[i];
        titleLab.font = [UIFont systemFontOfSize:14.0];
        [whiteView addSubview:titleLab];
        
        for (int j=0; j < 5; j++) {
            UIImageView *dafa = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2.0 - 60 + j*30, 50 + i*30, 20, 20)];
            dafa.image = [UIImage imageNamed:@"a10_07"];
            [whiteView addSubview:dafa];
        }

        
    }
    
    
    
    
    
    
    
    UIButton *addCommentBtn = [Tools createBtnWithFrame:CGRectMake(SCREENWIDTH - 50, 235, 40, 40) withTitle:@"+" withTitleSize:16];
    addCommentBtn.backgroundColor = THEMECOLOR;
    addCommentBtn.layer.cornerRadius = 3;
    addCommentBtn.tag = 0x986;
    [addCommentBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:addCommentBtn];
    
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 44) style:UITableViewStylePlain];
    _tableView.tableHeaderView = headerView;
    _tableView.delegate = self;
    _tableView.dataSource  =self;
    [self.view addSubview:_tableView];
    
    
    
    
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
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellName = @"FoodTableViewCell";
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
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
