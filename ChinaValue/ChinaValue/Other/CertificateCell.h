//
//  CertificateCell.h
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/24.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CertificateCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleText;
@property (weak, nonatomic) IBOutlet UILabel *Date;

@property (weak, nonatomic) IBOutlet UILabel *describleText;

@property (weak, nonatomic) IBOutlet UIImageView *CertificateImage1;
@property (weak, nonatomic) IBOutlet UIImageView *CertificateImage2;
@property (weak, nonatomic) IBOutlet UIButton *changeImButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteImButton;

@end
