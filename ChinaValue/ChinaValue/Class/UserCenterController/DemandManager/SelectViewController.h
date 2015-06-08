//
//  SelectViewController.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/28.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectViewDelegate <NSObject>

//把选中的按钮数组通过协议方法传递到父视图中去
-(void)selectWithDic:(NSMutableDictionary *)dic;

@end
@interface SelectViewController : UIViewController

@property(nonatomic,strong)id<SelectViewDelegate> delegate;
@property (nonatomic,strong) NSMutableDictionary *dic;
@property (nonatomic) NSInteger type;
@property (nonatomic) NSInteger mun;
@end
