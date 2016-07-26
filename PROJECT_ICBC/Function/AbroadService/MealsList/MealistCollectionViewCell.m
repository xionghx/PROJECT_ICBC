//
//  MealistCollectionViewCell.m
//  PROJECT_ICBC
//
//  Created by xionghuaxin on 7/25/16.
//  Copyright © 2016 xionghuanxin. All rights reserved.
//

#import "MealistCollectionViewCell.h"
@interface MealistCollectionViewCell ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic ,strong)UIButton * detailButton;
@property(nonatomic ,strong)UIImageView * backgroudImageView;
@property(nonatomic ,strong)NSString *title;
@property(nonatomic ,strong)UILabel *titleLabel;

@property(nonatomic ,strong)UITableView *mealTableView;
@property(nonatomic ,strong)NSMutableArray *dataSource;

@end


@implementation MealistCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = [NSMutableArray array];
        
        [self setupUI];
        
    }
    return self;
}
#pragma mark----------method
-(void)setupUI
{
    [self addSubview:self.backgroudImageView];
    [self.backgroudImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(-20, -20, -20, -20));
    }];
    [self addSubview:self.detailButton];
    [self.detailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self).offset(-30);
        make.size.mas_equalTo(CGSizeMake(158, 73));
    }];
    [self addSubview:self.mealTableView];
    [self.mealTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self);
        make.top.equalTo(self).offset(100);
        make.bottom.equalTo(self.detailButton.mas_top);
    }];
}
-(void)setupValueWith:(NSDictionary *)data
{
    self.title = data[@"name"];
    [self.dataSource removeAllObjects];
    [self.dataSource addObject:@{@"name":@"推荐以下服务:"}];
    [self.dataSource addObjectsFromArray:data[@"summaryFs"]];
    [self.mealTableView reloadData];
}

#pragma mark----------setter
-(void)setTitle:(NSString *)title
{
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.left.equalTo(self);
        make.right.equalTo(self);
    }];
    self.titleLabel.text = title;
    _title = title;
}
#pragma mark ---------getter
-(UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:24];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}
-(UIButton *)detailButton
{
    if (_detailButton == nil) {
        _detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_detailButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"未选中_23" ofType:@"png" inDirectory:@""]] forState:UIControlStateNormal];
        [_detailButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"选中_23" ofType:@"png" inDirectory:@""]] forState:UIControlStateSelected];
    }
    return _detailButton;
}
-(UITableView *)mealTableView
{
    if (_mealTableView == nil) {
        _mealTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _mealTableView.backgroundColor = [UIColor clearColor];
        _mealTableView.delegate = self;
        _mealTableView.dataSource = self;
        _mealTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _mealTableView;
}
-(UIImageView *)backgroudImageView
{
    if (_backgroudImageView == nil) {
        _backgroudImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _backgroudImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"prepare1_01" ofType:@"png" inDirectory:@""]];
    }
    return _backgroudImageView;
}
#pragma mark----------------<UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * REUSE_MARK  = @"mealTableViewCellReuse";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSE_MARK];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REUSE_MARK];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = self.dataSource[indexPath.row][@"name"];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


@end
