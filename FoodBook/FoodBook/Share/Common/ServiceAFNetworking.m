//
//  ServiceAFNetworking.m
//  FoodBook
//
//  Created by sansali on 15/9/22.
//  Copyright © 2015年 sansali. All rights reserved.
//

#import "ServiceAFNetworking.h"

@implementation NSObject (AFNETWORK)

-(void)requestServiceGetWithURL:(NSString *)url withParam:(NSDictionary *)param success:(void (^)(AFHTTPRequestOperation *operation,id responseObject))success failure:(void(^)(AFHTTPRequestOperation *operation,NSError *error))failure{
    
     [[AFHTTPRequestOperationManager manager] GET:url parameters:param success:success failure:failure];
    
}
-(void)requestServicePOSTWithURL:(NSString *)url withParam:(NSDictionary *)param success:(void (^)(AFHTTPRequestOperation *operation,id responseObject))success failure:(void(^)(AFHTTPRequestOperation *operation,NSError *error))failure{
    
     [[AFHTTPRequestOperationManager manager] POST:url parameters:param success:success failure:failure];
    
}

-(void)requestServiceImgPOSTWithURL:(NSString *)url withParam:(NSDictionary *)param withImgArr:(NSArray *)imgs success:(void (^)(AFHTTPRequestOperation *operation,id responseObject))success failure:(void(^)(AFHTTPRequestOperation *operation,NSError *error))failure{

    
    
    
    
    
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // AFHTTPResponseSerializer就是正常的HTTP请求响应结果:NSData
    // 当请求的返回数据不是JSON,XML,PList,UIImage之外,使用AFHTTPResponseSerializer
    // 例如返回一个html,text...
    //
    // 实际上就是AFN没有对响应数据做任何处理的情况
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // formData是遵守了AFMultipartFormData的对象
    [manager POST:url parameters:param  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        //
                NSLog(@"完成 %@", @"fadsfas");
//        if (success) {
//            success(responseObject);
//        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"错误 %@", error.localizedDescription);
         }];
    
    
    
    
    
    
    
//    
//    
//    
//    
//    NSData *imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"boy_s.png"], 0.2);
//
////    NSDictionary *dic =@{参数};
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        //[formData appendPartWithFileData:imageData name:@"myfile1"fileName:@"boy_s.png"mimeType:@"image/png"];
//    }success:^(AFHTTPRequestOperation *operation,id responseObject) {
//        NSLog(@"fadsfasdfas");
//    }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
//        
//    }];
//    
//    
//    
//    return;
//    
//    
//    
//    
//    
////    
////    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
//    
//    
//    
//    NSData *imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"boy_s.png"], 0.2);
//    [manager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFileData :imageData name:@"myfile1" fileName:@"boy_s.png" mimeType:@"image/*"];
//
//    } success:success  failure:failure];
//    
//    [manager POST:url parameters:param BodyWithBlock:^(id<AFMultipartFormData> formData) {
    
        
//        
//        
//    } success:^(AFHTTPRequestOperation *operation,id responseObject) {
//        NSLog(@"Success: %@", responseObject);
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation,NSError *error) {
//        NSLog(@"Error: %@", error);
//        
//        
//    }];
    

    
    
    
    
    
}

@end
