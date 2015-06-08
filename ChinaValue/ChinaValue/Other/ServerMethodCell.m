//
//  ServerMethodCell.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/29.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "ServerMethodCell.h"

@implementation ServerMethodCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.isSelected=NO;   //默认为没有选中
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

@end
