//
//  LSDStatusViewCell.h
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/7/29.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSDStatusViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *ib_conView;
@property (weak, nonatomic) IBOutlet UILabel *ib_textLeft;
@property (weak, nonatomic) IBOutlet UILabel *ib_textCenter;
@property (weak, nonatomic) IBOutlet UILabel *ib_textRight;
@property (weak, nonatomic) IBOutlet UIImageView *ib_img_icon;

@property (weak, nonatomic) IBOutlet UIButton *ib_btnShowError;


@property (nonatomic,copy)void (^showPSDError) (NSInteger psId);

-(void)setData:(NSDictionary*)data;
@end
