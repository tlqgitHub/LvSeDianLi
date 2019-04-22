//
//  LSDPage8HeadCell.m
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/8/1.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import "LSDPage8HeadCell.h"
#import "NSDictionary+SafeAccess.h"
#import "ACMacros.h"

@implementation LSDPage8HeadCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setData:(NSDictionary*)data lastDic:(NSDictionary*)lastData
{
    ViewBorderRadius(self.ib_contentView, 5, 1, [UIColor whiteColor]);
    
    self.ib_textLeft.text = [data stringForKey:@"CustomName"].length>0?[data stringForKey:@"CustomName"]:[data stringForKey:@"InverterId"];
    
//    self.ib_textRight.text = lastData?[NSString stringWithFormat:@"%@ kW", [lastData stringForKey:@"inverter_value"]]:@"0.0 kW";
    
    NSString *string = lastData?[NSString stringWithFormat:@"%@ kW", [lastData stringForKey:@"inverter_value"]]:@"0.0 kW";
    
    self.ib_textRight.attributedText = [self attributeString:string rangeStringLenth:2 font:[UIFont systemFontOfSize:10.0] value:[UIColor colorWithRed:16/255.0 green:116/255.0 blue:85/255.0 alpha:1.0]];
    
}

- (NSMutableAttributedString*)attributeString:(NSString*)string rangeStringLenth:(NSInteger)apartStrLength font:(UIFont*)aFont value:(UIColor*)aColor
{
    NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange firstRange = NSMakeRange(string.length-apartStrLength, apartStrLength);
    
    [attributeStr addAttributes:@{NSForegroundColorAttributeName:aColor, NSFontAttributeName:aFont} range:firstRange];
    
//    NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc] initWithString:string];
//    NSRange firstRange = NSMakeRange(string.length-apartStrLength, apartStrLength);
//    [attributeStr addAttribute:NSFontAttributeName value:aFont range:firstRange];
    return attributeStr;
}
@end
