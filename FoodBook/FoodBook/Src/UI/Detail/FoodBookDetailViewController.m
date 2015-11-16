//
//  FoodBookDetailViewController.m
//  FoodBook
//
//  Created by sansali on 15/9/16.
//  Copyright (c) 2015年 sansali. All rights reserved.
//

#import "FoodBookDetailViewController.h"
#import "MyShoppingViewController.h"
#import "CommentViewController.h"
#import "FoodBookData.h"
#import "FoodDetailData.h"
#import "UIImageView+WebCache.h"

@interface FoodBookDetailViewController ()
{
    UIScrollView *bgScrollView;
    FoodDetailData *detailData;
    int startY;
}

@property(nonatomic,strong)UIButton *likeBtn;
@property(nonatomic,strong)UIButton *commentBtn;
@property(nonatomic,strong)UIButton *favoriteBtn;
@property(nonatomic,strong)UIButton *blockBtn;

@property(nonatomic,strong)UILabel *likeLabel;
@property(nonatomic,strong)UILabel *commentLabel;
@property(nonatomic,strong)UILabel *favoriteLabel;
@property(nonatomic,strong)UILabel *blockLabel;

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *contentLabel;


@property(nonatomic,strong)UIButton *coverNextBtn;
@property(nonatomic,strong)UIButton *firstNextBtn;
@property(nonatomic,strong)UIButton *secondNextBtn;


@end

@implementation FoodBookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = _data.name;
    
    bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 44)];
    [self.view addSubview:bgScrollView];
    [self requestData];
}

-(void)requestData{
    [self requestServiceGetWithURL:[NSString stringWithFormat:@"http://106.185.26.36:8080/yimian/app/food/findFoodById.do?id=%@",_data.foodId] withParam:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *respone = responseObject;
        bool success = [respone objectForKey:@"success"];
        if (success) {
            NSDictionary *rowData = [respone objectForKey:@"foodDetail"];
            FoodDetailData *dataa = [[FoodDetailData alloc] init];
            
            dataa.foodId = rowData[@"id"];
            dataa.content = rowData[@"content"];
            dataa.handleImg = rowData[@"handleImg"];
            dataa.stewFoodImgs = rowData[@"stewFoodImgs"];
            
            if (rowData[@"stewFoodText"] && [rowData[@"stewFoodText"] isKindOfClass:[NSString class]]) {
                dataa.stewFoodText = rowData[@"stewFoodText"];

            }else{
                dataa.stewFoodText = @"";
            }
            
            if (rowData[@"handleText"] && [rowData[@"handleText"] isKindOfClass:[NSString class]]) {
                dataa.handleText = rowData[@"handleText"];
                
            }else{
                dataa.handleText = @"";
            }
            
            NSNumber *dislikeCount = rowData[@"dislikeCount"];
            dataa.dislikeCount = [dislikeCount intValue];
            
            NSNumber *enjoyCount = rowData[@"enjoyCount"];
            dataa.enjoyCount = [enjoyCount intValue];
            
            NSNumber *evaCount = rowData[@"evaCount"];
            dataa.evaCount = [evaCount intValue];
            
            NSNumber *collectionCount = rowData[@"collectionCount"];
            dataa.collectionCount = [collectionCount intValue];
//
            NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
            [array addObjectsFromArray:rowData[@"self"]];
             [array addObjectsFromArray:rowData[@"sysFoods"] ];

            dataa.selfArr= [NSArray arrayWithArray:array];
            
            detailData = dataa;
            [self createTitle];
            [self refreshView];
            [self createFirst];
            [self createSecond];

        }
        NSLog(@"%@",respone);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];

}

