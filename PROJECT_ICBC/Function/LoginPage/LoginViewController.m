//
//  LoginViewController.m
//  PROJECT_ICBC
//
//  Created by xionghuaxin on 7/21/16.
//  Copyright © 2016 xionghuanxin. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "RootViewController.h"
#import "XStringUtils.h"
#import "NetRequest.h"
@interface LoginViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UIImageView *backgroudImageView;
@property(nonatomic,strong)UIImageView *loginView;
@property(nonatomic,strong)UITextField *accountTextField;
@property(nonatomic,strong)UITextField *passwordTextField;
@property(nonatomic,strong)UIButton *passwordRemenberCheckbox;
@property(nonatomic,strong)UIButton *loginButton;

@property(nonatomic,strong)NSString *passwordMD5String;


@end
@implementation LoginViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view layoutIfNeeded];
    [self.loginView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(386, 492));
        make.top.equalTo(self.view.mas_bottom);
    }];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:1 animations:^{
        [self.loginView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(386, 492));
            make.centerY.equalTo(self.view);
        }];
        self.loginView.center = self.view.center;
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
-(void)setupUI
{
    [self.view addSubview:self.backgroudImageView];
    [self.view addSubview:self.loginView];
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(386, 492));
        make.centerY.mas_equalTo(self.view);
    }];
    [self.loginView addSubview:self.accountTextField];
    [self.accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(112, 33, 330, 30));
        
    }];
    [self.loginView addSubview:self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.accountTextField);
        make.size.mas_equalTo(self.accountTextField);
        make.top.mas_equalTo(self.accountTextField.mas_bottom).offset(70);
    }];
    [self.loginView addSubview:self.passwordRemenberCheckbox];
    [self.passwordRemenberCheckbox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.loginView).offset(38);
        make.top.mas_equalTo(self.passwordTextField.mas_bottom).offset(29);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    [self.loginView addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.loginView).offset(-34);
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(70);
        make.size.mas_equalTo(CGSizeMake(150, 50));
    }];
    
    //    self.loginView.center = CGPointMake(self.view.center.x, 2000);
    
}

#pragma mark-----------getter
-(UIImageView *)backgroudImageView
{
    if (_backgroudImageView == nil) {
        _backgroudImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
        _backgroudImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Default-Landscape" ofType:@"png" inDirectory:@""]];
    }
    return _backgroudImageView;
}
-(UIView *)loginView
{
    if (_loginView == nil) {
        _loginView = [[UIImageView alloc]init];
        _loginView.userInteractionEnabled = YES;
        _loginView.image =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"登录框_03" ofType:@"png" inDirectory:@""]];
    }
    return _loginView;
}
-(UITextField *)accountTextField
{
    if (_accountTextField == nil) {
        _accountTextField = [[UITextField alloc]init];
        _accountTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _accountTextField.delegate = self;
        _accountTextField.tag = 201;
    }
    return _accountTextField;
}
-(UITextField *)passwordTextField
{
    if (_passwordTextField == nil) {
        _passwordTextField = [[UITextField alloc]init];
        _passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _passwordTextField.delegate = self;
        _passwordTextField.tag = 202;
        _passwordTextField.secureTextEntry = YES;
        
    }
    return _passwordTextField;
}
-(UIButton * )passwordRemenberCheckbox
{
    if (_passwordRemenberCheckbox == nil) {
        _passwordRemenberCheckbox = [UIButton buttonWithType:UIButtonTypeCustom];
        [_passwordRemenberCheckbox addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
        [_passwordRemenberCheckbox setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"记住密码未点击_03" ofType:@"png" inDirectory:@""]] forState:UIControlStateNormal];
        [_passwordRemenberCheckbox setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"记住密码点击_03" ofType:@"png" inDirectory:@""]] forState:UIControlStateSelected];
    }
    return _passwordRemenberCheckbox;
}
-(UIButton *)loginButton
{
    if (_loginButton == nil) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"登录_03" ofType:@"png" inDirectory:@""]] forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(superLogin) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}
#pragma mark------method
-(void)checkboxClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
}
-(void)superLogin
{                RootViewController *RootVC = [RootViewController new];
    [UIApplication sharedApplication].delegate.window.rootViewController = RootVC;

    
}
-(void)loginButtonTaped

{
    static NSInteger inputTime = 3;
    
    NSString *plistPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    plistPath = [plistPath stringByAppendingString:@"/savedPassword.plist"];
    if (self.passwordRemenberCheckbox.selected == YES) {
        NSMutableArray *passwordArray = [NSMutableArray arrayWithArray:[NSArray arrayWithContentsOfFile:plistPath]];
        NSMutableDictionary * dic = @{}.mutableCopy;
        [dic setObject:self.accountTextField.text forKey:@"username"];
        [dic setObject:[XStringUtils md5HexDigestWithString:self.passwordTextField.text] forKey:@"password"];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic];
        [passwordArray addObject:data];
        [passwordArray writeToFile:plistPath atomically:YES];
    }else {
        NSMutableArray *passwordArray = [NSArray arrayWithContentsOfFile:plistPath].mutableCopy;
        for (NSData * data in passwordArray) {
            NSDictionary * dic =  [NSKeyedUnarchiver unarchiveObjectWithData:data];
            if ([dic[@"username"] isEqualToString:self.accountTextField.text]) {
                [passwordArray removeObject:data];
                [passwordArray writeToFile:plistPath atomically:YES];
            }
        }
        
    }
    
    if (self.passwordMD5String == nil) {
        self.passwordMD5String = [XStringUtils md5HexDigestWithString:self.passwordTextField.text];
    }
    
    [NetRequest userLoginWithUsername:self.accountTextField.text password:self.passwordMD5String completion:^(id responseObject, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }else{
//            NSLog(@"%@",responseObject);
            if ([responseObject[@"resultCode"] isEqualToString:@"0"]) {
                
                RootViewController *RootVC = [RootViewController new];
                [UIApplication sharedApplication].delegate.window.rootViewController = RootVC;
            }else if ([responseObject[@"resultCode"] isEqualToString:@"110"]){
                if (inputTime > 0) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"账号或密码错误!" message:[NSString stringWithFormat:@"剩余%ld次机会",inputTime] preferredStyle:UIAlertControllerStyleAlert];
                    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }]];
                    [self presentViewController:alert animated:YES completion:^{
                        
                    }];
                    
                    inputTime --;
                    
                }else{
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"账号锁定" message:[NSString stringWithFormat:@"请联系管理员"] preferredStyle:UIAlertControllerStyleAlert];
                    [self presentViewController:alert animated:YES completion:nil];
                    
                    
                }
            }
            
        }
    }];
    
}
- (BOOL)textFieldShouldBeginEditing:( UITextField *)textField
{
    
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:( UITextField *)textField
{
    if (textField.tag == 201) {
        NSString *plistPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        plistPath = [plistPath stringByAppendingString:@"/savedPassword.plist"];
        NSMutableArray *passwordArray = [NSArray arrayWithContentsOfFile:plistPath].mutableCopy;
        for (NSData * data in passwordArray) {
            NSDictionary * dic =  [NSKeyedUnarchiver unarchiveObjectWithData:data];
            if ([dic[@"username"] isEqualToString:self.accountTextField.text]) {
                self.passwordMD5String = dic[@"password"];
                self.passwordTextField.text = @"*******";
            }
        }
        
    }
    
    if (textField.tag == 202) {
        
        
    }
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string   // return NO to not change text
{
    self.passwordMD5String = nil;
    return YES;
}
-(void)logout
{
    [UIApplication sharedApplication].delegate.window.rootViewController = [LoginViewController new];
    
}




@end
