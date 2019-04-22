//
//  LSDPage8Cell.h
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/7/30.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSDPage8Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *ib_textLeft;

@property (weak, nonatomic) IBOutlet UILabel *ib_textCenter;

@property (weak, nonatomic) IBOutlet UILabel *ib_textRight;

@property (weak, nonatomic) IBOutlet UILabel *ib_textShow;

@property (weak, nonatomic) IBOutlet UIImageView *ib_imgStatus;

-(void)setData:(NSDictionary*)data;

-(void)setData:(NSDictionary*)data max:(CGFloat) maxF;
@end