-(void)createFirst{
    UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT - 44 + 30, 131, 27)];
    iconImgView.image = [UIImage imageNamed:@"step_1"];
    [bgScrollView addSubview:iconImgView];
    startY = iconImgView.frame.origin.y + 50;
    
    int selfCount = (int)detailData.selfArr.count;
    for (int i = 0; i < selfCount; i++) {
        
        NSDictionary *selfData = detailData.selfArr[i];
        
        UILabel *numlabel = [[UILabel alloc] initWithFrame:CGRectMake(25, iconImgView.frame.origin.y + 50 + 40*i, 40, 18)];
        numlabel.textColor = [UIColor blackColor];
        numlabel.font = [UIFont systemFontOfSize:14.0];
        [bgScrollView addSubview:numlabel];
        numlabel.text = [NSString stringWithFormat:@"%d",i+1];
        
        UILabel *namelabel = [[UILabel alloc] initWithFrame:CGRectMake(85, iconImgView.frame.origin.y + 50 + 40*i, 80, 18)];
        namelabel.textColor = [UIColor blackColor];
        namelabel.font = [UIFont systemFontOfSize:14.0];
        [bgScrollView addSubview:namelabel];
        namelabel.text = selfData[@"name"];
        
        UILabel *dwlabel = [[UILabel alloc] initWithFrame:CGRectMake(220, iconImgView.frame.origin.y + 50 + 40*i, 40, 18)];
        dwlabel.textColor = [UIColor blackColor];
        dwlabel.font = [UIFont systemFontOfSize:14.0];
        [bgScrollView addSubview:dwlabel];
        dwlabel.text = selfData[@"unit"];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(280, iconImgView.frame.origin.y + 44 + 40*i, 30, 30)];
        [img   setImageWithURL:[NSURL URLWithString:selfData[@"img"]] placeholderImage:nil];
        [bgScrollView addSubview:img];
        
        startY += 40;
    }
    

    _firstNextBtn = [UIButton buttonWithType:UIButtonTypeCustom ];
    _firstNextBtn.frame = CGRectMake(SCREENWIDTH/2.0  - 19, startY + 10, 28, 15);
    _firstNextBtn.tag = 0x984;
    
    [_firstNextBtn setBackgroundImage:[UIImage imageNamed:@"a-11_15"] forState:UIControlStateNormal];
    [bgScrollView addSubview:_firstNextBtn];
}

-(void)createSecond{
    
    for (int j = 0; j < 2; j++) {
        UIImageView *iconImgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, startY + 45, 131, 27)];
        iconImgView2.image = [UIImage imageNamed:[NSString stringWithFormat:@"step_%d",j+2]];
        [bgScrollView addSubview:iconImgView2];
        
        //滚动图
        UIScrollView *handleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, startY + 80, SCREENWIDTH, 200)];
        NSArray *array = detailData.handleImg;
        if (j== 1) {
            array = detailData.stewFoodImgs;
        }
        handleScrollView.contentSize = CGSizeMake(SCREENWIDTH*array.count, 200);
        handleScrollView.pagingEnabled = YES;
        for (int i =0; i < array.count; i++) {
            UIImageView *clImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH*i, 0, SCREENWIDTH, 200)];
            [clImgView setContentMode:UIViewContentModeScaleAspectFit];
            [clImgView setImageWithURL:array[i] placeholderImage:[UIImage imageNamed:@"person"]];
            [handleScrollView addSubview:clImgView];
        }
        [bgScrollView addSubview:handleScrollView];
        
        
        UILabel *clLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, startY + 290, SCREENWIDTH - 20, 100)];
        clLabel.numberOfLines = 0;
        clLabel.font = [UIFont systemFontOfSize:17.0];
        clLabel.textColor = [UIColor getColor:@"333333"];
        if (j == 0) {
            clLabel.text = [detailData.handleText stringByAppendingString:@"\n\n\n\n\n\n\n\n\n\n "];
        }else{
            clLabel.text = [detailData.stewFoodText stringByAppendingString:@"\n\n\n\n\n\n\n\n\n\n "];

        }
        [bgScrollView addSubview:clLabel];
        
        startY +=390;
        
        if (j == 0) {
            _secondNextBtn = [UIButton buttonWithType:UIButtonTypeCustom ];
            _secondNextBtn.frame = CGRectMake(SCREENWIDTH/2.0  - 19, startY + 10, 28, 15);
            [_secondNextBtn setBackgroundImage:[UIImage imageNamed:@"a-11_15"] forState:UIControlStateNormal];
            [bgScrollView addSubview:_secondNextBtn];
            _secondNextBtn.tag = 0x983;
        }else{
            UIButton *goShopingBtn = [Tools createBtnWithFrame:CGRectMake(10, startY + 20, SCREENWIDTH - 20, 40) withTitle:@"进入商场" withTitleSize:16];
            goShopingBtn.backgroundColor = THEMECOLOR;
            goShopingBtn.layer.cornerRadius = 3;
            goShopingBtn.tag = 0x986;
            [goShopingBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [bgScrollView addSubview:goShopingBtn];
            
            bgScrollView.contentSize = CGSizeMake(SCREENWIDTH, goShopingBtn.frame.origin.y + 50);
        }
    }
}

