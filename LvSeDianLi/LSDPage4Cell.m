//
//  LSDPage4Cell.m
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/7/16.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import "LSDPage4Cell.h"
#import "NSDictionary+SafeAccess.h"
#import "NSDate+Extension.h"
#import "ACMacros.h"

@implementation LSDPage4Cell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    
    self.ib_lbTitle.textColor = [UIColor colorWithRed:90/255.0 green:117/255.0 blue:84/255.0 alpha:1];
}

-(void)setData:(NSDictionary*)data
{
    self.ib_lbTitle.text = [data stringForKey:@"Name"];
    
    self.ib_lbKwh.attributedText = [self attributeString:[NSString stringWithFormat:@"%@:%.1f kW", LocalString(@"功率"),[data floatForKey:@"pac"]] rangeString:[NSString stringWithFormat:@"%.1f",[data floatForKey:@"pac"]] value:[UIColor colorWithRed:253/255.0 green:137/255.0 blue:0/255.0 alpha:1.0]];
//    text =
//    [NSString stringWithFormat:@"%@:%.1f kW", LocalString(@"功率"),[data floatForKey:@"pac"]];
//    attributedText =
//    [self attributeString:[NSString stringWithFormat:@"%@:%.1f kW", LocalString(@"功率"),[data floatForKey:@"pac"]] rangeStringLenth:2 font:[UIFont systemFontOfSize:10.0] value:[UIColor whiteColor]];
    
    
    self.ib_lbTime.text = [NSString stringWithFormat:@"%@:%@", LocalString(@"时间"),[self time2Date:[data stringForKey:@"LastTime"]]];
    
    NSString *imageName;
    
//    0 是green   1和2是gry  3 是 yellow   4 是red , 5 是half
    if ([[data stringForKey:@"Status"] isEqualToString:@"不在线"]) {//1
        imageName = @"alarm_gry.png";
    }else if ([[data stringForKey:@"Status"] isEqualToString:@"通信异常"]) {//2
        imageName = @"alarm_gry.png";
    }else if ([[data stringForKey:@"Status"] isEqualToString:@"停机"]) {//3
        imageName = @"alarm_yellow.png";
    }else if ([[data stringForKey:@"Status"] isEqualToString:@"故障"]) {//4
        imageName = @"alarm_red.png";
    }else if ([[data stringForKey:@"Status"] isEqualToString:@"部分停机"]) {//5
        imageName = @"alarm_half.png";
    }else if ([[data stringForKey:@"Status"] isEqualToString:@"设备离线"]) {//7
        imageName = @"alarm_brown.png";
    }else if ([[data stringForKey:@"Status"] isEqualToString:@"-"]) {//7
        imageName = @"alarm_heng.png";
    }else {//0
        imageName = @"alarm_green.png";
    }
    
    [self.ib_imageStyle setImage:[UIImage imageNamed:imageName]];
}

//2015/7/16 19:10:37
//yyyy-MM-dd/HH:mm:ss
//+ (NSUInteger)daysAgo:(NSDate *)date;
//+ (NSDate *)dateWithString:(NSString *)string format:(NSString *)format;
-(NSString*)time2Date:(NSString*)dateStr
{
    NSDate *tmpdate = [NSDate dateWithString:dateStr format:@"yyyy/MM/dd HH:mm:ss"];
    
    NSInteger datAgo = [NSDate daysAgo:tmpdate];
    
    if (datAgo>=365) {
        return LocalString(@"1年前");
    }else if(datAgo<365 && datAgo>=1){
        return [NSString stringWithFormat:@"%zd%@", datAgo, LocalString(@"日前")];
    }else{
        if ([tmpdate isToday]) {
            return [tmpdate stringWithFormat:@"HH:mm"];
        }else{
            return LocalString(@"1日前");
        }
        
    }
    return @"";
}

- (NSMutableAttributedString*)attributeString:(NSString*)string rangeStringLenth:(NSInteger)apartStrLength font:(UIFont*)aFont value:(UIColor*)aColor
{
    NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange firstRange = NSMakeRange(string.length-apartStrLength, apartStrLength);
    
    [attributeStr addAttributes:@{NSForegroundColorAttributeName:aColor, NSFontAttributeName:aFont} range:firstRange];
    return attributeStr;
}

- (NSMutableAttributedString*)attributeString:(NSString*)string rangeString:(NSString*)apartString value:(UIColor*)aColor
{
    NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange firstRange = [string rangeOfString:apartString];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:aColor range:firstRange];
    return attributeStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
