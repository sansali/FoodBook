//
//  LoginViewController.m
//  FoodBook
//
//  Created by sansali on 15/9/15.
//  Copyright (c) 2015年 sansali. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgotPwdViewController.h"
@interface LoginViewController ()<UITextFieldDelegate>
{
    UITextField *userNameTextField;
    UITextField *pwdTextField;
}

@property(nonatomic,strong)UIButton *loginBtn;
@property(nonatomic,strong)UIButton *forgotPwdBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"登录";
    [self createNavRightBtn];
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesTap:)];
    [self.view addGestureRecognizer:ges];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(9, 24, SCREENWIDTH - 18, 100)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.borderWidth = 1.0;
    bgView.layer.cornerRadius = 1;
    bgView.layer.borderColor = [UIColor getColor:@"b7b7b7"].CGColor;
    [self.view addSubview:bgView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 50, SCREENWIDTH - 18, 1)];
    line.backgroundColor = [UIColor getColor:@"b7b7b7"];
    [bgView addSubview:line];
    
    UILabel *userNameLab = [[UILabel alloc] initWithFrame:CGRectMake(7, 0, 100, 50)];
    userNameLab.text = @"账号";
    userNameLab.textColor = [UIColor getColor:@"414141"];
    userNameLab.font = [UIFont systemFontOfSize:18.0];
    [bgView addSubview:userNameLab];
    
    UILabel *pwdLab = [[UILabel alloc] initWithFrame:CGRectMake(7, 50, 100, 50)];
    pwdLab.text = @"密码";
    pwdLab.textColor = [UIColor getColor:@"414141"];
    pwdLab.font = [UIFont systemFontOfSize:18.0];
    [bgView addSubview:pwdLab];
    
    userNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(55, 0, SCREENWIDTH - 18 - 65, 50)];
    userNameTextField.placeholder = @"输入手机号码";
    userNameTextField.delegate = self;
    userNameTextField.text = @"18672355656";

    userNameTextField.font = [UIFont     systemFontOfSize:18.0];
    userNameTextField.borderStyle = UITextBorderStyleNone;
    [bgView addSubview:userNameTextField];
    
    pwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(55, 50, SCREENWIDTH - 18 - 65, 50)];
    pwdTextField.placeholder = @"输入密码";
    pwdTextField.delegate = self;
    pwdTextField.font = [UIFont     systemFontOfSize:18.0];
    pwdTextField.borderStyle = UITextBorderStyleNone;
    pwdTextField.text = @"123456";
    pwdTextField.secureTextEntry = YES;
    [bgView addSubview:pwdTextField];
    
    _loginBtn = [Tools createBtnWithFrame:CGRectMake(10, 205, SCREENWIDTH - 20, 40) withTitle:@"立即登录" withTitleSize:16];
    _loginBtn.backgroundColor = THEMECOLOR;
    [_loginBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    _loginBtn.layer.cornerRadius = 3;
    [_loginBtn addTarget:self action:@selector(gotoLogin:) forControlEvents:UIControlEventTouchUpInside];

    _forgotPwdBtn = [Tools createBtnWithFrame:CGRectMake(12, 136, 80, 20) withTitle:@"忘记密码?" withTitleSize:16];
    [_forgotPwdBtn setTitleColor:THEMECOLOR forState:UIControlStateNormal];
    [_forgotPwdBtn addTarget:self action:@selector(gotoFindPwd:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:_loginBtn];
    [self.view addSubview:_forgotPwdBtn];

}

-(void)goBackBtnClick{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)initNavBar
{
    if (!_isPresent) {
        UIButton *goBackBtn = [[UIButton alloc] init];
        goBackBtn.frame = CGRectMake(0.0, 0, 45 , 44);
        [goBackBtn setImageEdgeInsets:UIEdgeInsetsMake(11, 5, 11, 25)];
        [goBackBtn setBackgroundColor:[UIColor clearColor]];
        [goBackBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [goBackBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted];
        [goBackBtn addTarget:self action:@selector(goBackBtnClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:goBackBtn];
        self.navigationItem.leftBarButtonItem = leftItem;
    }
}

-(void)createNavRightBtn{
    
    NSString *btnTitle = _isPresent?@"取消":@"注册";
    UIButton *rightBtn = [Tools createBtnWithFrame:CGRectMake(15, 250, 60, 20) withTitle:btnTitle withTitleSize:19];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)check{
    if (userNameTextField.text.length <=0) {
        [Tools showAlertWithTitle:@"请输入手机号码"];
        return NO;
    }
    
    if (pwdTextField.text.length <=0) {
        [Tools showAlertWithTitle:@"请输入密码"];
        return NO;

    }
    return YES;
}

-(void)gotoLogin:(UIButton *)sender{
    
    if ([self check]) {
        //request
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
        [dic setObject:userNameTextField.text forKey:@"phone"];
        [dic setObject:pwdTextField.text forKey:@"password"];

        [self requestServicePOSTWithURL:@"http://106.185.26.36:8080/yimian/app/user/appLogin.do" withParam:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *respone = responseObject;
            bool success = [respone objectForKey:@"success"];
            if (success) {
                NSDictionary *userDic = [respone objectForKey:@"user"];
                
                
                User *user = [[User alloc] init];
                user.userId = userDic[@"id"];
                user.phone = userDic[@"phone"];
                user.name = userDic[@"nickName"];
                
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
                _loginCallBack(YES);
                
                if (_isPresent) {
                    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                }else{
                    [self.navigationController popViewControllerAnimated:YES];
                }
       
            }else{
                NSString *msg = [respone objectForKey:@"message"];
                [Tools showAlertWithTitle:msg];
            }
            NSLog(@"%@",respone);
       
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }

}

-(void)rightBtnClick:(UIButton *)sender{
    
    if (_isPresent) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }else{
        RegisterViewController *vc = [[RegisterViewController alloc] init];
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }

}

-(void)gotoFindPwd:(UIButton *)sender{
    ForgotPwdViewController *vc = [[ForgotPwdViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)gesTap:(UITapGestureRecognizer *)ges{
    [userNameTextField resignFirstResponder];
    [pwdTextField resignFirstResponder];

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
