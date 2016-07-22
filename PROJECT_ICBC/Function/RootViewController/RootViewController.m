//
//  RootViewController.m
//  PROJECT_ICBC
//
//  Created by xionghuaxin on 7/21/16.
//  Copyright © 2016 xionghuanxin. All rights reserved.
//

#import "RootViewController.h"
#import "MainPage.h"
#import "AboroadService.h"
#import "FinanceProducts.h"
#import "PickedList.h"
#import "ServiceProgress.h"
#import "LoginViewController.h"


@interface RootViewController ()
@property(nonatomic,strong)UIImageView *backgroudImageView;
@property(nonatomic,strong)UIImageView *navigationBackgroudView;
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UIImageView *headerView;
@property(nonatomic,strong)UIImageView *headerShadowView;
@property(nonatomic,strong)NSMutableArray *buttonArray;
@property(nonatomic,strong)NSMutableArray *viewArray;
@property(nonatomic,strong)UIButton *currentSelectedButton;
@property(nonatomic,strong)UIView *currentShowView;
@property(nonatomic,strong)UIButton *logoutButton;


@property(nonatomic,strong)UIView *measureView;
@property(nonatomic,strong)MainPage *mainPage;
@property(nonatomic,strong)AboroadService *aboroadServce;
@property(nonatomic,strong)FinanceProducts *financeProducts;
@property(nonatomic,strong)PickedList *pickedList;
@property(nonatomic,strong)ServiceProgress *serviceProgress;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.buttonArray = @[].mutableCopy;
    self.viewArray = @[].mutableCopy;
    [self setupUI];
    
}

