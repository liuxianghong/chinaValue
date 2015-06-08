//
//  ServerManagerCell.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/24.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "ServerManagerCell.h"

@implementation ServerManagerCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setterDataWith:(NSString *)headText statisText:(NSString *)statusText numberText:(NSString *)numberText releaseTime:(NSString *)releaseTime deadline:(NSString *)deadline{
    [self.headText setText:headText];
    [self.statusText setText:statusText];
    [self.numberText setText:numberText];
    [self.releaseTime setText:releaseTime];
    [self.deadline setText:deadline];
    
}

- (IBAction)detail:(id)sender {
}
@end
