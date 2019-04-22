//
//  LSDPage3Cell.m
//  LvSeDianLi
//
//  Created by TianLinqiang on 2017/1/20.
//  Copyright © 2017年 TianLinqiang. All rights reserved.
//

#import "LSDPage3Cell.h"
#import "NSDictionary+SafeAccess.h"

@implementation LSDPage3Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    ViewRadius(self.ib_bgView, 4);
    ViewRadius(self.ib_unReadNum, 10);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setData:(NSDictionary *)data
{
    self.ib_title.text = LocalString([data stringForKey:@"title"]);
    
    if ([[data stringForKey:@"unReadNum"] isEqualToString:@"0"]) {
        self.ib_unReadNum.hidden = YES;
    } else {
        self.ib_unReadNum.hidden = NO;
        
        self.ib_unReadNum.text = [data stringForKey:@"unReadNum"];
    }
    
    self.ib_statusImg.image = [UIImage imageNamed:[data stringForKey:@"icon"]];
}

//-(UIImage*)imageWithTitle:(NSString*)title
//{
//    NSString *imageName = @"";
//    
//    if ([title isEqualToString:@""]) {
//        imageName = @"";
//    }else if ([title isEqualToString:@""])
//    {
//        
//    }else if ([title isEqualToString:@""])
//    {
//        
//    }else if ([title isEqualToString:@""])
//    {
//        
//    }else if ([title isEqualToString:@""])
//    {
//        
//    }else if ([title isEqualToString:@""])
//    {
//        
//    }
//    
//    return [UIImage imageNamed:imageName];
//    return nil;
//}

@end
