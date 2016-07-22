//
//  NetRequest.h
//  三方网络请求
//
//  Created by Iracle Zhang on 6/6/16.
//  Copyright © 2016 Iracle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetRequest : NSObject
//userLogin
+(void)userLoginWithUsername:(NSString *)sUsername
                    password:(NSString *)sPassword
                  completion:(void(^)(id responseObject,NSError *error))completionBlock;


//abroadService
+(void)getMealsListWithPageSize:(NSString *)pageSize
                    andPageNumb:(NSString *)pageNum
                      andUserId:(NSString *)userId
                     completion:(void(^)(id responseObject,NSError *error))completionBlock;

+(void)getPolicyAdviceListWithPageSize:(NSString *)pageSize
                           andPageNumb:(NSString *)pageNum
                               byTitle:(NSString *)byTitle
                            byKeyWords:(NSString *)byKeyWords
                            completion:(void(^)(id responseObject,NSError *error))completionBlock;

+(void)getChooseByYourselfDetailWithTypeId:(NSString *)typeId
                                     andId:(NSString *)Id
                                completion:(void(^)(id responseObject,NSError *error))completionBlock;

+(void)getChooseByYourselfModeListWithPageSize:(NSString *)pageSize
                                   andPageNumb:(NSString *)pageNum
                                        TypeId:(NSString *)typeId
                                        userId:(NSString *)userId
                                    completion:(void(^)(id responseObject,NSError *error))completionBlock;



//FinanceProducts
+(void)getFinancialListWithPageSize:(NSString *)pageSize
                        andPageNumb:(NSString *)pageNum
                         currencyId:(NSString *)currencyId
                          consignId:(NSString *)consignId
                         completion:(void(^)(id responseObject,NSError *error))completionBlock;
+(void)getFinancialDetailWithId:(NSString *)Id
                     completion:(void(^)(id responseObject,NSError *error))completionBlock;

+(void)getFundListWithPageSize:(NSString *)pageSize
                    andPageNum:(NSString *)pageNum
                        userId:(NSString *)userId
                    completion:(void(^)(id responseObject,NSError *error))completionBlock;
+(void)getFundDetailWithId:(NSString *)Id
                completion:(void(^)(id responseObject,NSError *error))completionBlock;

+(void)getMetalsListWithPageSize:(NSString *)pageSize
                 andPageNumb:(NSString *)pageNum
                      typeId:(NSString *)typeId
                       ageId:(NSString *)ageId
                   purposeId:(NSString *)purposeId
                  supplierId:(NSString *)supplierId
                      userId:(NSString *)userId
                  completion:(void(^)(id responseObject,NSError *error))completionBlock;
+(void)getMetalsDetailWithId:(NSString *)Id
                  completion:(void(^)(id responseObject,NSError *error))completionBlock;




//GET
+(void)GET:(NSString *)url parameters:(NSDictionary *)parameters sucess:(void(^)(id responseObject)) sucess failure:(void(^)(NSError *error)) failure;

//POST
+(void)POST:(NSString *)url parameters:(NSDictionary *)parameters sucess:(void(^)(id responseObject)) sucess failure:(void(^)(NSError *error)) failure;
+(NSDictionary *)getParametersByParams:(NSString *)paramJson;
@end








