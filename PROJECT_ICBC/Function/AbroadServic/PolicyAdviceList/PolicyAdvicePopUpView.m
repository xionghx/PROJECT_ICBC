//
//  PolicyAdvicePopUpView.m
//  BOCMarketingSystem
//
//  Created by xionghuaxin on 7/29/16.
//  Copyright © 2016 tangchuanhui. All rights reserved.
//

#import "PolicyAdvicePopUpView.h"
@interface PolicyAdvicePopUpView ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *selectTypeTabelView;
@property(nonatomic,strong)NSArray *dataSource;


@end
@implementation PolicyAdvicePopUpView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = @[@"标题",@"关键字"];
        [self addSubview:self.selectTypeTabelView];
        [self.selectTypeTabelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}
#pragma mark ---------getter
-(UITableView *)selectTypeTabelView
{
    if (_selectTypeTabelView == nil) {
        _selectTypeTabelView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _selectTypeTabelView.delegate = self;
        _selectTypeTabelView.dataSource = self;
        [_selectTypeTabelView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell_reuse"];
    }
    return _selectTypeTabelView;
}
#pragma mark----------------<UITableViewDataSource,UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell_reuse"];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate didSelectedRow:self.dataSource[indexPath.row]];
}
@end
