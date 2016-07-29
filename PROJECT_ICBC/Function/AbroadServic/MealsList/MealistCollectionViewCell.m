//
//  MealistCollectionViewCell.m
//  PROJECT_ICBC
//
//  Created by xionghuaxin on 7/25/16.
//  Copyright © 2016 xionghuanxin. All rights reserved.
//

#import "MealistCollectionViewCell.h"
#import "PopUpView.h"
@interface MealistCollectionViewCell ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic ,strong)UIButton * detailButton;
@property(nonatomic ,strong)UIImageView * backgroudImageView;
@property(nonatomic ,strong)NSString *title;
@property(nonatomic ,strong)UILabel *titleLabel;

@property(nonatomic ,strong)UITableView *mealTableView;
@property(nonatomic ,strong)NSDictionary *dataSource;
@property(nonatomic ,strong)PopUpView *popUpVIew;

@end


@implementation MealistCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = [NSDictionary dictionary];
        
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
    self.dataSource = data;
    [self.mealTableView reloadData];
}
-(void)detailButtonTaped
{
//    PopUpView *aView = [[PopUpView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    aView.title = _dataSource[@"name"];
    
    self.popUpVIew.title = self.dataSource[@"name"];
    NSMutableString *string = [NSMutableString string];
    [string appendString:[NSString stringWithFormat:@"%@\n\n",self.dataSource[@"name"]]];
    [string appendString:@"推荐业务\n\n"];
    NSInteger index = 1;
    for (NSDictionary * dic in self.dataSource[@"summaryFs"]) {
        [string appendString:[NSString stringWithFormat:@"%ld、%@\n\n",index,dic[@"info"]]];
        index ++;
    }
    [self.popUpVIew addLabelInView:self.popUpVIew withContent:string];
    [self.popUpVIew addSaveButtonWithTarget:self Action:@selector(saveButtonTaped) inView:self.popUpVIew];
    [self.popUpVIew addDealButtonWithTarget:self Action:@selector(dealButtonTaped) inView:self.popUpVIew];
    [self.popUpVIew popupSelf];
}
-(void)saveButtonTaped
{
    [self.popUpVIew popupBuyingWindow];
}
-(void)dealButtonTaped
{
    
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
        [_detailButton addTarget:self action:@selector(detailButtonTaped) forControlEvents:UIControlEventTouchUpInside];
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
-(PopUpView *)popUpVIew
{
    if (_popUpVIew == nil) {
        _popUpVIew =[[PopUpView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _popUpVIew;
}
#pragma mark----------------<UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource[@"summaryFs"] count] + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * REUSE_MARK  = @"mealTableViewCellReuse";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSE_MARK];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REUSE_MARK];
    }
    if (indexPath.row != 0) {
        cell.textLabel.text = self.dataSource[@"summaryFs"][indexPath.row-1][@"name"];

    }else{
        cell.textLabel.text = @"推荐以下服务:";

    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


@end
