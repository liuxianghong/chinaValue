//
//  UISearchBar+ZX.m
//  ChinaValue
//
//  Created by teamotto iOS dev team on 15/4/23.
//  Copyright (c) 2015年 teamotto iOS dev team. All rights reserved.
//

#import "UISearchBar+ZX.h"

@implementation UISearchBar (ZX)

//- (void)layoutSubviews {
//    UITextField *searchField;
//    if ([[[UIDevice currentDevice] systemVersion] floatValue]<7.0){
//        searchField=[self.subviews objectAtIndex:1];
//
//    }
//    else{
//         searchField=[((UIView *)[self.subviews objectAtIndex:0]).subviews lastObject];
//    }
//    
//    NSUInteger numViews = [self.subviews count];
//    for(int i = 0; i < numViews; i++) {
//        if([[self.subviews objectAtIndex:i] isKindOfClass:[UITextField class]]) {
//            searchField = [self.subviews objectAtIndex:i];
//        }
//    }
//    if(!(searchField == nil)) {
//        searchField.textColor = [UIColor whiteColor];
//        [searchField setBackground: [UIImage imageNamed:@"SearchBarBackground.png"] ];
//        [searchField setBorderStyle:UITextBorderStyleNone];
//    }
//    
//    [super layoutSubviews];
//}


-(void)setFrame:(CGRect)frame{
    frame=CGRectMake(70, 0, 210, 44);
    [super setFrame:frame];
    
}


@end
