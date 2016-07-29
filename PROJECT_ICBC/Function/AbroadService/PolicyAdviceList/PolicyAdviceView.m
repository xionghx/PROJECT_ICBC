//
//  PolicyAdviceView.m
//  PROJECT_ICBC
//
//  Created by xionghuaxin on 7/22/16.
//  Copyright © 2016 xionghuanxin. All rights reserved.
//

#import "PolicyAdviceView.h"
#import "PolicyAdviceCell.h"
#import "NetRequest.h"
#import "PopUpView.h"
#import "PolicyAdvicePopUpView.h"


#define REUSE_MARK  @"cell_reuse"

@interface PolicyAdviceView ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,PolicyAdvicePopUpViewDelegate>
@property(nonatomic ,strong)UIButton *searchTypeButton;
@property(nonatomic ,strong)UITextField *searchTextField;
@property(nonatomic ,strong)UIImageView *backgroudView;
@property(nonatomic ,strong)UIView *coverView;
@property(nonatomic ,strong)UIView *popUpView;
@property(nonatomic ,strong)UITableView *policyAdviceListTableView;
@property(nonatomic ,strong)UIImageView *policyAdviceListTableUpShadowView;
@property(nonatomic ,strong)UIImageView *policyAdviceListTableDownShadowView;
@property(nonatomic ,strong)NSMutableArray *dataSource;
@property(nonatomic ,strong)UIView *selectSearchTypeView;
@property(nonatomic ,strong)PolicyAdvicePopUpView *selectTypeView;

@property(nonatomic,strong)NSMutableDictionary *interfaceData;
@property(nonatomic,strong)NSString *searchType;

@end

@implementation PolicyAdviceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = @[].mutableCopy;
        self.interfaceData = @{@"pageSize":@"10",@"pageNumb":@"1",@"searchType":@""}.mutableCopy;
        [self loadDataSource];
        [self setupUI];
//        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


#pragma mark----------getter
-(UIButton *)searchTypeButton
{
    if (_searchTypeButton == nil) {
        _searchTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchTypeButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"choose_01" ofType:@"png" inDirectory:@""]] forState:UIControlStateNormal];
        [_searchTypeButton addTarget:self action:@selector(searchButtonTaped) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchTypeButton;
}
-(UITextField *)searchTextField
{
    if (_searchTextField == nil) {
        _searchTextField = [[UITextField alloc]init];
        _searchTextField.background = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"search_02" ofType:@"png" inDirectory:@""]];
//        _searchTextField.keyboardType = UIKeyboardTypeNumberPad;
//        [_searchTextField setKeyboardType:UIKeyboardTypeNumberPad];
        _searchTextField.delegate = self;
        _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchTextField.tintColor = [UIColor blackColor];

    }
    return _searchTextField;
}
-(UIView *)selectSearchTypeView
{
    if (_selectSearchTypeView == nil) {
        _selectSearchTypeView = [[UIView alloc]initWithFrame:CGRectZero];
        
        
    }
    return _selectSearchTypeView;
}
-(UIView *)coverView
{
    if (_coverView == nil) {
        _coverView = [[UIView alloc]initWithFrame:CGRectZero];
        _coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        UITapGestureRecognizer * GestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(coverViewGesture)];
        [_coverView addGestureRecognizer:GestureRecognizer];
    }
    
    return _coverView;
}
-(UIView *)popUpView
{
    if (_popUpView == nil) {
        _popUpView = [[UIView alloc]initWithFrame:CGRectZero];
        _popUpView.layer.cornerRadius = 10;
        _popUpView.backgroundColor = [UIColor whiteColor];
        _popUpView.clipsToBounds = YES;
    }
    return _popUpView;
}
-(PolicyAdvicePopUpView *)selectTypeView
{
    if (_selectTypeView == nil) {
        _selectTypeView = [[PolicyAdvicePopUpView alloc]initWithFrame:CGRectZero];
        _selectTypeView.delegate = self;
    }
    return _selectTypeView;
}
-(UIImageView *)backgroudView
{
    if (_backgroudView == nil) {
        _backgroudView = [[UIImageView alloc]init];
        _backgroudView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"背景" ofType:@"png" inDirectory:@""]];
    }
    return _backgroudView;
}

