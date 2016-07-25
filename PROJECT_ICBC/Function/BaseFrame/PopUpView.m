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

#pragma mark ------------method

-(void)popup
{
    
    [self.cancelButton addTarget:self action:@selector(disapper) forControlEvents:UIControlEventTouchUpInside];
    [self layoutIfNeeded];
    UIEdgeInsets insets =  UIEdgeInsetsMake(147/2 , 176/2, 147/2, 176/2);
    
    for (MASConstraint * aMasconstraint in self.MASConstraints) {
        aMasconstraint.insets = insets;
    }
    [self setNeedsLayout];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.backgroudShadowView.alpha = 0.5;
        [self layoutIfNeeded];
        
    } completion:nil];
}


-(void)disapper
{
    [self layoutIfNeeded];
    UIEdgeInsets insets = UIEdgeInsetsMake(0.5 * self.frame.size.height-100, 0.5 * self.frame.size.width-100, 0.5 * self.frame.size.height-100, 0.5 * self.frame.size.width-100);
    for (MASConstraint * aMasconstraint in self.MASConstraints) {
        aMasconstraint.insets = insets;
    }
    [self setNeedsLayout];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.backgroudShadowView.alpha = 0;
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
}


-(void)setupUI
{
    [self addSubview:self.backgroudShadowView];
    [self addSubview:self.backgroundView];
    UIEdgeInsets insets = UIEdgeInsetsMake(0.5 * self.frame.size.height-100, 0.5 * self.frame.size.width-100, 0.5 * self.frame.size.height-100, 0.5 * self.frame.size.width-100);
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        [self.MASConstraints addObject:make.edges.mas_equalTo(self.backgroudShadowView).insets(insets)];
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
    
    
    _title = title;
    UILabel *aLabel = [[UILabel alloc]init];
    aLabel.text = title;
    aLabel.textColor = [UIColor blackColor];
    [self addSubview:aLabel];
    [aLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.backgroundView).offset(40);
    }];
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
