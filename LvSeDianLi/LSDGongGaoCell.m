//
//  LSDGongGaoCell.m
//  LvSeDianLi
//
//  Created by TianLinqiang on 2017/1/21.
//  Copyright © 2017年 TianLinqiang. All rights reserved.
//

#import "LSDGongGaoCell.h"
#import "NSDictionary+SafeAccess.h"
#import "ACMacros.h"

@implementation LSDGongGaoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    ViewRadius(self.ib_view, 4);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setData:(NSDictionary *)data
{
    self.ib_title.text = [data stringForKey:@"title"];
    self.ib_time.text = [data stringForKey:@"time"];
}
@end
