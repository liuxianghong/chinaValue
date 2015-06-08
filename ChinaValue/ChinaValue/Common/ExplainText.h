//
//  ExplainText.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/12.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExplainText : NSObject
+(NSDictionary *)explainDataWith:(id)responseObject;
-(NSMutableArray *)explainManyDataWith:(id)responseObject;
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
@end
