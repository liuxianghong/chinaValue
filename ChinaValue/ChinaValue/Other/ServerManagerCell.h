//
//  ServerManagerCell.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/24.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServerManagerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *headText;
@property (weak, nonatomic) IBOutlet UILabel *statusText;
@property (weak, nonatomic) IBOutlet UILabel *numberText;
@property (weak, nonatomic) IBOutlet UILabel *releaseTime;

@property (weak, nonatomic) IBOutlet UIButton *detail;
@property (weak, nonatomic) IBOutlet UILabel *deadline;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;
- (IBAction)detail:(id)sender;

-(void)setterDataWith:(NSString *)headText statisText:(NSString *)statusText numberText:(NSString *)numberText releaseTime:(NSString *)releaseTime deadline:(NSString *)deadline;
@end
