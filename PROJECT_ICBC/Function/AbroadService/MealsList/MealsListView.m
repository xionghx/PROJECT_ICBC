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

static NSString * REUSE_MARK = @"cell_reuse";

@interface MealsListView ()<UICollectionViewDelegate,UICollectionViewDataSource,AttributesContenOffset>
@property(nonatomic ,strong)UICollectionView *mealsListColletionView;
@property(nonatomic ,strong)MealistCollectionViewLayout *mealistCollectionViewLayout;

@property(nonatomic ,assign)CGPoint contentofset;

@end

@implementation MealsListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark ----------method
-(void)setupUI
{
    [self addSubview:self.mealsListColletionView];
    [NSString stringWithFormat:@"%@",[NSString class]];
    [self.mealsListColletionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}
#pragma mark -----------getter
-(UICollectionView *)mealsListColletionView
{
    if (_mealsListColletionView == nil) {
        _mealsListColletionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.mealistCollectionViewLayout];
        _mealsListColletionView.dataSource = self;
        _mealsListColletionView.delegate = self;
//        _mealsListColletionView.backgroundColor = [UIColor redColor];
        [_mealsListColletionView registerClass:[MealistCollectionViewCell class] forCellWithReuseIdentifier:REUSE_MARK];
    }
    return _mealsListColletionView;
}
-(MealistCollectionViewLayout *)mealistCollectionViewLayout
{
    if (_mealistCollectionViewLayout == nil) {
        _mealistCollectionViewLayout = [[MealistCollectionViewLayout alloc]init];
        _mealistCollectionViewLayout.delegate = self;
    }
    return _mealistCollectionViewLayout;
}
#pragma mark-----------------<UICollectionViewDelegate,UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MealistCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:REUSE_MARK forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
//    cell.bounds = CGRectMake(0, 0, 100, 100);
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.contentofset = scrollView.contentOffset;
    [self.mealsListColletionView reloadData];
}

-(CGPoint )attributesContenOffset;
{
    return self.contentofset;

}

@end
