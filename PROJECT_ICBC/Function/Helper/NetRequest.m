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
//userLogin

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


//abroadService
+(void)getMealsListWithPageSize:(NSString *)pageSize
                    andPageNumb:(NSString *)pageNum
                      andUserId:(NSString *)userId
                     completion:(void(^)(id responseObject,NSError *error))completionBlock

{
    NSString * parameStr = [XStringUtils jsonStringWithParameters:@{@"pageSize":pageSize,@"pageNum":pageNum,@"userId":userId}];
    [self POST:[NSString stringWithFormat:@"%@%@",POST_URL,@"/appAbroad/getMealsList"] parameters:[self getParametersByParams:parameStr] sucess:^(id responseObject) {
        completionBlock(responseObject,nil);
    } failure:^(NSError *error) {
        completionBlock(nil,error);
    }];
    
}

+(void)getPolicyAdviceListWithPageSize:(NSString *)pageSize
                           andPageNumb:(NSString *)pageNum
                               byTitle:(NSString *)byTitle
                            byKeyWords:(NSString *)byKeyWords
                            completion:(void(^)(id responseObject,NSError *error))completionBlock
{
    NSString * parameStr = [XStringUtils jsonStringWithParameters:@{@"pageSize":pageSize,@"pageNum":pageNum,@"byTitle":byTitle,@"byKeyWords":byKeyWords}];
    [self POST:[NSString stringWithFormat:@"%@%@",POST_URL,@"/appAbroad/getPolicyAdviceList"] parameters:[self getParametersByParams:parameStr] sucess:^(id responseObject) {
        completionBlock(responseObject,nil);
    } failure:^(NSError *error) {
        completionBlock(nil,error);
    }];
    
}


+(void)getChooseByYourselfModeListWithPageSize:(NSString *)pageSize
                                   andPageNumb:(NSString *)pageNum
                                        TypeId:(NSString *)typeId
                                        userId:(NSString *)userId
                                    completion:(void(^)(id responseObject,NSError *error))completionBlock
{
    NSString * parameStr = [XStringUtils jsonStringWithParameters:@{@"pageSize":pageSize,@"pageNum":pageNum,@"typeId":typeId,@"userId":userId}];
    [self POST:[NSString stringWithFormat:@"%@%@",POST_URL,@"/appAbroad/getChooseByYourselfModeList"] parameters:[self getParametersByParams:parameStr] sucess:^(id responseObject) {
        completionBlock(responseObject,nil);
    } failure:^(NSError *error) {
        completionBlock(nil,error);
    }];
    
}

+(void)getChooseByYourselfDetailWithTypeId:(NSString *)typeId
                                     andId:(NSString *)Id
                                completion:(void(^)(id responseObject,NSError *error))completionBlock
{
    NSString * parameStr = [XStringUtils jsonStringWithParameters:@{@"typeId":typeId,@"id":Id}];
    [self POST:[NSString stringWithFormat:@"%@%@",POST_URL,@"/appFinancial/getFinancialList"] parameters:[self getParametersByParams:parameStr] sucess:^(id responseObject) {
        completionBlock(responseObject,nil);
    } failure:^(NSError *error) {
        completionBlock(nil,error);
    }];
    
}

//FinanceProducts
+(void)getFinancialListWithPageSize:(NSString *)pageSize
                        andPageNumb:(NSString *)pageNum
                         currencyId:(NSString *)currencyId
                          consignId:(NSString *)consignId
                         completion:(void(^)(id responseObject,NSError *error))completionBlock
{
    NSString * parameStr = [XStringUtils jsonStringWithParameters:@{@"pageSize":pageSize,@"pageNum":pageNum,@"currencyId":currencyId,@"consignId":consignId}];
    [self POST:[NSString stringWithFormat:@"%@%@",POST_URL,@"/appFinancial/getFinancialList"] parameters:[self getParametersByParams:parameStr] sucess:^(id responseObject) {
        completionBlock(responseObject,nil);
    } failure:^(NSError *error) {
        completionBlock(nil,error);
    }];
    
}

+(void)getFinancialDetailWithId:(NSString *)Id
                     completion:(void(^)(id responseObject,NSError *error))completionBlock
{
    NSString * parameStr = [XStringUtils jsonStringWithParameters:@{@"id":Id}];
    [self POST:[NSString stringWithFormat:@"%@%@",POST_URL,@"/appFinancial/getFinancialDetail"] parameters:[self getParametersByParams:parameStr] sucess:^(id responseObject) {
        completionBlock(responseObject,nil);
    } failure:^(NSError *error) {
        completionBlock(nil,error);
    }];
    
}

