//
//  LSDGongGaoDesCell.m
//  LvSeDianLi
//
//  Created by TianLinqiang on 2017/1/21.
//  Copyright © 2017年 TianLinqiang. All rights reserved.
//

#import "LSDGongGaoDesCell.h"
#import "ACMacros.h"
#import "NSDictionary+SafeAccess.h"

@implementation LSDGongGaoDesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ViewRadius(self.ib_view, 4);
    
    self.ib_content.font= [UIFont systemFontOfSize:14];
    self.ib_content.textColor = UIColorFromRGB(0x5f7650);
    self.ib_content.delegate = self;
    self.ib_content.userInteractionEnabled = YES;
}

- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url
{
    if (self.backAtion) {
        self.backAtion(url);
    }
    DLog(@"url:%@",url);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//<id>string</id>
//<time>string</time>
//<title>string</title>
//<content>string</content>
-(void)setData:(NSDictionary *)data
{
    self.ib_title.text = [data stringForKey:@"title"];
    
    self.ib_time.text = [data stringForKey:@"time"];
    
    self.ib_content.text = [data stringForKey:@"content"];
}
@end
