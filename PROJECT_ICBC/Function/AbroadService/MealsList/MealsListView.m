//
//  MealsListView.m
//  PROJECT_ICBC
//
//  Created by xionghuaxin on 7/25/16.
//  Copyright © 2016 xionghuanxin. All rights reserved.
//

#import "MealsListView.h"
#import "MealistCollectionViewLayout.h"
#import "MealistCollectionViewCell.h"
#import "NetRequest.h"

static NSString * REUSE_MARK = @"cell_reuse";

@interface MealsListView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic ,strong)UICollectionView *mealsListColletionView;
@property(nonatomic ,strong)UIImageView *backgroudView;
@property(nonatomic ,strong)MealistCollectionViewLayout *mealistCollectionViewLayout;

@property(nonatomic ,strong)NSMutableArray *dataSource;

//@property(nonatomic ,assign)CGPoint contentofset;

@end

@implementation MealsListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = [NSMutableArray array];
        [self loadDataSource];
        [self setupUI];
        
    }
    return self;
}

#pragma mark ----------method
-(void)setupUI
{
    [self addSubview:self.backgroudView];
    [self.backgroudView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(-5, -5, -5, -5));
    }];
    [self addSubview:self.mealsListColletionView];
    [self.mealsListColletionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}
-(void)loadDataSource
{
    [NetRequest getMealsListWithPageSize:@"1" andPageNumb:@"10" andUserId:@"22" completion:^(id responseObject, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }else{
            [self.dataSource addObjectsFromArray:responseObject[@"content"]];
            [self.mealsListColletionView reloadData];
        }
    } ];
}
#pragma mark -----------getter
-(UIImageView *)backgroudView
{
    if (_backgroudView == nil) {
        _backgroudView = [[UIImageView alloc]init];
        _backgroudView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"背景" ofType:@"png" inDirectory:@""]];
    }
    return _backgroudView;
}
-(UICollectionView *)mealsListColletionView
{
    if (_mealsListColletionView == nil) {
        _mealsListColletionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.mealistCollectionViewLayout];

        _mealsListColletionView.dataSource = self;
        _mealsListColletionView.delegate = self;
        _mealsListColletionView.backgroundColor = [UIColor clearColor];
        [_mealsListColletionView registerClass:[MealistCollectionViewCell class] forCellWithReuseIdentifier:REUSE_MARK];
    }
    return _mealsListColletionView;
}
-(MealistCollectionViewLayout *)mealistCollectionViewLayout
{
    if (_mealistCollectionViewLayout == nil) {
        _mealistCollectionViewLayout = [[MealistCollectionViewLayout alloc]init];
    }
    return _mealistCollectionViewLayout;
}
#pragma mark-----------------<UICollectionViewDelegate,UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MealistCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:REUSE_MARK forIndexPath:indexPath];
    [cell setupValueWith:self.dataSource[indexPath.row]];
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.mealsListColletionView reloadData];
}

@end
