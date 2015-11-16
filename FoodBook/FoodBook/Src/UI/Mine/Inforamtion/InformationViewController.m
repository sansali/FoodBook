//
//  InformationViewController.m
//  FoodBook
//
//  Created by sansali on 15/9/17.
//  Copyright (c) 2015年 sansali. All rights reserved.
//

#import "InformationViewController.h"
#import "InformationHeadTableViewCell.h"
#import "InformationLogoutTableViewCell.h"
#import "InformationSexTableViewCell.h"
#import "InformationTableViewCell.h"

@interface InformationViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    BOOL isEditing;
    User *user;
}
@property(nonatomic,retain)UITableView *tableView;

@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"个人资料";
    user = [UserCenter shareInstance].loginUser;

    [self createNavRightBtn];
    [self createTableView];
}

-(void)createNavRightBtn{
    UIButton *btn = [Tools createBtnWithFrame:CGRectMake(15, 250, 60, 20) withTitle:@"编辑" withTitleSize:19];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"编辑" forState:UIControlStateNormal];
    [btn setTitle:@"保存" forState:UIControlStateSelected];

    [btn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

-(void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 44 )];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    UIView *view = [UIView new];
    [_tableView setTableFooterView:view];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

-(void)editBtnClick:(UIButton *)sender{
    [sender setSelected:!sender.isSelected];
    
    if(sender.isSelected){
        //编辑状态
    }else{
        //要保存
        [self saveData];
    }
    isEditing = sender.selected;
    [_tableView  reloadData];

}

-(void)saveData{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
//    [dic setObject:user.userId forKey:@"id"];
//    [dic setObject:user.name forKey:@"nickName"];
//    [dic setObject:user.birthday forKey:@"birthday"];
//    [dic setObject:@(user.sex) forKey:@"sex"];
    [dic setObject:user.token forKey:@"token"];
//    [dic setObject:user.remark forKey:@"remark"];

    
    [self requestServiceImgPOSTWithURL:@"http://106.185.26.36:8080/yimian/app/user/updateUserImg.do" withParam:dic withImgArr:nil  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *respone = responseObject;
        bool success = [respone objectForKey:@"success"];
        if (success) {
            NSDictionary *userDic = [respone objectForKey:@"user"];
            
            
            User *user2 = [[User alloc] init];
            user2.userId = userDic[@"id"];
            user2.phone = userDic[@"phone"];
            user2.name = userDic[@"nickName"];


            NSNumber *sex = userDic[@"sex"];
            user.sex = [sex intValue];
            
            if (userDic[@"birthday"] && [userDic[@"birthday"] isKindOfClass:[NSString class]]) {
                user.birthday = userDic[@"birthday"];
                
            }else{
                user.birthday = @"";
            }
            
            if (userDic[@"remark"] && [userDic[@"remark"] isKindOfClass:[NSString class]]) {
                user.remark = userDic[@"remark"];
                
            }else{
                user.remark = @"";
            }
            
            user.img = userDic[@"img"];
            user.token = userDic[@"token"];
            NSNumber *time = userDic[@"regtime"];
            user.registerTime = [time longLongValue];
            
            
            [[UserCenter shareInstance] setLoginUser:user];
            
        }else{
            NSString *msg = [respone objectForKey:@"message"];
            [Tools showAlertWithTitle:msg];
        }
        NSLog(@"%@",respone);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark table datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    if (indexPath.row == 3) {
        //show DatePick
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT - 284, SCREENWIDTH, 240)];
        view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:view];
        UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, SCREENWIDTH, 200)];
        picker.datePickerMode = UIDatePickerModeDate;
        picker.backgroundColor = [UIColor whiteColor];
        [view addSubview:picker];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom ];
        btn.frame = CGRectMake(SCREENWIDTH - 120, 5, 100, 30);
        [btn  setTitle:@"确定" forState:UIControlStateNormal];
        btn.backgroundColor = THEMECOLOR;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
    }

}

-(void)btnClick:(UIButton *)sender{
    [sender.superview removeFromSuperview];
    
    UIDatePicker *picker = (UIDatePicker *)sender.superview.subviews[0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *datestring = [formatter stringFromDate: picker.date ];
    user.birthday = datestring;
    [_tableView reloadData];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
        {
            static NSString *cellName = @"MineIconHeadTableViewCell";
            InformationHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
            if (cell == nil) {
                cell = [[InformationHeadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            }
            
            cell.accountLabel.text = user.phone;
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:user.registerTime/1000.0];
            NSDateFormatter *dateFormatter = [[NSDateFormatter  alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *dateString = [dateFormatter stringFromDate:date];
            cell.registerTimeLabel.text = dateString;

            return cell;
        }
            break;
        case 2:
        {
            static NSString *cellName = @"MineIconSexTableViewCell";
            
            InformationSexTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
            if (cell == nil) {
                cell = [[InformationSexTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            }
            [cell setSex:user.sex whitEditing:isEditing];
            [cell setBtnCallBack:^(int sex) {
                user.sex    = sex ;
            }];
            
            return cell;

        }
            break;

        case 5:
        {
            static NSString *cellName = @"MineIconLogoutTableViewCell";
            InformationLogoutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
            if (cell == nil) {
                cell = [[InformationLogoutTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            }
            
            [cell setLoginoutCallBack:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
            
            return cell;

        }
            break;
            
        default:
        {
            static NSString *cellName = @"MineIconTableViewCell";
            InformationTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
            if (cell == nil) {
                cell = [[InformationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            }
            
            NSArray *titles = @[@"",@"昵称",@"",@"生日",@"简介"];
            NSArray *places = @[@"",@"",@"",@"",@"介绍下自己吧"];
            NSArray *texts = @[@"",user.name,@"",user.birthday,user.remark];

            cell.titleLabel.text = titles[indexPath.row];
            cell.valueTextFiled.placeholder = places[indexPath.row];
            cell.valueTextFiled.delegate = self;
            cell.valueTextFiled.tag = indexPath.row;
            [cell editIng:isEditing];
            if (indexPath.row == 3) {
                [cell editIng:NO];
            }
            cell.valueTextFiled.text = texts[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;

        }
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
            return 100;
            break;
            
        default:
            return 60;
            break;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField.tag == 1) {
        //nickname
        user.name = textField.text;
        
    }else if(textField.tag == 4){
        //remarke
        user.remark = textField.text;

    }
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
