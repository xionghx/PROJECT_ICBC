//
//  LoginViewController.m
//  PROJECT_ICBC
//
//  Created by xionghuaxin on 7/21/16.
//  Copyright © 2016 xionghuanxin. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "MainViewController.h"
#import "NetRequest.h"
@interface LoginViewController ()
@property(nonatomic,strong)UIImageView *backgroudImageView;
@property(nonatomic,strong)UIImageView *loginView;
@property(nonatomic,strong)UITextField *accountTextField;
@property(nonatomic,strong)UITextField *passwordTextField;
@property(nonatomic,strong)UIButton *passwordRemenberCheckbox;
@property(nonatomic,strong)UIButton *loginButton;


@end

@implementation LoginViewController
-(void)viewDidAppear:(BOOL)animated
{
    [UIView animateWithDuration:1 animations:^{
        self.loginView.center = self.view.center;
//        [self.loginView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.center.equalTo(self.view);
//        }];
    } completion:^(BOOL finished) {
        
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
        make.size.mas_equalTo(CGSizeMake(566, 804));
        make.centerY.mas_equalTo(1536);
    }];
    [self.loginView addSubview:self.accountTextField];
    [self.accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(180, 50, 540, 50));

    }];
    [self.loginView addSubview:self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.accountTextField);
        make.size.mas_equalTo(self.accountTextField);
        make.top.mas_equalTo(self.accountTextField.mas_bottom).offset(110);
    }];
    [self.loginView addSubview:self.passwordRemenberCheckbox];
    [self.passwordRemenberCheckbox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.accountTextField);
        make.top.mas_equalTo(self.passwordTextField.mas_bottom).offset(55);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [self.loginView addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.passwordTextField);
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(100);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
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
        _accountTextField.backgroundColor = [UIColor blueColor];
    }
    return _accountTextField;
}
-(UITextField *)passwordTextField
{
    if (_passwordTextField == nil) {
        _passwordTextField = [[UITextField alloc]init];
        _passwordTextField.backgroundColor = [UIColor blueColor];
    }
    return _passwordTextField;
}
-(UIButton * )passwordRemenberCheckbox
{
    if (_passwordRemenberCheckbox == nil) {
        _passwordRemenberCheckbox = [UIButton buttonWithType:UIButtonTypeCustom];
        [_passwordRemenberCheckbox addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
        [_passwordRemenberCheckbox setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"记住密码未点击_03" ofType:@"" inDirectory:@""]] forState:UIControlStateNormal];
        [_passwordRemenberCheckbox setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"记住密码点击_03" ofType:@"" inDirectory:@""]] forState:UIControlStateSelected];
        _passwordRemenberCheckbox.backgroundColor = [UIColor redColor];
    }
    return _passwordRemenberCheckbox;
}
-(UIButton *)loginButton
{
    if (_loginButton == nil) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.backgroundColor = [UIColor redColor];
        [_loginButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"登录_03" ofType:@"" inDirectory:@""]] forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(loginButtonTaped) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}
#pragma mark------method
-(void)checkboxClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
}
-(void)loginButtonTaped

{
    UITabBarController * xTC = [[UITabBarController alloc]init];
    xTC.viewControllers = @[[MainViewController new]];
    [UIApplication sharedApplication].delegate.window.rootViewController = [MainViewController new];
}

@end
