//
//  UserAcconutCell.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/23.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "UserAcconutCell.h"

@implementation UserAcconutCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
       // self.backgroundColor=nil; //清除cell的默认背景色
        
        //        _imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"p2-06.png"]];
        //        _imageView.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-2);
        //        _imageView.alpha=0.6f;
        //        self.backgroundView=_imageView;
        //
        
        
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark 重写此方法改变内部imageView的位置大小
- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame=CGRectMake(10, 10, 25, 25);
    self.imageView.contentMode =UIViewContentModeScaleAspectFit;
    
    self.textLabel.frame=CGRectMake(45, 10, 200, 25);
    self.textLabel.font=[UIFont systemFontOfSize:13.0];
    self.textLabel.contentMode=UIViewContentModeScaleAspectFit;
}


//#pragma mark 自定义accessory的设置
//-(void)accessoryWithText:(NSString *)text{
//    UILabel *label=[[UILabel alloc]init];
//    label.font=[UIFont systemFontOfSize:13.0f];
//    label.textAlignment=NSTextAlignmentCenter;
//    label.textColor=[UIColor whiteColor];
//    label.bounds=CGRectMake(0, 0, 80, 44);
//    label.text=text;
//    self.accessoryView=label;
//}




@end