-(void)createTitle{
    
    for (int i = 0; i < 4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom ];
        btn.frame = CGRectMake(SCREENWIDTH - 210 + i*50, 20, 18, 18);
        btn.tag = 0x1000 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgScrollView addSubview:btn];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH - 210 + 20 + i*50, 20, 40, 18)];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:13.0];
        [bgScrollView addSubview:label];
        
        switch (i) {
            case 0:
            {
                [btn setBackgroundImage:[UIImage imageNamed:@"a10_03"] forState:UIControlStateNormal];
                label.text = [NSString stringWithFormat:@"%d",detailData.enjoyCount];
            }
                break;
            case 1:
            {
                [btn setBackgroundImage:[UIImage imageNamed:@"a10_05"] forState:UIControlStateNormal];
                label.text = [NSString stringWithFormat:@"%d",detailData.evaCount];

            }
                break;
            case 2:
            {
                [btn setBackgroundImage:[UIImage imageNamed:@"a10_07"] forState:UIControlStateNormal];
                label.text = [NSString stringWithFormat:@"%d",detailData.collectionCount];

            }
                break;
            case 3:
            {
                [btn setBackgroundImage:[UIImage imageNamed:@"bxh"] forState:UIControlStateNormal];
                label.text = [NSString stringWithFormat:@"%d",detailData.dislikeCount];

            }
                break;
            default:
                break;
        }
    }
    
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, SCREENWIDTH, 20)];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:20.0];
    [bgScrollView addSubview:_titleLabel];
    
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, SCREENWIDTH - 20, SCREENHEIGHT - 44 - 60 - 80)];
    _contentLabel.numberOfLines = 0;
    _contentLabel.textColor = [UIColor getColor:@"333333"];
    _contentLabel.font = [UIFont systemFontOfSize:17.0];
    [bgScrollView addSubview:_contentLabel];
    
    _coverNextBtn = [UIButton buttonWithType:UIButtonTypeCustom ];
    _coverNextBtn.frame = CGRectMake(SCREENWIDTH/2.0  - 19, SCREENHEIGHT - 44 - 40, 28, 15);
    _coverNextBtn.tag = 0x985;
    [_coverNextBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_coverNextBtn setBackgroundImage:[UIImage imageNamed:@"a-11_15"] forState:UIControlStateNormal];
    [bgScrollView addSubview:_coverNextBtn];
}

-(void)btnClick:(UIButton *)sender{
    
    switch (sender.tag) {
        case 0x986:
        {
            MyShoppingViewController *vc = [[MyShoppingViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 0x985:
        {
            [bgScrollView setContentOffset:CGPointMake(0, SCREENHEIGHT - 44)];
        }
            break;
        case 0x984:
        {
            [bgScrollView setContentOffset:CGPointMake(0, SCREENWIDTH - 44)];

        }
            break;
        case 0x983:
        {
            [bgScrollView setContentOffset:CGPointMake(0, SCREENWIDTH - 44+ 390*2)];

        }
            break;
        case 0x1000://like
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"你确定要向大家推荐本食谱:热干面?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"提交", nil];
            [alert show];
            
            
        }
            break;
        case 0x1000 + 1://comment
        {
            CommentViewController *vc = [[CommentViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 0x1000 + 2://favorite
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"你确定要收藏本食谱:热干面?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"提交", nil];
            [alert show];
        }
            break;
        case 0x1000 + 3 ://blocl
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"你确定不喜欢本食谱:热干面?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"提交", nil];
            [alert show];
        }
            break;
            
        default:
            break;
    }
}

-(void)refreshView{
    _titleLabel.text = _data.name;
    _contentLabel.text = [detailData.content stringByAppendingString:@"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n "];
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
