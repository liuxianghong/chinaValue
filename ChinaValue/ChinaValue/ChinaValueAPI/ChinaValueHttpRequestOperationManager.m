//
//  MouseHttpRequestOperationManager.m
//  Mouse
//
//  Created by teamotto iOS dev team on 15/4/10.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "ChinaValueHttpRequestOperationManager.h"
#import <Foundation/Foundation.h>
#import "JSONKit.h"
@implementation ChinaValueHttpRequestOperationManager
+(ChinaValueHttpRequestOperationManager *)sharedManager{
    static ChinaValueHttpRequestOperationManager *_sharedManager=nil;
    static dispatch_once_t _onceOperation;
    dispatch_once(&_onceOperation, ^{
        _sharedManager=[[self manager]initWithBaseURL:nil];
        _sharedManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        //_sharedManager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [_sharedManager.responseSerializer setStringEncoding:NSUTF8StringEncoding];
//        [_sharedManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
   //     [_sharedManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"text/plain"]];
    });
    return _sharedManager;
}
-(void)loadDataGetWithMethod:(NSString *)method withParameters:(id)patameters success:(SuccessBlock)success failure:(FailureBlock)failure{
    NSString *urlString = [NSString stringWithFormat:@"%@",method];
    [[ChinaValueHttpRequestOperationManager sharedManager]GET:urlString parameters:patameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            success(operation, responseObject);
        }
        else{
            NSError *error = [NSError errorWithDomain:@"Empty" code:0 userInfo:nil];
            failure(operation, error);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation, error);
    }];

    
}
-(void)loadDataPostWithMethod:(NSString *)method withParameters:(id)patameters success:(SuccessBlock)success failure:(FailureBlock)failure{
    NSString *urlString = [NSString stringWithFormat:@"%@",method];
    [[ChinaValueHttpRequestOperationManager sharedManager]POST:urlString parameters:patameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            success(operation, responseObject);
        }
        else{
            NSError *error = [NSError errorWithDomain:@"Empty" code:0 userInfo:nil];
            NSLog(@"Domain is Empty");
            failure(operation, error);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"operation is:%@",operation);
        NSLog(@"sharedManager is failure");
        NSLog(@"error detail is:%@",error);
        failure(operation, error);
    }];

    
}

@end
