//
//  ExplainText.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/12.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//
// 数据解密类
#import "ExplainText.h"
#import "NSData+ZXAES.h"
#define TOKEN @"chinavaluetoken=abcdefgh01234567"
@implementation ExplainText
#pragma mark -解密数据
+(NSDictionary *)explainDataWith:(id)responseObject{
    NSDictionary *dict=responseObject;
    NSArray  *dataArray=[dict objectForKey:@"ChinaValue"];
    NSDictionary *dataDic=dataArray[0];
    
    return dataDic;
}

//里面有多条数据的话
-(NSMutableArray *)explainManyDataWith:(id)responseObject{
    NSMutableArray *dataList=[[NSMutableArray alloc]init];
    NSDictionary *dic=responseObject;
    NSArray *dataArray=[dic objectForKey:@"ChinaValue"];
    
    for (NSInteger i=0; i<[dataArray count]; i++) {
        NSDictionary *dataDic=dataArray[i];
        [dataList addObject:dataDic];
    }
    
    return dataList;
}

+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}
@end
