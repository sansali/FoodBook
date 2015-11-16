//
//  ForgotPwdViewController.m
//  FoodBook
//
//  Created by sansali on 15/9/17.
//  Copyright (c) 2015年 sansali. All rights reserved.
//

#import "ForgotPwdViewController.h"

@interface ForgotPwdViewController ()<UITextFieldDelegate>
{
    UITextField *phoneTextField;
    UITextField *captchaTextField;
    UITextField *pwdTextField;
    UITextField *pwdNewTextField;
    NSString *captchaString;

}
@property(nonatomic,strong)UIButton *submitBtn;
@property(nonatomic,strong)UIButton *captchaBtn;

@end

@implementation ForgotPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"忘记密码";
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(9, 24, SCREENWIDTH - 18, 176)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.borderWidth = 1.0;
    bgView.layer.cornerRadius = 1;
    bgView.layer.borderColor = [UIColor getColor:@"b7b7b7"].CGColor;
    [self.view addSubview:bgView];
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesTap:)];
    [self.view addGestureRecognizer:ges];
    
    NSArray *titles = @[@"手        机",@"验  证  码",@"新  密  码",@"确认密码"];
    NSArray *places = @[@"输入11位手机号码",@"输入验证码",@"填写新密码",@"再次输入密码"];
    
    for (int i = 0; i < 4; i++) {
        
        if (i != 0) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 44* i, SCREENWIDTH - 18, 1)];
            line.backgroundColor = [UIColor getColor:@"b7b7b7"];
            [bgView addSubview:line];
        }
        
        UILabel *userNameLab = [[UILabel alloc] initWithFrame:CGRectMake(7, 44*i, 100, 44)];
        userNameLab.text = titles[i];
        userNameLab.textColor = [UIColor getColor:@"414141"];
        userNameLab.font = [UIFont systemFontOfSize:16.0];
        [bgView addSubview:userNameLab];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(77,  44*i, SCREENWIDTH - 18 - 87, 44)];
        textField.placeholder = places[i];
        textField.delegate = self;
        textField.font = [UIFont     systemFontOfSize:16.0];
        textField.borderStyle = UITextBorderStyleNone;
        [bgView addSubview:textField];
        
        if (i == 0) {
            phoneTextField = textField;
        }else if(i ==1){
            captchaTextField = textField;

        }else if(i == 2){
            pwdTextField = textField;
            textField.secureTextEntry =YES;
        }else{
            pwdNewTextField = textField;
            textField.secureTextEntry =YES;
        }
    }
    
    _submitBtn = [Tools createBtnWithFrame:CGRectMake(10, 225, SCREENWIDTH - 20, 40) withTitle:@"提交" withTitleSize:16];
    _submitBtn.backgroundColor = THEMECOLOR;
    _submitBtn.layer.cornerRadius = 1.5;
    [_submitBtn addTarget:self action:@selector(gotoSubmit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitBtn];
    
    _captchaBtn = [Tools createBtnWithFrame:CGRectMake(SCREENWIDTH - 95, 8, 70, 28) withTitle:@"获取验证码" withTitleSize:16];
    //    _registerBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    _captchaBtn.backgroundColor = [UIColor getColor:@"db013b"];
    _captchaBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    _captchaBtn.layer.cornerRadius = 1.5;
    //    _registerBtn.layer.borderWidth = 1.0;
    [_captchaBtn addTarget:self action:@selector(gotoCaptch:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:_captchaBtn];
}


-(void)gotoSubmit:(UIButton *)sender{
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

-(void)gotoCaptch:(UIButton *)sender{
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
    
    if (pwdNewTextField.text.length <=0) {
        [Tools showAlertWithTitle:@"请输入新密码"];
        return NO;
        
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)gesTap:(UITapGestureRecognizer *)ges{
    [phoneTextField resignFirstResponder];
    [captchaTextField resignFirstResponder];
    [pwdTextField resignFirstResponder];
    [pwdNewTextField resignFirstResponder];
    
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
