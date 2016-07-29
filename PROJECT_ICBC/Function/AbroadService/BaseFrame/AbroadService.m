//
//  AbroadService.m
//  PROJECT_ICBC
//
//  Created by xionghuaxin on 7/21/16.
//  Copyright © 2016 xionghuanxin. All rights reserved.
//

#import "AbroadService.h"
#import "MealsListView.h"
#import "PolicyAdviceView.h"
#import "ChooseByYourselfModelListView.h"



#import "NetRequest.h"

@interface AbroadService ()
@property(nonatomic ,strong)UIView *buttonView;
@property(nonatomic ,strong)UIImageView *buttonShdownView;
@property(nonatomic ,strong)UIButton *  mealsListButton;
@property(nonatomic ,strong)UIButton * policyAdviceButton;
@property(nonatomic ,strong)UIButton * chooseByYourselfModeButton;
@property(nonatomic ,strong)NSMutableArray *buttonArray;
@property(nonatomic ,strong)NSMutableArray *viewsArray;


@property(nonatomic ,strong)UIView *rootView;
@property(nonatomic ,strong)PolicyAdviceView *policyAdviceView;
@property(nonatomic ,strong)MealsListView *mealslistView;
@property(nonatomic ,strong)ChooseByYourselfModelListView *chooseByYourselfModelListView;

@end

@implementation AbroadService

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.buttonArray = @[].mutableCopy;
        self.viewsArray = [NSMutableArray array];
        self.titleLabel.text = @"AbroadService";
        [self loadDataSource];
        [self setupUI];
    }
    return self;
}
#pragma mark ---------getter
-(UIView *)buttonView
{
    if (_buttonView == nil) {
        _buttonView = [[UIView alloc]init];
    }
    return _buttonView;
}
-(UIImageView *)buttonShdownView
{
    if (_buttonShdownView == nil) {
        _buttonShdownView = [[UIImageView alloc]init];
        _buttonShdownView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"shadow_08" ofType:@"png" inDirectory:@""]];
    }
    return _buttonShdownView;
}
-(UIButton *)mealsListButton
{
    if (_mealsListButton == nil) {
        _mealsListButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_mealsListButton addTarget:self action:@selector(buttonTaped:) forControlEvents:UIControlEventTouchUpInside];
        [_mealsListButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"b_08" ofType:@"png" inDirectory:@""]] forState:UIControlStateNormal];
        [_mealsListButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bb_08" ofType:@"png" inDirectory:@""]] forState:UIControlStateDisabled];
    }
    return _mealsListButton;
}
-(UIButton *)policyAdviceButton
{
    if (_policyAdviceButton == nil) {
        _policyAdviceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _policyAdviceButton.enabled = NO;
        [_policyAdviceButton addTarget:self action:@selector(buttonTaped:) forControlEvents:UIControlEventTouchUpInside];

        [_policyAdviceButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"a_07" ofType:@"png" inDirectory:@""]] forState:UIControlStateNormal];
        [_policyAdviceButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"aa_07" ofType:@"png" inDirectory:@""]] forState:UIControlStateDisabled];

    }
    return _policyAdviceButton;
}
-(UIButton *)chooseByYourselfModeButton
{
    if (_chooseByYourselfModeButton == nil) {
        _chooseByYourselfModeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_chooseByYourselfModeButton addTarget:self action:@selector(buttonTaped:) forControlEvents:UIControlEventTouchUpInside];
        [_chooseByYourselfModeButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"c_09" ofType:@"png" inDirectory:@""]] forState:UIControlStateNormal];
        [_chooseByYourselfModeButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cc_09" ofType:@"png" inDirectory:@""]] forState:UIControlStateDisabled];

    }
    return _chooseByYourselfModeButton;
}
-(UIView *)rootView
{
    if (_rootView == nil) {
        _rootView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return  _rootView;
}

-(PolicyAdviceView *)policyAdviceView
{
    if (_policyAdviceView == nil) {
        _policyAdviceView = [[PolicyAdviceView alloc]initWithFrame:CGRectZero];

    }
    return _policyAdviceView;
}

-(MealsListView *)mealslistView
{
    if (_mealslistView == nil) {
        _mealslistView = [[MealsListView alloc]initWithFrame:CGRectZero];
    }
    return _mealslistView;
}
-(ChooseByYourselfModelListView *)chooseByYourselfModelListView
{
    if (_chooseByYourselfModelListView == nil) {
        _chooseByYourselfModelListView = [[ChooseByYourselfModelListView alloc]initWithFrame:CGRectZero];
        _chooseByYourselfModelListView.backgroundColor = [UIColor grayColor];

    }
    return _chooseByYourselfModelListView;
}

#pragma mark ------------method
-(void)setupUI
{
    [self addSubview:self.rootView];
    [self.rootView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));

    }];
    [self.rootView addSubview:self.policyAdviceView];
    [self.policyAdviceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self addSubview:self.buttonView];
    [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(26);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(118 *3, 42));
    }];
    [self.buttonView addSubview:self.buttonShdownView];
    [self.buttonShdownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.buttonView.mas_bottom);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(368, 16));

    }];
    [self.buttonView addSubview:self.mealsListButton];
    [self.buttonArray addObject:self.mealsListButton];
    [self.mealsListButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.buttonView);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(118, 42));
    }];
    [self.buttonView addSubview:self.policyAdviceButton];
    [self.buttonArray addObject:self.policyAdviceButton];
    [self.policyAdviceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mealsListButton);
        make.size.equalTo(self.mealsListButton);
        make.right.equalTo(self.mealsListButton.mas_left);
    }];
    [self.buttonView addSubview:self.chooseByYourselfModeButton];
    [self.buttonArray addObject:self.chooseByYourselfModeButton];
    [self.chooseByYourselfModeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mealsListButton);
        make.size.equalTo(self.mealsListButton);
        make.left.equalTo(self.mealsListButton.mas_right);
    }];
    
    [self.viewsArray addObject:self.mealslistView];
    [self.viewsArray addObject:self.policyAdviceView];
    [self.viewsArray addObject:self.chooseByYourselfModelListView];
    for (UIButton *button in self.buttonArray) {
        button.adjustsImageWhenHighlighted=NO;
    }
}
-(void)buttonTaped:(UIButton *)sender
{
    NSInteger index  = 0;
    for (UIButton *aButton in self.buttonArray) {
        if (aButton == sender) {
            aButton.enabled = NO;
            [self.rootView addSubview:self.viewsArray[index]];
            [self.viewsArray[index] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
            }];

        }else{
            aButton.enabled = YES;
            [self.viewsArray[index] removeFromSuperview];
        }
        index ++;
    }
}

-(void)loadDataSource
{
}
@end
