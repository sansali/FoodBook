//
//  EditCoverSecondViewController.m
//  FoodBook
//
//  Created by sansali on 15/10/15.
//  Copyright © 2015年 sansali. All rights reserved.
//

#import "EditFoodContentFirstViewController.h"
#import "EditFoodContentFirst2ViewController.h"
#import "KxMenu.h"

@interface EditFoodContentFirstViewController ()<UITextFieldDelegate>

@end

@implementation EditFoodContentFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"编辑食谱内容";
    [self createAll ];
}

-(void)createAll{
    
    UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 131, 27)];
    iconImgView.image = [UIImage imageNamed:@"step_1"];
    [self.view addSubview:iconImgView];
    
    
    
    
    
    UIView *bgWhiteView = [[UIView alloc] initWithFrame:CGRectMake(40, 67, SCREENWIDTH - 80, 240)];
    bgWhiteView.backgroundColor = [UIColor whiteColor];
    bgWhiteView.layer.borderColor = [UIColor getColor:@"a1a1a1"].CGColor;
    bgWhiteView.layer.borderWidth = .5f;
    [self.view addSubview:bgWhiteView];
    
    UIImageView *topView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"a_07"]];
    topView.backgroundColor = [UIColor whiteColor];
    topView.center = CGPointMake(SCREENWIDTH/2.0 - 40, 0);
    [bgWhiteView addSubview:topView];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, -13, SCREENWIDTH - 80, 26)];
    titleLab.text = @"仟一食材";
    titleLab.textColor = [UIColor getColor:@"ce2f08"];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [bgWhiteView addSubview:titleLab];
    
    NSArray *titles = @[@"面饼",@"味料包",@"酱料包",@"油料包",@"菜肉包"];
    for (int i = 0;  i < 5; i++) {
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 30 + i*40, 55, 20)];
        titleLab.text = titles[i];
        titleLab.textAlignment = NSTextAlignmentRight;
        [bgWhiteView addSubview:titleLab];
        
        
        UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 30 + i*40, 100, 20)];
        typeLabel.text = @" 特粗面";
        typeLabel.font = [UIFont systemFontOfSize:15.0f];
        typeLabel.userInteractionEnabled = YES;
        typeLabel.textColor = [UIColor getColor:@"a1a1a1"];
        typeLabel.layer.borderColor = [UIColor getColor:@"ce2f08"].CGColor;
        typeLabel.layer.borderWidth = .5f;
        [bgWhiteView addSubview:typeLabel];
        
        UIButton *iconBtn = [[UIButton alloc] initWithFrame:CGRectMake(75,   5, 19, 11)];
        [iconBtn setBackgroundImage:[UIImage imageNamed:@"a_11"] forState:UIControlStateNormal ];
        [iconBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [typeLabel addSubview:iconBtn];
        
        
        UITextField *sumTextField = [[UITextField alloc] initWithFrame:CGRectMake(185, 30 + i*40, 30, 20)];
        sumTextField.text = @" 1";
        sumTextField.font = [UIFont systemFontOfSize:15.0f];
        sumTextField.textColor = [UIColor getColor:@"a1a1a1"];
        sumTextField.layer.borderColor = [UIColor getColor:@"ce2f08"].CGColor;
        sumTextField.layer.borderWidth = .5f;
        sumTextField.delegate = self;
        [bgWhiteView addSubview:sumTextField];
        
        UILabel *danLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 30 + i*40, 20, 20)];
        danLabel.text = @"包";
        [bgWhiteView addSubview:danLabel];
        
        UIImageView *iconImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"a4_03"]];
        iconImg.frame = CGRectMake(250, 30 + i*40, 20, 20);
        [bgWhiteView addSubview:iconImg];
        
    }
    
    UIButton *nextBtn = [Tools createBtnWithFrame:CGRectMake(10, bgWhiteView.frame.origin.y + bgWhiteView.frame.size.height + 20, SCREENWIDTH - 20, 40) withTitle:@"下一步" withTitleSize:16];
    nextBtn.backgroundColor = THEMECOLOR;
    nextBtn.layer.cornerRadius = 3;
    nextBtn.tag = 0x987;
    [nextBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 0x987:
        {
            //next
            EditFoodContentFirst2ViewController *vc = [[EditFoodContentFirst2ViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
        {
                NSArray *menuItems =
                @[
                  
                  [KxMenuItem menuItem:@"仟一食材"
                                 image:nil
                                target:nil
                                action:NULL],
                  
                  [KxMenuItem menuItem:@"特粗面"
                                 image:[UIImage imageNamed:@"action_icon"]
                                target:self
                                action:@selector(pushMenuItem:)],
                  
                  [KxMenuItem menuItem:@"不特粗面"
                                 image:[UIImage imageNamed:@"check_icon"]
                                target:self
                                action:@selector(pushMenuItem:)]
                  ];
                
                KxMenuItem *first = menuItems[0];
                first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
                first.alignment = NSTextAlignmentCenter;
                
                [KxMenu showMenuInView:self.view
                              fromRect:[sender convertRect:sender.frame toView:self.view]
                             menuItems:menuItems];
        }
            break;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void) pushMenuItem:(id)sender
{
    
    UILabel *label = (UILabel *)[(UIButton *)sender superview];
    NSLog(@"%@", sender);
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
