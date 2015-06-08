//
//  MyCell.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/22.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
              
    }
    return self;
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

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
