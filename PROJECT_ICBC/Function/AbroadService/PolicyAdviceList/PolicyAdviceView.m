//
//  PolicyAdviceView.m
//  PROJECT_ICBC
//
//  Created by xionghuaxin on 7/22/16.
//  Copyright © 2016 xionghuanxin. All rights reserved.
//

#import "PolicyAdviceView.h"
#import "policyAdviceCell.h"
#import "NetRequest.h"
#import "PopUpView.h"

#define REUSE_MARK  @"cell_reuse"

@interface PolicyAdviceView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic ,strong)UITableView *policyAdviceListTableView;
@property(nonatomic ,strong)UIImageView *policyAdviceListTableUpShadowView;
@property(nonatomic ,strong)UIImageView *policyAdviceListTableDownShadowView;
@property(nonatomic ,strong)NSMutableArray *dataSource;

@end

@implementation PolicyAdviceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = @[].mutableCopy;
        [self loadDataSource];
        [self setupUI];
        self.clipsToBounds = YES;
 
    }
    return self;
}


#pragma mark----------getter
-(UITableView *)policyAdviceListTableView
{
    if (_policyAdviceListTableView == nil) {
//        _policyAdviceListTableView = [[UITableView alloc]initWithFrame:CGRectMake(100,100 ,800, 400) style:UITableViewStylePlain];
        _policyAdviceListTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];

        [_policyAdviceListTableView registerClass:[policyAdviceCell class] forCellReuseIdentifier:REUSE_MARK];
        _policyAdviceListTableView.delegate = self;
        _policyAdviceListTableView.dataSource = self;
//        _policyAdviceListTableView.backgroundColor = [UIColor greenColor];
        _policyAdviceListTableView.rowHeight = 57;
    }
    return _policyAdviceListTableView;
}
-(UIImageView *)policyAdviceListTableUpShadowView
{
    if (_policyAdviceListTableUpShadowView == nil) {
        _policyAdviceListTableUpShadowView = [[UIImageView alloc]initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"up_19" ofType:@"png" inDirectory:@""]]];
    }
    return _policyAdviceListTableUpShadowView;
}
-(UIImageView *)policyAdviceListTableDownShadowView
{
    if (_policyAdviceListTableDownShadowView == nil) {
        _policyAdviceListTableDownShadowView = [[UIImageView alloc]initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"down_27" ofType:@"png" inDirectory:@""]]];
    }
    return _policyAdviceListTableDownShadowView;
}
#pragma mark----method
-(void)setupUI
{
    [self addSubview:self.policyAdviceListTableView];
    [_policyAdviceListTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(160);
        make.left.equalTo(self).offset(68);
        make.size.mas_equalTo(CGSizeMake(806, 456));
    }];
    [self addSubview:self.policyAdviceListTableUpShadowView];
    [self.policyAdviceListTableUpShadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.policyAdviceListTableView);
        make.width.equalTo(@854);
        make.top.equalTo(self.policyAdviceListTableView);
        make.height.offset(11);
        
    }];
    [self addSubview:self.policyAdviceListTableDownShadowView];
    [self.policyAdviceListTableDownShadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.policyAdviceListTableView);
        make.width.equalTo(@854);
        make.bottom.equalTo(self.policyAdviceListTableView);
        make.height.offset(11);
        
    }];

}

-(void)loadDataSource
{
    [NetRequest getPolicyAdviceListWithPageSize:@"1" andPageNumb:@"2" byTitle:@"" byKeyWords:@"" completion:^(id responseObject, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }else{
            [self.dataSource addObjectsFromArray:responseObject[@"content"]];
            [self.policyAdviceListTableView reloadData];
        }
        
        
    } ];
}
#pragma mark ------------<UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count >8 ? self.dataSource.count: 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    policyAdviceCell * cell = [tableView dequeueReusableCellWithIdentifier:REUSE_MARK];
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    if (indexPath.row < self.dataSource.count) {
        [cell setupValueWithData:self.dataSource[indexPath.row]];
        cell.serialNumberLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    }else{
//        [cell setupValueWithData:nil];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    
//    UIImageView *view = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    view.userInteractionEnabled = YES;
//    view.backgroundColor = [UIColor blackColor];
//    view.alpha = 0.5;
//    [self addSubview:view];
    PopUpView * aView =[[PopUpView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    aView.title = self.dataSource[indexPath.row][@"title"];
    
    [aView popup];
//    
//    [PopUpView popupView:[[PopUpView alloc]initWithFrame:[UIScreen mainScreen].bounds]];
//    PopUpView *view = [[PopUpView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:view];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}


@end








