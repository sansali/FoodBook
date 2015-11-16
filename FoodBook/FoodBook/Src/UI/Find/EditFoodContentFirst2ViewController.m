//
//  EditFoodContentFirst2ViewController.m
//  FoodBook
//
//  Created by sansali on 15/10/21.
//  Copyright © 2015年 sansali. All rights reserved.
//

#import "EditFoodContentFirst2ViewController.h"
#import "EditFoodContentSecondViewController.h"

@interface EditFoodContentFirst2ViewController ()

@end

@implementation EditFoodContentFirst2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"编辑食谱内容";
    [self createAll];
}

-(void)createAll{
    
    UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 131, 27)];
    iconImgView.image = [UIImage imageNamed:@"step_1"];
    [self.view addSubview:iconImgView];
    
    
    
    
    
    UIView *bgWhiteView = [[UIView alloc] initWithFrame:CGRectMake(40, 67, SCREENWIDTH - 80, 70)];
    bgWhiteView.backgroundColor = [UIColor whiteColor];
    bgWhiteView.layer.borderColor = [UIColor getColor:@"a1a1a1"].CGColor;
    bgWhiteView.layer.borderWidth = .5f;
    [self.view addSubview:bgWhiteView];
    
    UIImageView *topView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"a_07"]];
    topView.center = CGPointMake(SCREENWIDTH/2.0 - 40, 0);
    [bgWhiteView addSubview:topView];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, -13, SCREENWIDTH - 80, 26)];
    titleLab.text = @"自选食材";
    titleLab.textColor = [UIColor getColor:@"ce2f08"];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [bgWhiteView addSubview:titleLab];
    
        UILabel *title2Lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 50, 20)];
        title2Lab.text = @"1";
        title2Lab.textAlignment = NSTextAlignmentRight;
        [bgWhiteView addSubview:title2Lab];
        
        
        UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 30 , 100, 20)];
        typeLabel.text = @" 特粗面";
        typeLabel.font = [UIFont systemFontOfSize:15.0f];
        typeLabel.textColor = [UIColor getColor:@"a1a1a1"];
        typeLabel.layer.borderColor = [UIColor getColor:@"ce2f08"].CGColor;
        typeLabel.layer.borderWidth = .5f;
        [bgWhiteView addSubview:typeLabel];

        
        UITextField *sumTextField = [[UITextField alloc] initWithFrame:CGRectMake(190, 30 , 30, 20)];
        sumTextField.text = @" 1";
        sumTextField.font = [UIFont systemFontOfSize:15.0f];
        sumTextField.textColor = [UIColor getColor:@"a1a1a1"];
        sumTextField.layer.borderColor = [UIColor getColor:@"ce2f08"].CGColor;
        sumTextField.layer.borderWidth = .5f;
        [bgWhiteView addSubview:sumTextField];
    
        
        UIImageView *iconImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"a4_03"]];
        iconImg.frame = CGRectMake(250, 30 , 20, 20);
        [bgWhiteView addSubview:iconImg];
        
    
    
    UIButton *nextBtn = [Tools createBtnWithFrame:CGRectMake(10, 310, SCREENWIDTH - 20, 40) withTitle:@"下一步" withTitleSize:16];
    nextBtn.backgroundColor = THEMECOLOR;
    nextBtn.layer.cornerRadius = 3;
    nextBtn.tag = 0x987;
    [nextBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
}

-(void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 0x987:
        {
            //next
            EditFoodContentSecondViewController *vc = [[EditFoodContentSecondViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
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
