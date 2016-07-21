//
//  ViewController.m
//  PROJECT_ICBC
//
//  Created by xionghuaxin on 7/20/16.
//  Copyright © 2016 xionghuanxin. All rights reserved.
//

#import "ViewController.h"
#import "NetRequest.h"
//#import "XStringUtils.h"
//#import "AFNetWorking.h"
//#import "UIKit+AFNetworking.h"
//#define POST_URL @"http://nmzh.rimiedu.com/rimicms/resources/appIndex/appLogin"

@interface ViewController ()

@end
/*
 Method: appIndex/appLogin
 登录
 Input: paramJson

 */
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [NetRequest userLoginWithUsername:@"khjl001" password:@"khjl001" completion:^(id responseObject, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }else{
            NSLog(@"%@",responseObject);
        }
    }];
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    //请求超时时间
//    manager.requestSerializer.timeoutInterval = 10;
//    //默认的提交数据格式是二进制格式，返回数据的格式是JSON格式
//    //设置请求格式：二进制
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    
//    //设置返回数据格式：JSON
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    //配置MIME类型
//    manager.responseSerializer.acceptableContentTypes = [NSSet  setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
//
//    
//    NSString * parameStr = [XStringUtils jsonStringWithParameters:@{@"username":@"khjl001",@"password":[XStringUtils md5HexDigestWithString:@"khjl001"]}];
//    
//    [manager POST:POST_URL parameters:@{@"paramJson":parameStr} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//    }];
    
    
//    [NetRequest userLoginWithUsername:@"khjl001" password:@"khjl001" completion:^(id responseObject, NSError *error) {
//        
//        if (error) {
//            NSLog(@"%@",error);
//        }else{
//            NSLog(@"%@",responseObject);
//        }
//    }];
}

@end
