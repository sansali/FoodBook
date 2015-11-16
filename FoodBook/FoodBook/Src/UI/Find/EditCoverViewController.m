//
//  EditCoverViewController.m
//  FoodBook
//
//  Created by sansali on 15/10/14.
//  Copyright © 2015年 sansali. All rights reserved.
//

#import "EditCoverViewController.h"
#import "EditFoodContentFirstViewController.h"
#import "SDAssetPickerController.h"

@interface EditCoverViewController ()<UITextFieldDelegate,UITextViewDelegate>
{
    UIScrollView *bgScrollView;
    UIButton *nextBtn;
    UIButton *addCoverBtn;
    
    UITextField *nameTextField;
    UITextField *tasteTextField;
    UITextField *addressTextField;
    UITextView *contentTextView;

}
@end

@implementation EditCoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"编辑食谱封面";
    [self createAll];

}

-(void)createAll{
    
    bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 44)];
    
    NSArray *titles = @[@"名称",@"口味",@"地域"];
    for (int i = 0; i < 3; i++) {
        UILabel *editTitle = [Tools createLabWithFrame:CGRectMake(10, 20 + 40*i, SCREENWIDTH - 20, 30) withTitle:titles[i] withTitleSize:16.0 withTextColor:[UIColor blackColor]];
        [bgScrollView addSubview:editTitle];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 20 + 40*i, SCREENWIDTH - 60, 30)];
        textField.layer.cornerRadius = 1.5;
        textField.delegate = self;
        textField.backgroundColor = [UIColor whiteColor];
        textField.layer.borderColor = [UIColor grayColor].CGColor;
        textField.layer.borderWidth = 0.5;
        [bgScrollView addSubview:textField];
        
        if (i == 0) {
            nameTextField = textField;
        }else if(i == 1){
            tasteTextField = textField;
        }else{
            addressTextField = textField;
        }
    }
    
    
    
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"食谱概述（字数在50字以内）"];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 4)];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(4, 10)];
    UILabel *editIntroduce = [Tools createLabWithFrame:CGRectMake(10, 150 ,SCREENWIDTH - 20, 20) withAttributed:string withTitleSize:16.0 withTextColor:[UIColor blackColor]];
    [bgScrollView addSubview:editIntroduce];
    
    contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 180, SCREENWIDTH - 20, 80)];
    contentTextView.layer.cornerRadius = 1.5;
    contentTextView.delegate = self;
    contentTextView.backgroundColor = [UIColor whiteColor];
    contentTextView.layer.borderColor = [UIColor grayColor].CGColor;
    contentTextView.layer.borderWidth = 0.5;
    [bgScrollView addSubview:contentTextView];
    
    
    
    NSMutableAttributedString *coverString = [[NSMutableAttributedString alloc] initWithString:@"食谱封面图片（仅需一张图片）"];
    [coverString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 6)];
    [coverString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(6, 8)];
    UILabel *coverTitle = [Tools createLabWithFrame:CGRectMake(10, 280, SCREENWIDTH - 20, 20) withAttributed:coverString withTitleSize:16.0 withTextColor:[UIColor blackColor]];
    [bgScrollView addSubview:coverTitle];
    
    float itemWidth = (SCREENWIDTH - 40)/3.0;
    addCoverBtn = [Tools createBtnWithFrame:CGRectMake(10, 310, itemWidth, itemWidth) withTitle:@"" withTitleSize:16];
    [addCoverBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    addCoverBtn.tag = 0x986;
    addCoverBtn.layer.cornerRadius = 4.0;
    addCoverBtn.clipsToBounds = YES;
    [addCoverBtn setBackgroundImage:[UIImage imageNamed:@"media_add_btn"] forState:UIControlStateNormal];
    [bgScrollView addSubview:addCoverBtn];
    
    
    
    nextBtn = [Tools createBtnWithFrame:CGRectMake(10, 310 + itemWidth + 10, SCREENWIDTH - 20, 40) withTitle:@"下一步" withTitleSize:16];
    nextBtn.backgroundColor = THEMECOLOR;
    nextBtn.layer.cornerRadius = 3;
    nextBtn.tag = 0x987;
    [nextBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:nextBtn];
    
    [self.view addSubview:bgScrollView];
    [bgScrollView setContentSize:CGSizeMake(SCREENWIDTH, nextBtn.frame.origin.y + 50)];

    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topGes:)];
    [bgScrollView addGestureRecognizer:ges];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)topGes:(UIGestureRecognizer *)sender{
    [nameTextField resignFirstResponder];
    [tasteTextField resignFirstResponder];
    [addressTextField resignFirstResponder];
    [contentTextView resignFirstResponder];
}

-(void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 0x987:
        {
            //next
            EditFoodContentFirstViewController *vc = [[EditFoodContentFirstViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 0x986:
        {
            [self gotoSelectImage];
        }
            
        default:
            break;
    }
}

//添加图片事件
-(void)gotoSelectImage
{
    SDAssetPickerController *pickerController = [[SDAssetPickerController alloc] initWithAssetsType:AllPhotos];
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:^{}];
}


#pragma mark- SDAssetControllerDelegate
-(void)assetsPickerController:(SDAssetPickerController *)picker didFinishPickingAssets:(NSMutableArray *)assets
{
    
    ALAsset *tempAsset = [assets objectAtIndex:0];
    [addCoverBtn setBackgroundImage:[UIImage imageWithCGImage:[tempAsset defaultRepresentation].fullScreenImage] forState:UIControlStateNormal];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    [bgScrollView setContentOffset:CGPointMake(0, 200)];
    [bgScrollView setContentSize:CGSizeMake(SCREENWIDTH, nextBtn.frame.origin.y + 100 )];
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    
    [bgScrollView setContentOffset:CGPointMake(0, 0)];
    [bgScrollView setContentSize:CGSizeMake(SCREENWIDTH, nextBtn.frame.origin.y + 50 )];
    return YES;
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
