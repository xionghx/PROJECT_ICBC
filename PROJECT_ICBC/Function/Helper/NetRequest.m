//
//  NetRequest.m
//  三方网络请求
//
//  Created by Iracle Zhang on 6/6/16.
//  Copyright © 2016 Iracle. All rights reserved.
//

#import "NetRequest.h"
#import "AFNetworking.h"
#import "XStringUtils.h"
#define POST_URL @"http://nmzh.rimiedu.com/rimicms/resources"



@implementation NetRequest



+(void)userLoginWithUsername:(NSString *)sUsername
                    password:(NSString *)sPassword
                  completion:(void(^)(id responseObject,NSError *error))completionBlock
{
    NSString * parameStr = [XStringUtils jsonStringWithParameters:@{@"username":sUsername,@"password":sPassword}];
    
    [self POST:[NSString stringWithFormat:@"%@%@",POST_URL,@"/appIndex/appLogin"] parameters:[self getParametersByParams:parameStr] sucess:^(id responseObject) {
        completionBlock(responseObject,nil);
    } failure:^(NSError *error) {
        completionBlock(nil,error);
    }];
}


//+(void)

























+ (void)GET:(NSString *)url parameters:(NSDictionary *)parameters sucess:(void (^)(id))sucess failure:(void (^)(NSError *))failure {
    //初始化网络请求管理类
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //请求超时时间
    manager.requestSerializer.timeoutInterval = 10;
    //默认的提交数据格式是二进制格式，返回数据的格式是JSON格式
    //设置请求格式：二进制
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //设置返回数据格式：JSON
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //配置MIME类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    //GET请求
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //调用block
        sucess(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //调用block
        failure(error);
        
    }];
}

+ (void)POST:(NSString *)url parameters:(NSDictionary *)parameters sucess:(void (^)(id))sucess failure:(void (^)(NSError *))failure {
    //初始化网络请求管理类
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //请求超时时间
    manager.requestSerializer.timeoutInterval = 10;
    //默认的提交数据格式是二进制格式，返回数据的格式是JSON格式
    //设置请求格式：二进制
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //设置返回数据格式：JSON
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //配置MIME类型
    manager.responseSerializer.acceptableContentTypes = [NSSet  setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    //POST请求
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        sucess(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
    
    
    
}


+(NSDictionary *)getParametersByParams:(NSString *)paramJson
{
    NSMutableDictionary *adic = [NSMutableDictionary dictionary];
    if (![XStringUtils isTextEmpty:paramJson]) {
        [adic setValue:paramJson forKey:@"paramJson"];
    }
    return adic;
}




@end