+(void)getFundListWithPageSize:(NSString *)pageSize
                    andPageNum:(NSString *)pageNum
                        userId:(NSString *)userId
                    completion:(void(^)(id responseObject,NSError *error))completionBlock
{
    NSString * parameStr = [XStringUtils jsonStringWithParameters:@{@"pageSize":pageSize,@"pageNum":pageNum,@"userId":userId}];
    [self POST:[NSString stringWithFormat:@"%@%@",POST_URL,@"/appFinancial/getFundList"] parameters:[self getParametersByParams:parameStr] sucess:^(id responseObject) {
        completionBlock(responseObject,nil);
    } failure:^(NSError *error) {
        completionBlock(nil,error);
    }];
    
}


+(void)getFundDetailWithId:(NSString *)Id
                completion:(void(^)(id responseObject,NSError *error))completionBlock
{
    NSString * parameStr = [XStringUtils jsonStringWithParameters:@{@"id":Id}];
    [self POST:[NSString stringWithFormat:@"%@%@",POST_URL,@"/appFinancial/getFundDetail"] parameters:[self getParametersByParams:parameStr] sucess:^(id responseObject) {
        completionBlock(responseObject,nil);
    } failure:^(NSError *error) {
        completionBlock(nil,error);
    }];
    
}


+(void)getMetalsListWithPageSize:(NSString *)pageSize
                 andPageNumb:(NSString *)pageNum
                      typeId:(NSString *)typeId
                       ageId:(NSString *)ageId
                   purposeId:(NSString *)purposeId
                  supplierId:(NSString *)supplierId
                      userId:(NSString *)userId
                  completion:(void(^)(id responseObject,NSError *error))completionBlock
{
    NSString * parameStr = [XStringUtils jsonStringWithParameters:@{@"pageSize":pageSize,@"pageNum":pageNum,@"typeId":typeId,@"ageId":ageId,@"purposeId":purposeId,@"supplierId":supplierId,@"userId":userId}];
    [self POST:[NSString stringWithFormat:@"%@%@",POST_URL,@"/appFinancial/getMetalsList"] parameters:[self getParametersByParams:parameStr] sucess:^(id responseObject) {
        completionBlock(responseObject,nil);
    } failure:^(NSError *error) {
        completionBlock(nil,error);
    }];
    
}

+(void)getMetalsDetailWithId:(NSString *)Id
                  completion:(void(^)(id responseObject,NSError *error))completionBlock
{
    NSString * parameStr = [XStringUtils jsonStringWithParameters:@{@"id":Id}];
    [self POST:[NSString stringWithFormat:@"%@%@",POST_URL,@"/appFinancial/getMetalsDetail"] parameters:[self getParametersByParams:parameStr] sucess:^(id responseObject) {
        completionBlock(responseObject,nil);
    } failure:^(NSError *error) {
        completionBlock(nil,error);
    }];
    
}


+(void)getInsureListWithPageSize:(NSString *)pageSize
                      andPageNum:(NSString *)pageNum
                          userId:(NSString *)userId
                      completion:(void(^)(id responseObject,NSError *error))completionBlock
{
    NSString * parameStr = [XStringUtils jsonStringWithParameters:@{@"pageSize":pageSize,@"pageNum":pageNum,@"userId":userId}];
    [self POST:[NSString stringWithFormat:@"%@%@",POST_URL,@"/appFinancial/getInsureList"] parameters:[self getParametersByParams:parameStr] sucess:^(id responseObject) {
        completionBlock(responseObject,nil);
    } failure:^(NSError *error) {
        completionBlock(nil,error);
    }];
    
}

+(void)getInsureDetailWithId:(NSString *)Id
                  completion:(void(^)(id responseObject,NSError *error))completionBlock
{
    NSString * parameStr = [XStringUtils jsonStringWithParameters:@{@"id":Id}];
    [self POST:[NSString stringWithFormat:@"%@%@",POST_URL,@"/appFinancial/getInsureDetail"] parameters:[self getParametersByParams:parameStr] sucess:^(id responseObject) {
        completionBlock(responseObject,nil);
    } failure:^(NSError *error) {
        completionBlock(nil,error);
    }];
    
}

+(void)getMetalsOtherInfoWithAgeId:(NSString *)ageId
                            typeId:(NSString *)typeId
                         purposeId:(NSString *)purposeId
                        supplierId:(NSString *)supplierId
                        completion:(void(^)(id responseObject,NSError *error))completionBlock
{
    NSString * parameStr = [XStringUtils jsonStringWithParameters:@{@"ageId":ageId,@"typeId":typeId,@"purposeId":purposeId,@"supplierId":supplierId}];
    [self POST:[NSString stringWithFormat:@"%@%@",POST_URL,@"/appFinancial/getMetalsOtherInfo"] parameters:[self getParametersByParams:parameStr] sucess:^(id responseObject) {
        completionBlock(responseObject,nil);
    } failure:^(NSError *error) {
        completionBlock(nil,error);
    }];
    
}

//+(void)getFinancialOtherInfo


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










