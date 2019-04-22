//
//  LSDPage6Cell.m
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/7/30.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import "LSDPage6Cell.h"
#import "NSDictionary+SafeAccess.h"

//赵宇 2016/7/19 13:52:08
//
//天气接口：
//http://服务器地址/getdata.ashx?param=GetNewWeather|9564
//
//http:/服务器地址/www.lvsedianli.com:8080/iosservice.aspx?param=GetNewWeather*9564
//
//赵宇 2016/7/19 13:52:23
//
//以中国服务器为例，就是
//http://www.lvsedianli.com:8080/getdata.ashx?param=GetNewWeather|9564
//
//http://www.lvsedianli.com:8080/iosservice.aspx?param=GetNewWeather*9564
//
//赵宇 2016/7/19 13:53:38
//
//安卓苹果爱用哪个用哪个，传进去的9564那个参数的地方是电站ID。返回值都一样的

@implementation LSDPage6Cell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//dataArr = @[@{@"title":LocalString(@"日照"),
//              @"image":@"page6_sunshine",
//              @"value":[data stringForKey:@"Irr"]},
//            @{@"title":LocalString(@"环境温度"),
//              @"image":@"page6_littlesun",
//              @"value":[data stringForKey:@"Sur_tem"]},
//            @{@"title":LocalString(@"背板温度"),
//              @"image":@"page6_banwen",
//              @"value":[data stringForKey:@"Battery_tem"]},
//            @{@"title":LocalString(@"峰值日照时数"),
//              @"image":@"page6_sunhours",
//              @"value":[data stringForKey:@"DayIrr"]}
//            ];
-(void)setData:(NSDictionary*)data
{
    self.ib_textLeft.text = [data stringForKey:@"title"];
    self.ib_textRight.text = [data stringForKey:@"value"];
    [self.ib_imgStatus setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [data stringForKey:@"image"]]]];
}

@end