-(UITableView *)policyAdviceListTableView
{
    if (_policyAdviceListTableView == nil) {
        _policyAdviceListTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_policyAdviceListTableView registerClass:[PolicyAdviceCell class] forCellReuseIdentifier:REUSE_MARK];
        _policyAdviceListTableView.delegate = self;
        _policyAdviceListTableView.dataSource = self;
        _policyAdviceListTableView.rowHeight = 57;
        _policyAdviceListTableView.backgroundColor = [UIColor clearColor];
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
    [self addSubview:self.backgroudView];
    [self.backgroudView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(-5, -5, -5, -5));
    }];
    [self addSubview:self.searchTypeButton];
    [self addSubview:self.searchTextField];
    [self.searchTypeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(28);
        make.right.mas_equalTo(self).offset(-200);
        make.right.mas_equalTo(self.searchTextField.mas_left);
        make.size.mas_offset(CGSizeMake(CGImageGetWidth(self.searchTypeButton.currentImage.CGImage)/2, CGImageGetHeight(self.searchTypeButton.currentImage.CGImage)/2));
    }];
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.searchTypeButton);
        make.left.mas_equalTo(self.searchTypeButton.mas_right);
        make.size.mas_offset(CGSizeMake(CGImageGetWidth(self.searchTextField.background.CGImage)/2, CGImageGetHeight(self.searchTextField.background.CGImage)/2));
    }];
    
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
-(void)searchButtonTaped
{
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self.coverView];
    [self.coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo([UIApplication sharedApplication].keyWindow.rootViewController.view);
    }];
    [[UIApplication sharedApplication].keyWindow.rootViewController.view  addSubview:self.popUpView];
    [self.popUpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchTypeButton);
        make.right.equalTo(self.searchTextField);
        make.top.equalTo(self.searchTextField.mas_bottom);
        make.height.offset(200);
    }];
    
    [self.popUpView addSubview:self.selectTypeView];
    [_selectTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.popUpView);
    }];
}

-(void)loadDataSource
{
    [NetRequest getPolicyAdviceListWithPageSize:self.interfaceData[@"pageSize"] andPageNumb:self.interfaceData[@"pageNumb"] byTitle:([self.interfaceData[@"searchType"] isEqualToString:@"标题"]?self.searchTextField.text:@"") byKeyWords:([self.interfaceData[@"searchType"] isEqualToString:@"关键字"]?self.searchTextField.text:@"") completion:^(id responseObject, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }else{
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:responseObject[@"content"]];
            [self.policyAdviceListTableView reloadData];
        }
        
        
    }];
}

-(void)coverViewGesture
{
    [self.coverView removeFromSuperview];
    [self.popUpView removeFromSuperview];
}
#pragma mark ------------<UITableViewDelegate,UITableViewDataSource,PolicyAdvicePopUpViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count >8 ? self.dataSource.count: 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PolicyAdviceCell * cell = [tableView dequeueReusableCellWithIdentifier:REUSE_MARK];
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    if (indexPath.row < self.dataSource.count) {
        [cell setupValueWithData:self.dataSource[indexPath.row]];
        cell.serialNumberLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    }else{
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row+1>self.dataSource.count) {
        return;
    }
    PopUpView * aView =[[PopUpView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    aView.title = self.dataSource[indexPath.row][@"title"];
//
//    [aView addLabelInView:aView withContent:self.dataSource[indexPath.row][@"content"] ];
//    
//    
//    [aView popupSelf];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    
//    return [self validateNumber:string];
//}
//
//- (BOOL)validateNumber:(NSString*)number {
//    BOOL res = YES;
//    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
//    int i = 0;
//    while (i < number.length) {
//        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
//        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
//        if (range.length == 0) {
//            res = NO;
//            break;
//        }
//        i++;
//    }
//    return res;
//}
-(void)didSelectedRow:(NSString *)string
{
    self.interfaceData[@"searchType"] = string;
    [self.coverView removeFromSuperview];
    [self.popUpView removeFromSuperview];

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.interfaceData[@"searchType"] isEqualToString:@""]) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示:" message:@"请选择搜索类型" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction: action];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    }
    [self loadDataSource];
    [self.policyAdviceListTableView reloadData];
    return YES;
}
@end








