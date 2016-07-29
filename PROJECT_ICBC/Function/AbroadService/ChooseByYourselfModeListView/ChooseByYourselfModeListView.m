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
@property(nonatomic ,strong)NSMutableArray * buttonArray;

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
-(void)setupUI
{
    [self addSubview:self.backgroundView];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(-5, -5, -5, -5));
    }];
    [self addSubview:self.buttonView];
    
    [self setupButtons];
    [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).offset(90);
        make.bottom.equalTo(((UIButton *)self.buttonArray[0]).mas_bottom);
        make.left.equalTo(((UIButton *)self.buttonArray[0]).mas_left);
        make.right.equalTo(((UIButton *)self.buttonArray[self.buttonArray.count-1]).mas_right);
    }];
    
    
    for (NSInteger index = 0; index < self.buttonArray.count; index ++) {
        NSArray *buttonImageNames = @[@"箭头左",@"箭头左",@"中银汇兑_02",@"中银汇兑_02_h",@"境内代理_03",@"境内代理_03_h",@"借记卡产品_04",@"借记卡产品_04_h",@"信用卡服务_05",@"信用卡服务_05_h",@"箭头右",@"箭头右"];
        
        UIButton * button = self.buttonArray[index];
        UIImage * image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:buttonImageNames[2* index] ofType:@"png" inDirectory:@""]];
        UIImage * disabledImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:buttonImageNames[2* index + 1] ofType:@"png" inDirectory:@""]];
        
        if (index == 0) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.buttonView);
                make.top.equalTo(self.buttonView);
                make.right.mas_equalTo(((UIButton *)self.buttonArray[index +1]).mas_left);

                make.size.mas_equalTo(CGSizeMake(CGImageGetWidth(image.CGImage)/2, CGImageGetHeight(image.CGImage)/2));
            }];
        }else if (index ==5){
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(((UIButton *)self.buttonArray[index -1]).mas_right);
                make.size.mas_equalTo(CGSizeMake(CGImageGetWidth(image.CGImage)/2, CGImageGetHeight(image.CGImage)/2));
                make.top.equalTo(self.buttonView);
                make.right.equalTo(self.buttonView);
            }];
            
            
        }else{
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(((UIButton *)self.buttonArray[index -1]).mas_right);
                make.right.mas_equalTo(((UIButton *)self.buttonArray[index +1]).mas_left);
                make.size.mas_equalTo(CGSizeMake(CGImageGetWidth(image.CGImage)/2, CGImageGetHeight(image.CGImage)/2));
                make.top.equalTo(self.buttonView);
            }];
        }
        [button setImage:image forState:UIControlStateNormal];
        [button setImage:disabledImage forState:UIControlStateDisabled];
        
        
    }
    ((UIButton *)self.buttonArray[1]).enabled = NO;
    [self addSubview:self.chooseByYourselfModelCollectionView];
    [self.chooseByYourselfModelCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(28);
        make.bottom.equalTo(self).offset(-295);
        make.right.equalTo(self).offset(-28);
        make.top.equalTo(self.buttonView.mas_bottom).offset(5);
    }];

    
}
-(void)setupButtons
{
    self.buttonArray = [NSMutableArray array];
    NSArray *buttonImageNames = @[@"箭头左",@"箭头左",@"中银汇兑_02",@"中银汇兑_02_h",@"境内代理_03",@"境内代理_03_h",@"借记卡产品_04",@"借记卡产品_04_h",@"信用卡服务_05",@"信用卡服务_05_h",@"箭头右",@"箭头右"];

    for (NSInteger index = 0; index < buttonImageNames.count/2; index ++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.buttonView addSubview:button];
        [self.buttonArray addObject:button];
        [button addTarget:self action:@selector(buttonTaped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}
-(void)buttonTaped:(UIButton *)sender
{
    for (UIButton * button in self.buttonArray) {
        if (sender == button) {
            button.enabled = NO;
        }else{
            button.enabled = YES;
        }
    }
    
    ((UIButton *)self.buttonArray[0]).enabled = NO;
    ((UIButton *)self.buttonArray[self.buttonArray.count-1]).enabled = NO;
    for (NSInteger index = 1; index < self.buttonArray.count-1; index ++) {
        if (((UIButton *)self.buttonArray[index]).enabled == NO) {
            [NetRequest getChooseByYourselfModeListWithPageSize:@"1" andPageNumb:@"30" TypeId:[NSString stringWithFormat:@"%ld",index] userId:@"22" completion:^(id responseObject, NSError *error) {
                if (error) {
                    NSLog(@"%@",error);
                }else{
                    
                    [self.dataSource  removeAllObjects];
                    [self.dataSource addObjectsFromArray:responseObject[@"content"]];
                    [self.chooseByYourselfModelCollectionView reloadData];
                }
                
            } ];

        }
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

-(UIView *)buttonView
{
    if (_buttonView == nil) {
        _buttonView = [[UIView alloc]initWithFrame:CGRectZero];
        _buttonView.userInteractionEnabled = YES;
    }
    return _buttonView;
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
