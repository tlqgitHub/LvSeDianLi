//
//  LSDErrorViewCell.m
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/7/30.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import "LSDErrorViewCell.h"
#import "ACMacros.h"
#import "NSDictionary+SafeAccess.h"
@implementation LSDErrorViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setData:(NSDictionary*)data
{
    ViewRadius(self.ib_baseView, 4);
    
    self.ib_title1.text = LocalString(@"刷新时间：");
    self.ib_title2.text = LocalString(@"设备名称：");
    self.ib_title3.text = LocalString(@"设备型号：");
    self.ib_title4.text = LocalString(@"地址码：");
    self.ib_title5.text = LocalString(@"故障信息：");
    
    self.ib_value1.text = [data stringForKey:@"error_time"];
    self.ib_value2.text = [data stringForKey:@"device_name"];
    self.ib_value3.text = [data stringForKey:@"model_name"];
    self.ib_value4.text = [data stringForKey:@"address_number"];
//    self.ib_value5.text = [data stringForKey:@"error_message"];
    
    self.ib_lbpaomaName.text = [data stringForKey:@"error_message"];
    self.ib_lbpaomaName.font = [UIFont systemFontOfSize:12.0f];
    self.ib_lbpaomaName.textColor = [UIColor colorWithRed:255/255.0 green:48/255.0 blue:15/255.0 alpha:1];
    
}
@end
