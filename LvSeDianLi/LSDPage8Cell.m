//
//  LSDPage8Cell.m
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/7/30.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import "LSDPage8Cell.h"
#import "NSDictionary+SafeAccess.h"

#import "Masonry.h"

#import "ACMacros.h"

@implementation LSDPage8Cell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    [self layoutIfNeeded];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setData:(NSDictionary*)data max:(CGFloat) maxF
{
//    self.ib_textCenter.hidden = YES;
//    self.ib_imgStatus.hidden = YES;
    
    NSString *totalpac = [data stringForKey:@"totalpac"];
    CGFloat tmpF = [[totalpac substringToIndex:totalpac.length-5] floatValue];
    NSString *danwei = [totalpac substringFromIndex:totalpac.length-3];
    self.ib_textLeft.text = [data stringForKey:@"CustomName"].length>0?[data stringForKey:@"CustomName"]:[data stringForKey:@"InverterId"];
    
    self.ib_textShow.text = [NSString stringWithFormat:@"%.2f %@", tmpF, danwei];
    
    CGFloat sc = 1;
    
    if (maxF!=0) {
        sc = tmpF/maxF;
        
        if(tmpF==0.0)
        {
           sc = 1;
        }
    }

    NSLog(@"-----%f",self.ib_textCenter.frame.size.width);
    
//    114 11; 250 16
//    [self.ib_textRight setFrame:CGRectMake(114, 11, <#CGFloat width#>, 16)]
//    WeakObj(self);
//    self.ib_textRight.frame.size.width*sc
//    [self.ib_textRight mas_updateConstraints:^(MASConstraintMaker *make) {
//        
//        make.width.mas_equalTo((Main_Screen_Width-(320-156))*sc);
////        make.left.equalTo(self.ib_textLeft.mas_right).offset(10);
//    }];
    
    [self.ib_textRight mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo((Main_Screen_Width-(320-156))*sc);
        make.height.mas_equalTo(16);
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.ib_textLeft.mas_right).offset(10);
    }];
    
//    [self.ib_textRight setFrame:CGRectMake(self.ib_textRight.frame.origin.x, self.ib_textRight.frame.origin.y, 50, self.ib_textRight.frame.size.height)];
    
    NSString *imageName = [data stringForKey:@"Status"];
    
    //    0 是green   1和2是gry  3 是 yellow   4 是red , 5 是half
    if ([imageName isEqualToString:@"不在线"]) {//1
        self.ib_textRight.backgroundColor = UIColorFromRGB(0x916D38);
    }else if ([imageName isEqualToString:@"通信异常"]) {//2
        self.ib_textRight.backgroundColor = UIColorFromRGB(0x916D38);
    }else if ([imageName isEqualToString:@"停机"]) {//3
        self.ib_textRight.backgroundColor = UIColorFromRGB(0xB0AF03);
    }else if ([imageName isEqualToString:@"故障"]) {//4
        self.ib_textRight.backgroundColor = UIColorFromRGB(0xF72905);
    }else if ([imageName isEqualToString:@"部分停机"]) {//5
        self.ib_textRight.backgroundColor = UIColorFromRGB(0x20AA44);
    }else if ([imageName isEqualToString:@"设备离线"]) {//7
        self.ib_textRight.backgroundColor = UIColorFromRGB(0xE29E02);
    }else {//0
        self.ib_textRight.backgroundColor = UIColorFromRGB(0x20AA44);
    }
}

-(void)setData:(NSDictionary*)data
{
    self.ib_textLeft.text = [data stringForKey:@"CustomName"].length>0?[data stringForKey:@"CustomName"]:[data stringForKey:@"InverterId"];
    self.ib_textCenter.text = [data stringForKey:@"totalpac"];
    
    
    NSString *imageName = [data stringForKey:@"Status"];
    
    //    0 是green   1和2是gry  3 是 yellow   4 是red , 5 是half
    if ([imageName isEqualToString:@"不在线"]) {//1
        imageName = @"alarm_gry.png";
    }else if ([imageName isEqualToString:@"通信异常"]) {//2
        imageName = @"alarm_gry.png";
    }else if ([imageName isEqualToString:@"停机"]) {//3
        imageName = @"alarm_yellow.png";
    }else if ([imageName isEqualToString:@"故障"]) {//4
        imageName = @"alarm_red.png";
    }else if ([imageName isEqualToString:@"部分停机"]) {//5
        imageName = @"alarm_half.png";
    }else {//0
        imageName = @"alarm_green.png";
    }
    
    [self.ib_imgStatus setImage:[UIImage imageNamed:imageName]];
}
@end
