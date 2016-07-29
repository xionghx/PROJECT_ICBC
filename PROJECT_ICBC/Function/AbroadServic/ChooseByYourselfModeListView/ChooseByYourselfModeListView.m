//
//  ChooseByYourselfModelListView.m
//  PROJECT_ICBC
//
//  Created by xionghuaxin on 7/25/16.
//  Copyright © 2016 xionghuanxin. All rights reserved.
//

#import "ChooseByYourselfModelListView.h"
#import "ChooseByYourselfModelCollectionViewCell.h"

#import "NetRequest.h"
static NSString * REUSE_MARK = @"ChooseByYourselfModelCollectionViewCell_reuse";

@interface ChooseByYourselfModelListView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic ,strong)UIImageView *backgroundView;
@property(nonatomic ,strong)UIView *buttonView;
@property(nonatomic ,strong)UIButton *leftButton;
@property(nonatomic ,strong)UIButton *rightButton;
@property(nonatomic ,strong)UIScrollView *buttonScrollView;
@property(nonatomic ,strong)UIView *buttonScrollContentView;
@property(nonatomic ,strong)NSMutableArray * buttonArray;
@property(nonatomic ,strong)UIButton *videoButton;
@property(nonatomic ,strong)UICollectionView *chooseByYourselfModelCollectionView;
@property(nonatomic ,strong)NSMutableArray *dataSource;

@end

@implementation ChooseByYourselfModelListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = [NSMutableArray array];
        [self setupUI];
        [self loadDataSource];
    }
    return self;
}
#pragma mark------------method

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self layoutIfNeeded];
    CGFloat totalButtonW = 0;
    for (UIButton * button in self.buttonArray) {
        totalButtonW += button.frame.size.width;
    }
    self.buttonScrollView.contentSize = CGSizeMake(totalButtonW, 0);
    
}

-(void)setupUI
{
    [self addSubview:self.backgroundView];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(-5, -5, -5, -5));
    }];
    [self addSubview:self.buttonView];
    [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).offset(90);
        make.size.mas_offset(CGSizeMake(611, 25));
    }];
    [self.buttonView addSubview:self.leftButton];
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.centerY.equalTo(self.buttonView);
        make.size.mas_equalTo(CGSizeMake(CGImageGetWidth(self.leftButton.currentImage.CGImage)/2, CGImageGetHeight(self.leftButton.currentImage.CGImage)/2));
    }];
    [self.buttonView addSubview:self.rightButton];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.centerY.equalTo(self.buttonView);
        make.size.mas_equalTo(CGSizeMake(CGImageGetWidth(self.rightButton.currentImage.CGImage)/2, CGImageGetHeight(self.rightButton.currentImage.CGImage)/2));
    }];
    [self.buttonView addSubview:self.buttonScrollView];
    [self.buttonScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.buttonView).offset(35);
        make.right.equalTo(self.buttonView).offset(-35);
        make.centerY.and.height.equalTo(self.buttonView);
    }];
    [self setupButtons];
    [self addSubview:self.chooseByYourselfModelCollectionView];
    [self.chooseByYourselfModelCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(28);
        make.bottom.equalTo(self).offset(-295);
        make.right.equalTo(self).offset(-28);
        make.top.equalTo(self.buttonView.mas_bottom).offset(5);
    }];

    [self addSubview:self.videoButton];
    [self.videoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(25);
        make.right.equalTo(self).offset(-100);
        make.size.mas_offset(CGSizeMake(CGImageGetWidth(self.videoButton.currentImage.CGImage)/2, CGImageGetHeight(self.videoButton.currentImage.CGImage)/2));
    }];

}
-(void)setupButtons
{
    self.buttonArray = [NSMutableArray array];
    NSArray *buttonNames = @[@"  中银汇兑  ",@"  境内代理海外开户见证服务  ",@"  借记卡产品  ",@"  信用卡服务  ",@"  理想之间•留学贷款  ",@"  网上银行BOCNET  ",@"  中银保险  ",@"  中银理财产品  "];
    for (NSInteger index = 0; index < buttonNames.count; index ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:buttonNames[index] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [self.buttonArray addObject:button];
        [self.buttonScrollView addSubview:button];
        if (index == 0) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.buttonScrollView.mas_left);
                make.centerY.equalTo(self.buttonScrollView);
            }];
        }else {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(((UIButton *)self.buttonArray[index -1]).mas_right);
                make.centerY.equalTo(self.buttonScrollView);
            }];
        }
        [button addTarget:self action:@selector(buttonTaped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    ((UIButton *)self.buttonArray.firstObject).enabled = NO;
}
-(void)buttonTaped:(UIButton *)sender
{
    for (UIButton * button in self.buttonArray) {
        if (sender == button) {
            button.enabled = NO;
            [NetRequest getChooseByYourselfModeListWithPageSize:@"1" andPageNumb:@"30" TypeId:[NSString stringWithFormat:@"%ld",[self.buttonArray indexOfObject:button]+1] userId:@"22" completion:^(id responseObject, NSError *error) {
                if (error) {
                    NSLog(@"%@",error);
                }else{
                    [self.dataSource  removeAllObjects];
                    [self.dataSource addObjectsFromArray:responseObject[@"content"]];
                    [self.chooseByYourselfModelCollectionView reloadData];
                }
                
            } ];
            
        }else{
            button.enabled = YES;
        }
    }
}

-(void)videoButtonTaped
{
    
}
-(void)leftButtonTaped
{
    if (self.buttonScrollView.contentOffset.x +self.buttonScrollView.frame.size.width<self.buttonScrollView.contentSize.width) {
        self.buttonScrollView.contentOffset = CGPointMake(self.buttonScrollView.contentOffset.x + 50, self.buttonScrollView.contentOffset.y);
    }
}
-(void)rightButtonTaped
{
    if (self.buttonScrollView.contentOffset.x >0) {
        self.buttonScrollView.contentOffset = CGPointMake(self.buttonScrollView.contentOffset.x -50, self.buttonScrollView.contentOffset.y);
    }
}

#pragma mark------------getter
-(UIImageView *)backgroundView
{
    if (_backgroundView == nil) {
        _backgroundView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _backgroundView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"背景" ofType:@"png" inDirectory:@""]];
    }
    return _backgroundView;
}
-(UIButton *)videoButton
{
    if (_videoButton == nil) {
        _videoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_videoButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"视频图标_05" ofType:@"png" inDirectory:@""]] forState:UIControlStateNormal];
        [_videoButton addTarget:self action:@selector(videoButtonTaped) forControlEvents:UIControlEventTouchUpInside];
    }
    return _videoButton;
}

