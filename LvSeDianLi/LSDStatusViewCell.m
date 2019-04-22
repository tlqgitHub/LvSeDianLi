//
//  LSDStatusViewCell.m
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/7/29.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import "LSDStatusViewCell.h"
#import "ACMacros.h"
#import "NSDictionary+SafeAccess.h"

@implementation LSDStatusViewCell

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
    self.ib_textCenter.hidden = YES;
    self.ib_textRight.text = LocalString([data stringForKey:@"Status"]);
    
    self.ib_btnShowError.tag = [data integerForKey:@"PsId"];
    [self.ib_btnShowError setTitle:LocalString(@"故障明细") forState:UIControlStateNormal];
    if ([[data stringForKey:@"Status"] isEqualToString:@"故障"]) {
        self.ib_btnShowError.hidden = NO;
    }
//    ViewBorderRadius(View, Radius, Width, Color)
    ViewBorderRadius(self.ib_conView, 2, 1, [UIColor colorWithRed:14/255.0 green:125/255.0 blue:100/255.0 alpha:1.0]);
}

-(IBAction)showErrorAction:(id)sender
{
    NSInteger psId = ((UIButton*)sender).tag;
    if (self.showPSDError) {
        self.showPSDError(psId);
    }
}
@end
