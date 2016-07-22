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
#define REUSE_MARK  @"cell_reuse"

@interface PolicyAdviceView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic ,strong)UITableView *policyAdviceListTableView;
@property(nonatomic ,strong)NSMutableArray *dataSource;

@end

@implementation PolicyAdviceView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = @[].mutableCopy;
        [self loadDataSource];
        [self setupUI];

    }
    return self;
}

#pragma mark----------getter
-(UITableView *)policyAdviceListTableView
{
    if (_policyAdviceListTableView == nil) {
        _policyAdviceListTableView = [[UITableView alloc]init];
        [_policyAdviceListTableView registerClass:[policyAdviceCell class] forCellReuseIdentifier:REUSE_MARK];
        _policyAdviceListTableView.delegate = self;
        _policyAdviceListTableView.dataSource = self;
        _policyAdviceListTableView.backgroundColor = [UIColor greenColor];
        _policyAdviceListTableView.rowHeight = 30;
    }
    return _policyAdviceListTableView;
}
#pragma mark----method
-(void)setupUI
{
    [self addSubview:self.policyAdviceListTableView];
    [self.policyAdviceListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(160, 68, 72, 68));
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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    policyAdviceCell * cell = [tableView dequeueReusableCellWithIdentifier:REUSE_MARK];
    if (indexPath.row <= self.dataSource.count) {
        [cell setupValueWithData:self.dataSource[indexPath.row]];
    }else{
        [cell setupValueWithData:nil];
    }
    
    return cell;
}

@end