-(UIView *)buttonView
{
    if (_buttonView == nil) {
        _buttonView = [[UIView alloc]initWithFrame:CGRectZero];
        _buttonView.userInteractionEnabled = YES;
    }
    return _buttonView;
}
-(UIButton *)leftButton
{
    if (_leftButton == nil) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"箭头左" ofType:@"png" inDirectory:@""]] forState:UIControlStateNormal];
        [_leftButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"箭头左" ofType:@"png" inDirectory:@""]] forState:UIControlStateDisabled];
        [_leftButton addTarget:self action:@selector(leftButtonTaped) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}
-(UIButton *)rightButton
{
    if (_rightButton == nil) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"箭头右" ofType:@"png" inDirectory:@""]] forState:UIControlStateNormal];
        [_rightButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"箭头右" ofType:@"png" inDirectory:@""]] forState:UIControlStateDisabled];
        [_rightButton addTarget:self action:@selector(rightButtonTaped) forControlEvents:UIControlEventTouchUpInside];

        
    }
    return _rightButton;
}
-(UIScrollView *)buttonScrollView
{
    if (_buttonScrollView == nil) {
        _buttonScrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
    }
    return _buttonScrollView;
}
-(UIView *)buttonScrollContentView
{
    if (_buttonScrollContentView == nil) {
        _buttonScrollContentView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _buttonScrollContentView;
}
-(UICollectionView *)chooseByYourselfModelCollectionView
{
    if (_chooseByYourselfModelCollectionView == nil) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(280, 250);
        _chooseByYourselfModelCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _chooseByYourselfModelCollectionView.delegate = self;
        _chooseByYourselfModelCollectionView.dataSource = self;
        [_chooseByYourselfModelCollectionView registerClass:[ChooseByYourselfModelCollectionViewCell class] forCellWithReuseIdentifier: REUSE_MARK];
        _chooseByYourselfModelCollectionView.backgroundColor = [UIColor whiteColor];
        _chooseByYourselfModelCollectionView.contentInset =UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return _chooseByYourselfModelCollectionView;
}
-(void)loadDataSource
{
    
    [NetRequest getChooseByYourselfModeListWithPageSize:@"1" andPageNumb:@"30" TypeId:@"1" userId:@"22" completion:^(id responseObject, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }else{
            
            [self.dataSource  removeAllObjects];
            [self.dataSource addObjectsFromArray:responseObject[@"content"]];
            [self.chooseByYourselfModelCollectionView reloadData];
        }
        
    } ];
}
#pragma mark-----------------<UICollectionViewDelegate,UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ChooseByYourselfModelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:REUSE_MARK forIndexPath:indexPath];
    [cell setupValueWithData:self.dataSource[indexPath.row]];
    return cell;
}

//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(10, 10, 10, 10);
//}

@end
