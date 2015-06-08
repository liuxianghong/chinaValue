//
//  ChinaValueHttpRequestOperationManager.h
//  Mouse
//
//  Created by teamotto iOS dev team on 15/4/10.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
typedef void (^SuccessBlock)(AFHTTPRequestOperation *operation,id responseObject);
typedef void (^FailureBlock)(AFHTTPRequestOperation *operation,NSError *error);

@interface ChinaValueHttpRequestOperationManager : AFHTTPRequestOperationManager
+(ChinaValueHttpRequestOperationManager *)sharedManager;
-(void)loadDataPostWithMethod:(NSString *)method withParameters:(id)patameters success:(SuccessBlock)success failure:(FailureBlock)failure;
-(void)loadDataGetWithMethod:(NSString *)method withParameters:(id)patameters success:(SuccessBlock)success failure:(FailureBlock)failure;
@end
