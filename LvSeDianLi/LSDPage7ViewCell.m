//
//  LSDPage7ViewCell.m
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/8/1.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import "LSDPage7ViewCell.h"

#import "UIButton+Block.h"
#import "NSDate+Addition.h"
#import "ACMacros.h"
#import "NSDictionary+SafeAccess.h"

@interface LSDPage7ViewCell ()
{
    NSArray *dataArr;
}

@end

@implementation LSDPage7ViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDefultIndex:(NSInteger)defultIndex
                 show:(NSArray*)arr
                block:(selectAction)selectBlock;
{
//    NSDictionary *last = @{};
//    
//    if(arr&&arr.count>0)
//    {
//        last = [arr lastObject];
//    }
    
    //初始化
    ViewBorderRadius(self.ib_btn0, 0, 1, RGBCOLOR(29, 131, 107));
    ViewBorderRadius(self.ib_btn1, 0, 1, RGBCOLOR(29, 131, 107));
    ViewBorderRadius(self.ib_btn2, 0, 1, RGBCOLOR(29, 131, 107));
    
    ViewRadius(self.ib_lbViews, 3);
    
    [self.ib_btn0 setTitle:LocalString(@"功率1") forState:UIControlStateNormal];
    [self.ib_btn1 setTitle:LocalString(@"月发电量") forState:UIControlStateNormal];
    [self.ib_btn2 setTitle:LocalString(@"年发电量") forState:UIControlStateNormal];
    
//    switch (defultIndex) {
//        case 0:
////            self.ib_textLable.text = LocalString(@"功率");
////            self.ib_textLable.text = [NSString stringWithFormat:@"%@ %@",[last stringForKey:@"pac_value"], @"kW"];
//            self.ib_textLable.attributedText = [self attributeString:[NSString stringWithFormat:@"%@ %@",[last stringForKey:@"pac_value"], @"kW"] rangeStringLenth:2 font:[UIFont systemFontOfSize:14.0] value:[UIColor colorWithRed:16/255.0 green:116/255.0 blue:85/255.0 alpha:1.0]];
//            
//            self.ib_textDate.text = [NSDate currentDateStringWithFormat:@"yyyy-MM-dd"];
//            self.ib_textDate.text = [last stringForKey:@"time"];
//            break;
//        case 1:
//            self.ib_textLable.text = LocalString(@"发电量(kW)");
//            self.ib_textLable.text = [last stringForKey:@"Text"];
//
//            self.ib_textLable.attributedText = [self attributeString:[last stringForKey:@"Text"] rangeStringLenth:3 font:[UIFont systemFontOfSize:14.0] value:[UIColor colorWithRed:16/255.0 green:116/255.0 blue:85/255.0 alpha:1.0]];
//            
//            self.ib_textDate.text = [NSDate currentDateStringWithFormat:@"yyyy-MM"];
//            self.ib_textDate.text = [last stringForKey:@"date"];
//            break;
//        case 2:
////            self.ib_textLable.text = LocalString(@"年发电量");
////            self.ib_textLable.text = [last stringForKey:@"Text"];
//            
//            self.ib_textLable.attributedText = [self attributeString:[last stringForKey:@"Text"] rangeStringLenth:3 font:[UIFont systemFontOfSize:14.0] value:[UIColor colorWithRed:16/255.0 green:116/255.0 blue:85/255.0 alpha:1.0]];
//            
//            self.ib_textDate.text = [NSString stringWithFormat:@"%zd-%@", [[NSDate currentDateStringWithFormat:@"yyyy"] integerValue]-1,[NSDate currentDateStringWithFormat:@"yyyy"]];
//            self.ib_textDate.text = [last stringForKey:@"date"];
//
//            break;
//            
//        default:
//            self.ib_textLable.text = LocalString(@"功率");
//            self.ib_textDate.text = [NSDate currentDateStringWithFormat:@"yyyy-MM-dd"];
//            break;
//    }
    
    //默认选中
    for (UIView *view in self.ib_btnViews.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton*)view;
            if (button.tag == defultIndex) {
                [button setBackgroundImage:[UIImage imageNamed:@"bg_bar_selected.png"] forState:UIControlStateNormal];
            }else{
                [button setBackgroundImage:[UIImage imageNamed:@"bg_tab_noSeclected.png"] forState:UIControlStateNormal];
            }
        }
    }
    //点击事件
    [self.ib_btn0 addActionHandler:^(NSInteger tag) {
        selectBlock(tag);
    }];
    [self.ib_btn1 addActionHandler:^(NSInteger tag) {
        selectBlock(tag);
    }];
    [self.ib_btn2 addActionHandler:^(NSInteger tag) {
        selectBlock(tag);
    }];
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
