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
@property(nonatomic ,strong)UIButton *videoButton;
@property(nonatomic ,assign)CGPoint contentOffset;
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
    [self addSubview:self.videoButton];
    [self.videoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(25);
        make.right.equalTo(self).offset(-100);
        make.size.mas_offset(CGSizeMake(CGImageGetWidth(self.videoButton.currentImage.CGImage)/2, CGImageGetHeight(self.videoButton.currentImage.CGImage)/2));
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

-(void)videoButtonTaped
{
    
}
#pragma mark -----------getter
-(UIButton *)videoButton
{
    if (_videoButton == nil) {
        _videoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_videoButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"视频图标_05" ofType:@"png" inDirectory:@""]] forState:UIControlStateNormal];
        [_videoButton addTarget:self action:@selector(videoButtonTaped) forControlEvents:UIControlEventTouchUpInside];
    }
    return _videoButton;
}
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
//    NSLog(@"%lf,%lf",cell.center.x,self.contentOffset.x);
//    CGFloat scale = fabs(self.contentOffset.x-cell.center.x +472)<380?fabs(self.contentOffset.x-cell.center.x +472)<380:0 ;
//    cell.transform = CGAffineTransformMakeScale(1 + scale * 60 /275,1 + scale * 100/400);
    cell.userInteractionEnabled = fabs(self.contentOffset.x-cell.center.x +472)<380?YES:NO;
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.contentOffset = scrollView.contentOffset;
    [self.mealsListColletionView reloadData];
}

@end
