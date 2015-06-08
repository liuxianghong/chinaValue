//
//  ServerDetailHeader.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/5/8.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServerDetailHeader : UITableViewHeaderFooterView
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UILabel *date;


-(void)loadDataWithDic:(NSDictionary *)dic;
@end