#pragma mark----getter
-(UIImageView *)backgroudImageView
{
    if (_backgroudImageView == nil) {
        _backgroudImageView = [[UIImageView alloc]init];
        _backgroudImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"大背景" ofType:@"png" inDirectory:@""]];
    }
    return _backgroudImageView;
}
-(UIImageView *)navigationBackgroudView
{
    if (_navigationBackgroudView == nil) {
        _navigationBackgroudView =[[UIImageView alloc]init];
        _navigationBackgroudView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"导航-底_03" ofType:@"png" inDirectory:@""]];
    }
    return _navigationBackgroudView;
}
-(UIImageView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[UIImageView alloc]init];
        _headerView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"眉头_01" ofType:@"png" inDirectory:@""]];
        _headerView.userInteractionEnabled = YES;
    }
    return _headerView;
}
-(UIImageView *)headImage
{
    if (_headImage == nil) {
        _headImage = [[UIImageView alloc]init];
        _headImage.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"头像_11" ofType:@"png" inDirectory:@""]];

    }
    return _headImage;
}
-(UIButton *)logoutButton
{
    if (_logoutButton == nil) {
        _logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_logoutButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"关闭_05" ofType:@"png" inDirectory:@""]] forState:UIControlStateNormal];
        [_logoutButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutButton;
}
-(UIImageView *)headerShadowView
{
    if (_headerShadowView == nil) {
        _headerShadowView = [[UIImageView alloc]init];
        _headerShadowView.image =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"眉头阴影_04" ofType:@"png" inDirectory:@""]];
    }
    return _headerShadowView;
}
-(MainPage *)mainPage
{
    if (_mainPage == nil) {
        _mainPage = [[MainPage alloc]init];
        _mainPage.tag = 300;
    }
    return _mainPage;
}
-(AboroadService *)aboroadServce
{
    if (_aboroadServce == nil) {
        _aboroadServce = [[AboroadService alloc]init];
        _aboroadServce.tag =301;
    }
    return _aboroadServce;
}
-(FinanceProducts *)financeProducts
{
    if (_financeProducts == nil) {
        _financeProducts = [[FinanceProducts alloc]init];
        _financeProducts.tag = 302;
    }
    return _financeProducts;
}
-(PickedList *)pickedList
{
    if (_pickedList == nil) {
        _pickedList = [[PickedList alloc]init];
        _pickedList.tag = 303;
    }
    return _pickedList;
}
-(ServiceProgress *)serviceProgress
{
    if (_serviceProgress == nil) {
        _serviceProgress = [[ServiceProgress alloc]init];
        _serviceProgress.tag = 304;
    }
    return _serviceProgress;
}
-(UIView *)measureView
{
    if (_measureView == nil) {
        _measureView = [[UIView alloc]init];
        _measureView.backgroundColor = [UIColor whiteColor];
    }
    return _measureView;
}
#pragma mark --method
-(void)setupUI
{
    [self.view addSubview:self.backgroudImageView];
    [self.backgroudImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.view addSubview:self.navigationBackgroudView];
    [self.navigationBackgroudView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backgroudImageView);
        make.top.equalTo(self.backgroudImageView);
        make.bottom.equalTo(self.backgroudImageView);
        make.width.equalTo(@81.5);
    }];
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backgroudImageView);
        make.top.equalTo(self.backgroudImageView);
        make.right.equalTo(self.backgroudImageView);
        make.height.equalTo(@80);
    }];
    [self.headerView addSubview:self.headImage];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView).offset(10);
        make.left.equalTo(self.headerView).offset(20);
        make.width.and.height.offset(55);
    }];
    [self.headerView addSubview:self.logoutButton];
    [self.logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headImage.mas_right).offset(-5);
        make.centerY.equalTo(self.headImage.mas_top).offset(5);
        make.width.and.height.offset(27);
    }];
    [self.view addSubview:self.headerShadowView];
    [self.headerShadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView);
        make.top.equalTo(self.headerView.mas_bottom);
        make.width.equalTo(self.headerView);
        make.height.offset(13);
    }];
    NSArray *buttonImageName = @[@"首页_03",@"出国服务_05",@"财富产品_07",@"选购清单_09",@"服务进度_11"];
    NSArray *buttonImageName_H = @[@"首页_03_h",@"出国服务_05_h",@"财富产品_07_h",@"选购清单_09_h",@"服务进度_11_h"];
    [self.buttonArray removeAllObjects];
    for (NSInteger index = 0; index < 5; index ++) {
        UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [aButton addTarget:self action:@selector(buttonTaped:) forControlEvents:UIControlEventTouchUpInside];
        [aButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:buttonImageName[index] ofType:@"png" inDirectory:@""]] forState:UIControlStateNormal];
        [aButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:buttonImageName_H[index] ofType:@"png" inDirectory:@""]] forState:UIControlStateDisabled];
        aButton.tag = 200 + index;
        [self.view addSubview:aButton];
        [self.buttonArray addObject:aButton];
        if (index == 0) {
            [aButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.headerView.mas_bottom);
                make.left.equalTo(self.view);
                make.width.equalTo(@88);
                make.height.equalTo(@106);
            }];
        }else{
            [aButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo([self.view viewWithTag:200 + index -1].mas_bottom);
                make.left.equalTo(self.view);
                make.width.equalTo(@88);
                make.height.equalTo(@106);
            }];
        }
        self.currentSelectedButton = self.buttonArray[0];
        ((UIButton*)self.buttonArray[0]).enabled = NO;
        
        [self.view addSubview:self.mainPage];
        [self.mainPage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.navigationBackgroudView.mas_right);
            make.top.equalTo(self.headerView.mas_bottom);
            make.right.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }];
        
        
        [self.view addSubview: self.measureView];
        [self.measureView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self.mainPage);
            make.bottom.equalTo(self.mainPage);
            make.height.equalTo(self.mainPage);
        }];
        
        [self.view addSubview:self.aboroadServce];
        [self.aboroadServce mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self.mainPage);
            make.bottom.equalTo(self.mainPage.mas_top);
            make.height.equalTo(self.mainPage);
        }];
        
        [self.view addSubview:self.financeProducts];
        [self.financeProducts mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self.mainPage);
            make.bottom.equalTo(self.mainPage.mas_top);
            make.height.equalTo(self.mainPage);
        }];
        
        [self.view addSubview:self.pickedList];
        [self.pickedList mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self.mainPage);
            make.bottom.equalTo(self.mainPage.mas_top);
            make.height.equalTo(self.mainPage);
        }];
        
        [self.view addSubview:self.serviceProgress];
        [self.serviceProgress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self.mainPage);
            make.bottom.equalTo(self.mainPage.mas_top);
            make.height.equalTo(self.mainPage);
        }];
        [self.view bringSubviewToFront:self.headerShadowView];
        [self.view bringSubviewToFront:self.headerView];

        for (UIButton * abutton in self.buttonArray) {
            [self.view bringSubviewToFront:abutton];
        }

        self.currentShowView = self.mainPage;
        [self.viewArray addObject:self.mainPage];
        [self.viewArray addObject:self.aboroadServce];
        [self.viewArray addObject:self.financeProducts];
        [self.viewArray addObject:self.pickedList];
        [self.viewArray addObject:self.serviceProgress];
        
    }
}

-(void)buttonTaped:(UIButton *)sender
{
    for (UIButton *aButton in self.buttonArray) {
        if (aButton.tag == sender.tag) {
            aButton.enabled = NO;
        }else{
            aButton.enabled = YES;
        }
    }
    
    
    [self viewAnimationWithWillShowViw:self.viewArray[sender.tag-200] andWillDisappearView:self.currentShowView];
    self.currentSelectedButton = sender;
    
}


-(void)viewAnimationWithWillShowViw:(UIView *)willShowView
               andWillDisappearView:(UIView*)willDisapperView
{
    if (willShowView.tag>willDisapperView.tag) {
        
        willShowView.center = CGPointMake(willDisapperView.center.x, willDisapperView.center.y + willDisapperView.frame.size.height);
        [UIView animateWithDuration:0.3 animations:^{
            willShowView.center = willDisapperView.center;
            willDisapperView.center = CGPointMake(willDisapperView.center.x, willDisapperView.center.y-willDisapperView.frame.size.height);
        }];
    }else{
        willShowView.center = CGPointMake(willDisapperView.center.x, willDisapperView.center.y -willDisapperView.frame.size.height);
        [UIView animateWithDuration:0.3 animations:^{
            willShowView.center = willDisapperView.center;
            willDisapperView.center = CGPointMake(willDisapperView.center.x, willDisapperView.center.y+willDisapperView.frame.size.height);
        }];
    }
    self.currentShowView = willShowView;
}

-(void)logout
{
    [self presentViewController:[LoginViewController new] animated:YES completion:^{
        
    }];
}
@end
