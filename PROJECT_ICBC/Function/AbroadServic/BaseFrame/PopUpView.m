//
//  PopUpView.m
//  PROJECT_ICBC
//
//  Created by xionghuaxin on 7/23/16.
//  Copyright © 2016 xionghuanxin. All rights reserved.
//

#import "PopUpView.h"
@interface PopUpView ()<UITextFieldDelegate>
@property (nonatomic, strong) NSMutableArray *MASConstraints;
@property(nonatomic,strong)UIView *backgroudShadowView;
@property(nonatomic,strong)UIButton *cancelButton;
@property(nonatomic,strong)UIImageView *buyingWindowView;

//@property (nonatomic, strong) PopUpView * showingView;

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

-(void)popupSelf
{
    
    [self.cancelButton addTarget:self action:@selector(disapper) forControlEvents:UIControlEventTouchUpInside];
    [self layoutIfNeeded];
    self.contentView.transform =CGAffineTransformMakeScale(0.5 , 0.5 );
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.backgroudShadowView.alpha = 0.5;
        self.contentView.transform =CGAffineTransformMakeScale(1 , 1);
    } completion:nil];
}

-(void)popupBuyingWindow
{
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self.buyingWindowView];
    [self.buyingWindowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(self);
    }];
    
    
}
-(void)disapper
{
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.backgroudShadowView.alpha = 0;
        self.contentView.transform =CGAffineTransformMakeScale(0.5 , 0.5 );
        
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
}


-(void)setupUI
{
    [self addSubview:self.backgroudShadowView];
    [self addSubview:self.contentView];
    UIEdgeInsets insets =  UIEdgeInsetsMake(147/2 , 176/2, 147/2, 176/2);
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        [self.MASConstraints addObject:make.edges.mas_equalTo(self.backgroudShadowView).insets(insets)];
        
    }];
    [self.contentView addSubview:self.cancelButton];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(self.contentView).offset(10);
        make.size.mas_offset(CGSizeMake(CGImageGetWidth(self.cancelButton.currentImage.CGImage)/2, CGImageGetHeight(self.cancelButton.currentImage.CGImage)/2));
    }];
}

-(void)addLabelInView:(PopUpView *)aView
          withContent:(NSString *)string
{
    UILabel * mealIntroduceLabel = [[UILabel alloc]init];
    mealIntroduceLabel.numberOfLines = 0;
    mealIntroduceLabel.text = string;
    [aView.contentView addSubview:mealIntroduceLabel];
    [mealIntroduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(aView.mas_top).offset(190);
        make.left.equalTo(aView.mas_left).offset(120);
    }];
}

//-(void)addSaveButtonWithButtonHandel:(void(^)())buttonHandel
//{
//    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"保存选购_06" ofType:@"png" inDirectory:@""]] forState:UIControlStateNormal];
//    [button addTarget:self action:buttonHandel() forControlEvents:UIControlStateNormal];
//    buttonHandel();
//}
-(void)addSaveButtonWithTarget:(id)target
                        Action:(SEL)action
                        inView:(PopUpView *)aView
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"保存选购_06" ofType:@"png" inDirectory:@""]] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [aView.contentView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(aView).offset(-154);
        make.right.mas_equalTo(aView.mas_centerX).offset(-35);
        make.size.mas_equalTo(CGSizeMake(CGImageGetWidth(button.currentImage.CGImage)/2, CGImageGetHeight(button.currentImage.CGImage)/2));
    }];
}
-(void)addDealButtonWithTarget:(id)target
                        Action:(SEL)action
                        inView:(PopUpView *)aView
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"提交办理" ofType:@"png" inDirectory:@""]] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [aView.contentView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(aView).offset(-154);
        make.left.mas_equalTo(aView.mas_centerX).offset(35);
        make.size.mas_equalTo(CGSizeMake(CGImageGetWidth(button.currentImage.CGImage)/2, CGImageGetHeight(button.currentImage.CGImage)/2));
    }];
}
-(void)buyingWindowViewDisapper
{
    [self.buyingWindowView removeFromSuperview];
}
#pragma mark------setter
-(void)setTitle:(NSString *)title
{
    _title = title;
    UILabel *aLabel = [[UILabel alloc]init];
    aLabel.text = title;
    aLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:aLabel];
    [aLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.contentView).offset(40);
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
-(UIView *)contentView
{
    if (_contentView== nil) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.alpha = 1;
    }
    return _contentView;
}
-(UIButton *)cancelButton
{
    if (_cancelButton == nil) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"close_07" ofType:@"png" inDirectory:@""]] forState:UIControlStateNormal];
    }
    return _cancelButton;
}
-(UIImageView *)buyingWindowView
{
    if (_buyingWindowView == nil) {
        _buyingWindowView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _buyingWindowView.userInteractionEnabled = YES;
        _buyingWindowView.layer.shadowOffset = CGSizeMake(30, 30);
        _buyingWindowView.layer.shadowColor = [UIColor blackColor].CGColor;//阴影颜色
        _buyingWindowView.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
        _buyingWindowView.layer.shadowOpacity = 0.5;//不透明度
        _buyingWindowView.layer.shadowRadius = 10.0;//半径

        UIView *coverView = [[UIView alloc]initWithFrame:CGRectZero];
        coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
        UIView *contentView = [[UIView alloc]initWithFrame:CGRectZero];
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.layer.borderWidth = 0.1;
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"close_07" ofType:@"png" inDirectory:@""]] forState:UIControlStateNormal];
        UIButton *purchaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [purchaseButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"购买" ofType:@"png" inDirectory:@""]] forState:UIControlStateNormal];
        UITextField *inputTextField = [[UITextField alloc]initWithFrame:CGRectZero];
        inputTextField.delegate = self;
        inputTextField.background = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"写入框_06" ofType:@"png" inDirectory:@""]];
        [_buyingWindowView addSubview:coverView];
        [coverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_buyingWindowView);
            make.size.mas_equalTo([UIScreen mainScreen].bounds.size);
        }];
        [_buyingWindowView addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(_buyingWindowView);
            make.size.mas_equalTo(CGSizeMake(434, 328));
        }];
        [contentView addSubview:cancelButton];
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(contentView).offset(-16);
            make.top.equalTo(contentView).offset(15);
            make.size.mas_offset(CGSizeMake(CGImageGetWidth(cancelButton.currentImage.CGImage)/2, CGImageGetHeight(cancelButton.currentImage.CGImage)/2));
        }];
        [cancelButton addTarget:self action:@selector(buyingWindowViewDisapper) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:purchaseButton];
        [purchaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(contentView);
            make.bottom.equalTo(contentView).offset(-50);
            make.size.mas_offset(CGSizeMake(CGImageGetWidth(purchaseButton.currentImage.CGImage)/2, CGImageGetHeight(purchaseButton.currentImage.CGImage)/2));
        }];
        [contentView addSubview:inputTextField];
        [inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(contentView).offset(-25);
            make.top.equalTo(contentView).offset(135);
            make.size.mas_offset(CGSizeMake(250, 40));
        }];
    }
    return _buyingWindowView;
}
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    return YES;
//}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
    
}
@end
