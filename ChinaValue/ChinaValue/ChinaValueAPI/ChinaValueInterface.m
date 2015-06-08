//
//  MouseInterface.m
//  Mouse
//
//  Created by teamotto iOS dev team on 15/4/12.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "ChinaValueInterface.h"
#import "AFHTTPRequestOperation.h"

#import "JSONKit.h"
#import "urlFile.h"
#import "AESCrypt.h"
#import "GTMBase64.h"
#import "NSData+ZXAES.h"

#define TOKEN @"chinavaluetoken=abcdefgh01234567"

@implementation ChinaValueInterface
+(void)UserLoginParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure{
    [self PostWithParameters:UserLogin parameters:parameters success:success failure:failure];
}

+(void)UserResignParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure{
    [self PostWithParameters:UserResign parameters:parameters success:success failure:failure];
}

+(void)GetUserBasicInfoParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure{
    [self PostWithParameters:GetUserBasicInfo parameters:parameters success:success failure:failure];
}

+(void)GetBalanceParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure{
    [self PostWithParameters:GetBalance parameters:parameters success:success failure:failure];
}

+(void)GetTradeLogParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure{
    [self PostWithParameters:GetTradeLog parameters:parameters success:success failure:failure];
}

+(void)GetReqListParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure{
    [self PostWithParameters:GetReqList parameters:parameters success:success failure:failure];
}
+(void)GetReqDetailParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure{
    [self PostWithParameters:GetReqDetail parameters:parameters success:success failure:failure];
}

+(void)GetKspListPatameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure{
    [self PostWithParameters:GetKspList parameters:parameters success:success failure:failure];
}

+(void)KspReqListParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure{
    [self PostWithParameters:KspReqList parameters:parameters success:success failure:failure];
}

+(void)KspReqDetailPatameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure{
    [self PostWithParameters:KspReqDetail parameters:parameters success:success failure:failure];
}

+(void)KspApplyViewParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure{
    [self PostWithParameters:KspApplyView parameters:parameters success:success failure:failure];   //查看竞标详情
}

+(void)KspApplyCancelParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure{
    [self PostWithParameters:KspApplyCancel parameters:parameters success:success failure:failure];
}
+(void)KspReportViewParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure{
    [self PostWithParameters:KspReportView parameters:parameters success:success failure:failure];
}
+(void)CreditEditParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure{
    [self PostWithParameters:CreditEdit parameters:parameters success:success failure:failure];
}

//通过行业id号获得行业名称
+(void)GetIndustryParameters:(id)patameters success:(SuccessBlock)success failure:(FailureBlock)failure{
    [self PostWithParameters:GetIndustry parameters:patameters success:success failure:failure];
}


+(void)GeContactPatameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure{ //获取用户联系方式
    [self PostWithParameters:GeContact parameters:parameters success:success failure:failure];
}


+(void)KspServiceGetParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure{
    [self PostWithParameters:KspServiceGet parameters:parameters success:success failure:failure];
}

+(void)KspServiceEditParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure{
    [self PostWithParameters:KspServiceEdit parameters:parameters success:success failure:failure];
}

+(void)KspHonorListParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure{
    [self PostWithParameters:KspHonorList parameters:parameters success:success failure:failure];
}

+(void)KspHonorDeleteParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure{
    [self PostWithParameters:KspHonorDelete parameters:parameters success:success failure:failure];
}

+(void)UserEditBasicInfoParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [self PostWithParameters:UserEditBasicInfo parameters:parameters success:success failure:failure];
}

+(void)UserChangeAvatarParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [self PostWithParameters:UserChangeAvatar parameters:parameters success:success failure:failure];
}


+(void)BasicGetLocationListParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [self PostWithParameters:BasicGetLocationList parameters:parameters success:success failure:failure];
}

+(void)KnowGetFunctionParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [self PostWithParameters:KnowGetFunction parameters:parameters success:success failure:failure];
}



+(void)KnowCreditViewParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [self PostWithParameters:KnowCreditView parameters:parameters success:success failure:failure];
}


+(void)UserGetConnectionParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [self PostWithParameters:UserGetConnection parameters:parameters success:success failure:failure];
}


+(void)knowKspApplyParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [self PostWithParameters:knowKspApply parameters:parameters success:success failure:failure];
}

+(void)KnowGetIndustryListParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [self PostWithParameters:KnowGetIndustryList parameters:parameters success:success failure:failure];
}

