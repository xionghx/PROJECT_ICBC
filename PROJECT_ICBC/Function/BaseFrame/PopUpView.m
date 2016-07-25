//
//  PopUpView.m
//  PROJECT_ICBC
//
//  Created by xionghuaxin on 7/23/16.
//  Copyright © 2016 xionghuanxin. All rights reserved.
//

#import "PopUpView.h"
@interface PopUpView ()
@property (nonatomic, strong) NSMutableArray *MASConstraints;
@property (nonatomic, strong) PopUpView * showingView;

@end

@implementation PopUpView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _MASConstraints = [NSMutableArray array];
        [self setupUI];
        
    }
    return self;
}

-(void)popupView
{
    [self.cancelButton addTarget:self action:@selector(disapperView:) forControlEvents:UIControlEventTouchUpInside];

    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self];
    for (MASConstraint * aMasconstraint in self.MASConstraints) {
        [aMasconstraint uninstall];
    }
    [self.backgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(view.backgroudShadowView);
        make.size.mas_equalTo(CGSizeMake(1757/2, 1133/2));
//        make.center.mas_equalTo(CGPointMake(1757/4, 1133/4));
        make.center.mas_equalTo(self.backgroudShadowView);
    }];
    [self setNeedsLayout];


    [UIView animateWithDuration:2 animations:^{
        self.backgroudShadowView.alpha = 0.5;
//        view.backgroundView.bounds = CGRectMake(0, 0, 1757/2, 1133/2);
//        [self.backgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.center.equalTo(self.backgroudShadowView);
////            make.size.mas_equalTo(CGSizeMake(1757/2, 1133/2));
//        }];

        [self layoutIfNeeded];

    } completion:^(BOOL finished) {
        
        
    }];


    
}

-(void)disapperView:(UIView *)view
{
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

}


#pragma mark ------------method
-(void)setupUI
{
    [self addSubview:self.backgroudShadowView];
    [self addSubview:self.backgroundView];
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        [self.MASConstraints addObject:make.size.mas_equalTo(CGSizeMake(100, 100))];
        [self.MASConstraints addObject:make.center.equalTo(self.backgroudShadowView)];

    }];
    [self addSubview:self.cancelButton];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backgroundView).offset(-10);
        make.top.equalTo(self.backgroundView).offset(10);
        make.size.mas_offset(CGSizeMake(45, 28));
    }];
}
#pragma mark------setter
-(void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
    self.title = title;
}
#pragma mark-------getter

-(UIView *)backgroudShadowView
{
    if (_backgroudShadowView == nil) {
        _backgroudShadowView = [[UIView alloc]initWithFrame:self.bounds];
        _backgroudShadowView.backgroundColor = [UIColor blackColor];
        _backgroudShadowView.alpha = 0;
        _backgroudShadowView.userInteractionEnabled = YES;
    }
    return _backgroudShadowView;
}
-(UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
    }
    return _titleLabel;
}
-(UIView *)backgroundView
{
    if (_backgroundView== nil) {
        _backgroundView = [[UIView alloc]init];
        _backgroundView.backgroundColor = [UIColor whiteColor];
        _backgroundView.alpha = 1;
    }
    return _backgroundView;
}
-(UIButton *)cancelButton
{
    if (_cancelButton == nil) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"close_07" ofType:@"png" inDirectory:@""]] forState:UIControlStateNormal];
    }
    return _cancelButton;
}
@end
