//
//  ChooseByYourselfModelCollectionViewCell.m
//  PROJECT_ICBC
//
//  Created by xionghuaxin on 7/26/16.
//  Copyright © 2016 xionghuanxin. All rights reserved.
//

#import "ChooseByYourselfModelCollectionViewCell.h"
@interface ChooseByYourselfModelCollectionViewCell()
@property(nonatomic,strong)UIImageView *backgroudImageView;
@property(nonatomic,strong)UIButton *detailButton;
@property(nonatomic,strong)UIButton *buyingButton;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)UILabel *titleLabel;

@end

@implementation ChooseByYourselfModelCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
#pragma mark---------------method
-(void)setupUI
{
    [self addSubview:self.backgroudImageView];
    [self.backgroudImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsZero);
    }];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(15);
    }];
    [self addSubview:self.detailButton];
    [self.detailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_centerX).offset(-8);
        make.bottom.mas_equalTo(self).offset(-17);
        make.size.mas_equalTo(CGSizeMake(CGImageGetWidth(self.detailButton.currentImage.CGImage)/2, CGImageGetHeight(self.detailButton.currentImage.CGImage)/2));
    }];
    [self addSubview:self.buyingButton];
    [self.buyingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_centerX).offset(8);
        make.bottom.mas_equalTo(self).offset(-17);
        make.size.mas_equalTo(CGSizeMake(CGImageGetWidth(self.buyingButton.currentImage.CGImage)/2, CGImageGetHeight(self.buyingButton.currentImage.CGImage)/2));
    }];

}
-(void)setupValueWithData:(NSDictionary *)data
{
    self.title = data[@"name"];
}
#pragma mark---------------setter
-(void)setTitle:(NSString *)title
{
    _title =title;
    self.titleLabel.text = title;
}

#pragma mark---------------getter
-(UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
-(UIImageView *)backgroudImageView
{
    if (_backgroudImageView == nil) {
        _backgroudImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _backgroudImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"未标题-1_01" ofType:@"png" inDirectory:@""]];
    }
    return _backgroudImageView;
}
-(UIButton *)detailButton
{
    if (_detailButton == nil) {
        _detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_detailButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"详情_01" ofType:@"png" inDirectory:@""]] forState:UIControlStateNormal];
    }
    return _detailButton;
}
-(UIButton *)buyingButton
{
    if (_buyingButton == nil) {
        _buyingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buyingButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"选购_03" ofType:@"png" inDirectory:@""]] forState:UIControlStateNormal];

    }
    return _buyingButton;
}
@end
