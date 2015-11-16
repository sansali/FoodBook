//
//  ServiceAFNetworking.h
//  FoodBook
//
//  Created by sansali on 15/9/22.
//  Copyright © 2015年 sansali. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface NSObject (AFNETWORK)

-(void)requestServiceGetWithURL:(NSString *)url withParam:(NSDictionary *)param success:(void (^)(AFHTTPRequestOperation *operation,id responseObject))success failure:(void(^)(AFHTTPRequestOperation *operation,NSError *error))failure;

-(void)requestServicePOSTWithURL:(NSString *)url withParam:(NSDictionary *)param success:(void (^)(AFHTTPRequestOperation *operation,id responseObject))success failure:(void(^)(AFHTTPRequestOperation *operation,NSError *error))failure;

-(void)requestServiceImgPOSTWithURL:(NSString *)url withParam:(NSDictionary *)param withImgArr:(NSArray *)imgs success:(void (^)(AFHTTPRequestOperation *operation,id responseObject))success failure:(void(^)(AFHTTPRequestOperation *operation,NSError *error))failure;

@end
