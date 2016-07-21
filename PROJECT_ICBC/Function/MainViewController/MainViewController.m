//
//  MainViewController.m
//  PROJECT_ICBC
//
//  Created by xionghuaxin on 7/21/16.
//  Copyright © 2016 xionghuanxin. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property(nonatomic,strong)UIImageView *backgroudImageView;
@property(nonatomic,strong)UIImageView *navigationBackgroudView;
@property(nonatomic,strong)UIImageView *headerView;
@property(nonatomic,strong)UIImageView *headerShadowView;
@property(nonatomic,strong)NSMutableArray *buttonArray;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.buttonArray = @[].mutableCopy;
    [self setupUI];
    self.view.backgroundColor = [UIColor greenColor];
    
}

#pragma mark----getter
-(UIImageView *)backgroudImageView
{
    if (_backgroudImageView == nil) {
        _backgroudImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
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
    }
    return _headerView;
}
-(UIImageView *)headerShadowView
{
    if (_headerShadowView == nil) {
        _headerShadowView = [[UIImageView alloc]init];
        _headerShadowView.image =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"眉头阴影_04" ofType:@"png" inDirectory:@""]];
    }
    return _headerShadowView;
}
#pragma mark --method
-(void)setupUI
{
    [self.view addSubview:self.backgroudImageView];
    
    [self.view addSubview:self.navigationBackgroudView];
    [self.navigationBackgroudView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backgroudImageView);
        make.top.equalTo(self.backgroudImageView);
        make.bottom.equalTo(self.backgroudImageView);
        make.width.equalTo(@81.5);
    }];
    [self.view addSubview:self.headerShadowView];
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backgroudImageView);
        make.top.equalTo(self.backgroudImageView);
        make.right.equalTo(self.backgroudImageView);
        make.height.equalTo(@80);
    }];
    [self.headerShadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView);
        make.centerY.equalTo(self.headerView.mas_bottom);
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
        [aButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:buttonImageName_H[index] ofType:@"png" inDirectory:@""]] forState:UIControlStateSelected];
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
    }
}

-(void)buttonTaped:(UIButton *)sender
{
    for (UIButton *aButton in self.buttonArray) {
        if (aButton.tag == sender.tag) {
            aButton.selected = YES;
        }else{
            aButton.selected = NO;
        }
    }
}
@end