+(void)KnowGetFunctionListParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [self PostWithParameters:KnowGetFunctionList parameters:parameters success:success failure:failure];
}

+(void)KnowKsbReqEditParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [self PostWithParameters:KnowKsbReqEdit parameters:parameters success:success failure:failure];
}

+(void)KnowKsbReqListParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [self PostWithParameters:KnowKsbReqList parameters:parameters success:success failure:failure];
}

+(void)KnowKsbReqDetailParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [self PostWithParameters:KnowKsbReqDetail parameters:parameters success:success failure:failure];
}

+(void)KnowKsbReqGetParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [self PostWithParameters:KnowKsbReqGet parameters:parameters success:success failure:failure];
}

+(void)KnowKsbCompetitorParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [self PostWithParameters:KnowKsbCompetitor parameters:parameters success:success failure:failure];
}

+(void)KnowKsbSetKspInitParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [self PostWithParameters:KnowKsbSetKspInit parameters:parameters success:success failure:failure];
}

+(void)KnowKsbSetKspByBalanceParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [self PostWithParameters:KnowKsbSetKspByBalance parameters:parameters success:success failure:failure];
}

+(void)KnowKsbSetKspByWechatParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [self PostWithParameters:KnowKsbSetKspByWechat parameters:parameters success:success failure:failure];
}


+(void)KnowKsbOrderEditParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [self PostWithParameters:KnowKsbOrderEdit parameters:parameters success:success failure:failure];
}

+(void)KnowKsbOrderViewParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [self PostWithParameters:KnowKsbOrderView parameters:parameters success:success failure:failure];
}

+(void)KnowKsbConfirmServiceEndParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [self PostWithParameters:KnowKsbConfirmServiceEnd parameters:parameters success:success failure:failure];
}

+(void)KnowKsbReportViewParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [self PostWithParameters:KnowKsbReportView parameters:parameters success:success failure:failure];
}

+(void)KnowKnowKsbInviteParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [self PostWithParameters:KnowKsbInvite parameters:parameters success:success failure:failure];
}

+(void)GetUserBlogListParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [self PostWithParameters:GetUserBlogList parameters:parameters success:success failure:failure];
}
+(void)GetUserBlogDetailParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [self PostWithParameters:GetUserBlogDetail parameters:parameters success:success failure:failure];
}
+(void)GetUserMiniBlogParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [self PostWithParameters:GetUserMiniBlog parameters:parameters success:success failure:failure];
}

+(void)KspHonorEditParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [self PostWithParameters:KspHonorEdit parameters:parameters success:success failure:failure];
}





















+(void)PostWithParameters:(NSString *)url parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure{
    
    NSString *dataUrl=[NSString stringWithFormat:@"%@%@",baseURL,url];
    [[self sharedManager]loadDataPostWithMethod:dataUrl withParameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str=[[NSString alloc]initWithData:responseObject  encoding:NSUTF8StringEncoding];//拿到加密了的数据
        //AES对str解密,生成res
        
        NSString *res=[NSData AES256Decrypt:str key:TOKEN];
        
        if (res) {
            id object=[res objectFromJSONString];
            if (!object) {
                NSError *error=[NSError errorWithDomain:@"数据错误" code:0 userInfo:nil];
                NSLog(@"数据错误");
                failure(operation,error);
            }else{
                success(operation,object);
            }
        }else{
            NSError *error=[NSError errorWithDomain:@"链接服务器失败" code:0 userInfo:nil];
            failure(operation,error);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSError *er=[NSError errorWithDomain:@"无法连接服务器" code:error.code userInfo:nil];
        failure(operation,er);
    }];
    
}

+(void)GetWithParameters:(NSString *)url parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure{
    NSString *dataUrl = [NSString stringWithFormat:@"%@%@",baseURL,url];
    [[self sharedManager]loadDataGetWithMethod:dataUrl withParameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if (str) {
            id object = [str objectFromJSONString];
            if (!object) {
                NSError *error = [NSError errorWithDomain:@"数据错误" code:0 userInfo:nil];
                failure(operation,error);
            }
            else
            {
                success(operation,object);
            }
        }
        else
        {
            NSError *error = [NSError errorWithDomain:@"链接服务器失败" code:0 userInfo:nil];
            failure(operation,error);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSError *er= [NSError errorWithDomain:@"无法连接服务器" code:error.code userInfo:nil];
        failure(operation,er);
    }];
}



@end
