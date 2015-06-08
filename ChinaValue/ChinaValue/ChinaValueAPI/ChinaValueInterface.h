//
//  MouseInterface.h
//  Mouse
//
//  Created by teamotto iOS dev team on 15/4/12.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "ChinaValueHttpRequestOperationManager.h"
typedef void (^SuccessBlock)(AFHTTPRequestOperation *operation,id responseObject);
typedef void(^FailureBlock)(AFHTTPRequestOperation *operation,NSError *error);

@interface ChinaValueInterface : ChinaValueHttpRequestOperationManager
+(void)UserLoginParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)UserResignParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)GetUserBasicInfoParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)GetBalanceParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

//收入支出明细
+(void)GetTradeLogParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;


+(void)GetReqListParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)GetReqDetailParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)GetKspListPatameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)KspReqListParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)KspReqDetailPatameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)KspApplyViewParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)KspApplyCancelParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)KspReportViewParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)CreditEditParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)GetIndustryParameters:(id)patameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)GeContactPatameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)KspServiceGetParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)KspServiceEditParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)KspHonorListParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)KspHonorDeleteParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;


+(void)UserEditBasicInfoParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;


+(void)UserChangeAvatarParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)BasicGetLocationListParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)KnowGetFunctionParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)KnowCreditViewParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)UserGetConnectionParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)knowKspApplyParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)KnowGetIndustryListParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)KnowGetFunctionListParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)KnowKsbReqEditParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)KnowKsbReqListParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)KnowKsbReqDetailParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)KnowKsbReqGetParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)KnowKsbCompetitorParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)KnowKsbSetKspInitParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)KnowKsbSetKspByBalanceParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)KnowKsbSetKspByWechatParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)KnowKsbOrderEditParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)KnowKsbOrderViewParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)KnowKsbConfirmServiceEndParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)KnowKsbReportViewParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)KnowKnowKsbInviteParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)GetUserBlogListParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;
+(void)GetUserBlogDetailParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;
+(void)GetUserMiniBlogParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)KspHonorEditParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;



@end
