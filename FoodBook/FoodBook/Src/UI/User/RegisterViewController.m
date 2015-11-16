//
//  RegisterViewController.m
//  FoodBook
//
//  Created by sansali on 15/9/15.
//  Copyright (c) 2015年 sansali. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate>
{
    UITextField *phoneTextField;
    UITextField *pwdTextField;
    UITextField *captchaTextField;
    NSString *captchaString;
}
@property(nonatomic,strong)UIButton *registerBtn;
@property(nonatomic,strong)UIButton *loginBtn;
@property(nonatomic,strong)UIButton *captchaBtn;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"注册";
    [self createNavRightBtn];
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesTap:)];
    [self.view addGestureRecognizer:ges];

    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(9, 24, SCREENWIDTH - 18, 132)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.borderWidth = 1.0;
    bgView.layer.cornerRadius = 1;
    bgView.layer.borderColor = [UIColor getColor:@"b7b7b7"].CGColor;
    [self.view addSubview:bgView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 44, SCREENWIDTH - 18, 1)];
    line.backgroundColor = [UIColor getColor:@"b7b7b7"];
    [bgView addSubview:line];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 88, SCREENWIDTH - 18, 1)];
    line2.backgroundColor = [UIColor getColor:@"b7b7b7"];
    [bgView addSubview:line2];
    
    NSArray *titles = @[@"手机号",@"验证码",@"密    码"];
    NSArray *places = @[@"输入11位手机号码",@"输入短信验证码",@"设置密码（6-16个字符）"];

    for (int i = 0; i < 3; i++) {
        UILabel *userNameLab = [[UILabel alloc] initWithFrame:CGRectMake(7, 44*i, 100, 44)];
        userNameLab.text = titles[i];
        userNameLab.textColor = [UIColor getColor:@"414141"];
        userNameLab.font = [UIFont systemFontOfSize:16.0];
        [bgView addSubview:userNameLab];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(70,  44*i, SCREENWIDTH - 18 - 80, 44)];
        textField.placeholder = places[i];
        textField.delegate = self;
        textField.font = [UIFont     systemFontOfSize:16.0];
        textField.borderStyle = UITextBorderStyleNone;
        [bgView addSubview:textField];
        
        if (i == 0) {
            phoneTextField = textField;
        }else if(i ==2){
            pwdTextField = textField;
            pwdTextField.secureTextEntry = YES;
        }else{
            captchaTextField = textField;
        }
    }
    
    _registerBtn = [Tools createBtnWithFrame:CGRectMake(10, 225, SCREENWIDTH - 20, 40) withTitle:@"立即注册" withTitleSize:16];
    _registerBtn.backgroundColor = THEMECOLOR;
    _registerBtn.layer.cornerRadius = 1.5;
    [_registerBtn addTarget:self action:@selector(gotoRegister:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registerBtn];
    
    _captchaBtn = [Tools createBtnWithFrame:CGRectMake(SCREENWIDTH - 95, 51, 70, 30) withTitle:@"获取验证码" withTitleSize:16];
    _captchaBtn.backgroundColor = [UIColor getColor:@"db013b"];
    _captchaBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    _captchaBtn.layer.cornerRadius = 1.5;
    [_captchaBtn addTarget:self action:@selector(captchaBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:_captchaBtn];
    
    UILabel *acceptLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 286, SCREENWIDTH, 20)];
    acceptLab.text = @"注册即接受（一麵网使用协议）";
    acceptLab.textAlignment = NSTextAlignmentCenter;
    acceptLab.textColor = [UIColor getColor:@"414141"];
    acceptLab.font = [UIFont systemFontOfSize:18.0];
    [bgView addSubview:acceptLab];

}

-(void)createNavRightBtn{
    _loginBtn = [Tools createBtnWithFrame:CGRectMake(15, 0, 60, 20) withTitle:@"登录" withTitleSize:19];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(gotoLogin:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:_loginBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

-(void)gotoLogin:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(BOOL)check{
    if (phoneTextField.text.length <=0) {
        [Tools showAlertWithTitle:@"请输入手机号码"];
        return NO;
    }
    
    if (pwdTextField.text.length <=0) {
        [Tools showAlertWithTitle:@"请输入密码"];
        return NO;
        
    }
    
    if (captchaTextField.text.length <=0) {
        [Tools showAlertWithTitle:@"请输入验证码"];
        return NO;
        
    }
    return YES;
}

-(void)gotoRegister:(UIButton *)sender{
    
    if ([self check]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
        [dic setObject:phoneTextField.text forKey:@"phone"];
        [dic setObject:pwdTextField.text forKey:@"password"];
        [dic setObject:captchaTextField.text forKey:@"verifyMess"];

        [self requestServicePOSTWithURL:@"http://106.185.26.36:8080/yimian/app/user/reg.do" withParam:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *respone = responseObject;
            NSNumber *success = [respone objectForKey:@"success"];
            if ([success intValue] == 1) {
                NSDictionary *userDic = [respone objectForKey:@"rows"];
                
                
                User *user = [[User alloc] init];
                user.userId = userDic[@"id"];
                user.phone = userDic[@"phone"];
                user.name = userDic[@"nickName"];
                user.sex = userDic[@"sex"];
                user.birthday = userDic[@"birthday"];
                user.remark = userDic[@"remark"];
                user.img = userDic[@"img"];
                user.token = userDic[@"token"];
                
                [[UserCenter shareInstance] setLoginUser:user];
                
                [self.navigationController popToRootViewControllerAnimated:YES];

            }
            else{
                NSString *msg = [respone objectForKey:@"message"];
                [Tools showAlertWithTitle:msg];
            }
            NSLog(@"%@",respone);
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)captchaBtnClick:(UIButton *)sender{
    
    if (phoneTextField.text.length <=0) {
        [Tools showAlertWithTitle:@"请输入手机号码"];
        return;
    }
    
    [self requestServiceGetWithURL:[NSString stringWithFormat:@"http://106.185.26.36:8080/yimian/app/user/sendVerify.do?phone=%@",phoneTextField.text] withParam:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *respone = responseObject;
        NSNumber *success = [respone objectForKey:@"success"];
        if ([success intValue] == 1) {
             NSString *verifyMess = [respone objectForKey:@"verifyMess"];
            captchaString = verifyMess;
        }
        else{
            NSString *msg = [respone objectForKey:@"message"];
            [Tools showAlertWithTitle:msg];
        }
        NSLog(@"%@",respone);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}

-(void)gesTap:(UITapGestureRecognizer *)ges{
    [phoneTextField  resignFirstResponder];
    [pwdTextField resignFirstResponder];
    [captchaTextField  resignFirstResponder];
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
