//
//  LSDErrorViewCell.h
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/7/30.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CBAutoScrollLabel.h"

@interface LSDErrorViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *ib_baseView;
@property (weak, nonatomic) IBOutlet UILabel *ib_title1;
@property (weak, nonatomic) IBOutlet UILabel *ib_value1;

@property (weak, nonatomic) IBOutlet UILabel *ib_title2;
@property (weak, nonatomic) IBOutlet UILabel *ib_value2;

@property (weak, nonatomic) IBOutlet UILabel *ib_title3;
@property (weak, nonatomic) IBOutlet UILabel *ib_value3;

@property (weak, nonatomic) IBOutlet UILabel *ib_title4;
@property (weak, nonatomic) IBOutlet UILabel *ib_value4;

@property (weak, nonatomic) IBOutlet UILabel *ib_title5;
@property (weak, nonatomic) IBOutlet UILabel *ib_value5;

@property (weak, nonatomic) IBOutlet CBAutoScrollLabel *ib_lbpaomaName;


-(void)setData:(NSDictionary*)data;
@end
