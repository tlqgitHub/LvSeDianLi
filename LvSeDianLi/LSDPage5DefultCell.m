//
//  LSDPage5DefultCell.m
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/7/29.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import "LSDPage5DefultCell.h"
#import "ACMacros.h"
#import "NSDictionary+SafeAccess.h"


@implementation LSDPage5DefultCell

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
    self.ib_textLeft.text = [data stringForKey:@"title"];
    NSArray *StrArr = [[data stringForKey:@"value"] componentsSeparatedByString:@"\t"];
    self.ib_textValue.text = StrArr?StrArr[0]:@"";
    self.ib_textRight.text = (StrArr.count==2)?[self rePlaceStr:StrArr[1]]:@"";
}

-(NSString *)rePlaceStr:(NSString*)str
{
    NSString * tmpStr = str;
//    NSRange range;
//    
//    range = [tmpStr rangeOfString:@"万元"];//判断字符串是否包含
//    //if (range.location ==NSNotFound)//不包含
//    if (range.length >0)//包含
//    {
//        tmpStr = [tmpStr stringByReplacingOccurrencesOfString:@"万元" withString:LocalString(@"万元")];
//        return tmpStr;
//    }
//    
//    range = [tmpStr rangeOfString:@"元"];//判断字符串是否包含
//    //if (range.location ==NSNotFound)//不包含
//    if (range.length >0)//包含
//    {
//        tmpStr = [tmpStr stringByReplacingOccurrencesOfString:@"元" withString:LocalString(@"元")];
//        return tmpStr;
//    }

    return tmpStr;
}
@end
