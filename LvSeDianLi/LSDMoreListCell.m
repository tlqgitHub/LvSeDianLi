//
//  LSDMoreListCell.m
//  LvSeDianLi
//
//  Created by TianLinqiang on 2017/1/21.
//  Copyright © 2017年 TianLinqiang. All rights reserved.
//

#import "LSDMoreListCell.h"

#import "NSDictionary+SafeAccess.h"
#import "ACMacros.h"

@implementation LSDMoreListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ViewRadius(self.ib_view, 4);
    
    self.ib_title.font = [UIFont systemFontOfSize:14.0f];
    self.ib_title.textColor = UIColorFromRGB(0x378261);
//    self.ib_title.textColor = [UIColor colorWithRed:90/255.0 green:117/255.0 blue:84/255.0 alpha:1];
    self.ib_title.textAlignment = NSTextAlignmentLeft;
    
    self.ib_text31.font = [UIFont systemFontOfSize:14.0f];
    self.ib_text31.textColor = UIColorFromRGB(0x5f7650);
    self.ib_text31.textAlignment = NSTextAlignmentLeft;
    self.ib_isRead.text = LocalString(@"未读");
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setData:(NSDictionary *)data withType:(NSString*)type
{
//    self.ib_text31.pauseInterval = 1.0;
    [self.ib_text31 scrollLabelIfNeeded];
    
    self.ib_title.text = [data stringForKey:@"ps_name"];
    
    self.ib_isRead.hidden = [data boolForKey:@"isRead"];
    
    if([type isEqualToString:@"GetGuzhang"])
    {
        self.ib_text10.text = LocalString(@"名称");
        self.ib_text20.text = LocalString(@"发生时间");
        self.ib_text30.text = LocalString(@"故障内容");
        
        self.ib_text11.text = [data stringForKey:@"device_name"];
        self.ib_text21.text = [data stringForKey:@"error_time"];
        self.ib_text31.text = [data stringForKey:@"error_message"];

        
    }else if ([type isEqualToString:@"GetDixiao_Shebei"])//Gaojing
    {
        
        self.ib_text10.text = LocalString(@"名称");
        self.ib_text20.text = LocalString(@"效率");
        self.ib_text30.text = LocalString(@"发生日期");
        
        self.ib_text11.text = [data stringForKey:@"device_name"];
        self.ib_text21.text = [NSString stringWithFormat:@"%@%@", [data stringForKey:@"Efficiency"], @"%"];
        self.ib_text31.text = [data stringForKey:@"lastDataTime"];
        
    }
    //GetDixiao_Dianzhan
    else if ([type isEqualToString:@"GetDixiao_Dianzhan"])//Gaojing
    {
        
        self.ib_text10.text = LocalString(@"效率");
        self.ib_text20.text = LocalString(@"发生日期");
//        self.ib_text30.text = LocalString(@"发生日期");
        self.ib_text30.hidden = YES;
        
        self.ib_text11.text = [NSString stringWithFormat:@"%@%@", [data stringForKey:@"Efficiency"], @"%"];
        self.ib_text21.text = [data stringForKey:@"lastDataTime"];
//        self.ib_text31.text = [data stringForKey:@"lastDataTime"];
        self.ib_text31.hidden = YES;
        
    }
    //GetTingji_Dianzhan
    else if ([type isEqualToString:@"GetTingji_Dianzhan"])//Gaojing
    {
        
        self.ib_text10.text = LocalString(@"发生日期");
//        self.ib_text20.text = LocalString(@"效率");
//        self.ib_text30.text = LocalString(@"发生日期");
        self.ib_text20.hidden = YES;
        self.ib_text30.hidden = YES;
        
        self.ib_text11.text = [data stringForKey:@"lastDataTime"];
//        self.ib_text21.text = [data stringForKey:@"Efficiency"];
//        self.ib_text31.text = [data stringForKey:@"lastDataTime"];
        self.ib_text21.hidden = YES;
        self.ib_text31.hidden = YES;
    }
    //GetTingji_Shebei
    else if ([type isEqualToString:@"GetTingji_Shebei"])//Gaojing
    {
        
        self.ib_text10.text = LocalString(@"名称");
        self.ib_text20.text = LocalString(@"发生日期");
//        self.ib_text30.text = LocalString(@"发生日期");
        self.ib_text30.hidden = YES;
        
        self.ib_text11.text = [data stringForKey:@"device_name"];
        self.ib_text21.text = [data stringForKey:@"lastDataTime"];
//        self.ib_text31.text = [data stringForKey:@"lastDataTime"];
        self.ib_text31.hidden = YES;
    }
    //GetLixian_Shebei
    else if ([type isEqualToString:@"GetLixian_Shebei"])//Gaojing
    {
        
        self.ib_text10.text = LocalString(@"名称");
        self.ib_text20.text = LocalString(@"发生时间");
//        self.ib_text30.text = LocalString(@"发生日期");
        self.ib_text30.hidden = YES;
        
        self.ib_text11.text = [data stringForKey:@"device_name"];
        self.ib_text21.text = [data stringForKey:@"pmu_lasttime"];
//        self.ib_text31.text = [data stringForKey:@"device_lasttime"];
        self.ib_text31.hidden = YES;

    }
    //GetLixian_Caijiqi
    else if ([type isEqualToString:@"GetLixian_Caijiqi"])//Gaojing
    {
        
        self.ib_text10.text = LocalString(@"序列号");
        self.ib_text20.text = LocalString(@"发生时间");
//        self.ib_text30.text = LocalString(@"发生时间");
        self.ib_text30.hidden = YES;
        
        self.ib_text11.text = [data stringForKey:@"pmu_sn"];
        self.ib_text21.text = [data stringForKey:@"pmu_lasttime"];
//        self.ib_text31.text = [data stringForKey:@"pmu_lasttime"];
        self.ib_text31.hidden = YES;
        
    }
    else{
        
    }
}

@end
