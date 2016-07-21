//
//  NetRequest.h
//  三方网络请求
//
//  Created by Iracle Zhang on 6/6/16.
//  Copyright © 2016 Iracle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetRequest : NSObject

+(void)userLoginWithUsername:(NSString *)sUsername
                    password:(NSString *)sPassword
                  completion:(void(^)(id responseObject,NSError *error))completionBlock;

//GET
+(void)GET:(NSString *)url parameters:(NSDictionary *)parameters sucess:(void(^)(id responseObject)) sucess failure:(void(^)(NSError *error)) failure;

//POST
+(void)POST:(NSString *)url parameters:(NSDictionary *)parameters sucess:(void(^)(id responseObject)) sucess failure:(void(^)(NSError *error)) failure;
+(NSDictionary *)getParametersByParams:(NSString *)paramJson;
@end








