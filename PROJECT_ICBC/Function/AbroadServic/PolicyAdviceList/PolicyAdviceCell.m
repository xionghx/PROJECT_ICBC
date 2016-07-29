//
//  PolicyAdviceCell.m
//  PROJECT_ICBC
//
//  Created by xionghuaxin on 7/22/16.
//  Copyright © 2016 xionghuanxin. All rights reserved.
//

#import "PolicyAdviceCell.h"
@interface PolicyAdviceCell ()
@property(nonatomic,strong)UIImageView *backgroundImageView;
@end

@implementation PolicyAdviceCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
#pragma mark-------getter
-(UIImageView *)backgroundImageView
{
    if (_backgroundImageView == nil ) {
        _backgroundImageView = [[UIImageView alloc]init];
        _backgroundImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"excel_23" ofType:@"png" inDirectory:@""]];
        
        
    }
    return _backgroundImageView;
}
#pragma mark---------method
-(void)setupValueWithData:(NSDictionary *)data
{
    self.contentLabel.text = data[@"title"];
}
-(void)setupUI
{
    [self.contentView addSubview:self.backgroundImageView];
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.top.and.right.and.bottom.equalTo(self);
    }];
    [self.contentView addSubview:self.serialNumberLabel];
    [self.serialNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.bottom.equalTo(self);
        make.width.equalTo(@128);
    }];
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self);
        make.left.equalTo(self.serialNumberLabel);
    }];
}
-(UILabel *)serialNumberLabel
{
    if (_serialNumberLabel == nil) {
        _serialNumberLabel = [[UILabel alloc]init];
        _serialNumberLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _serialNumberLabel;
}
-(UILabel *)contentLabel
{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLabel;
}
@end
