//
//  LSDPage6Cell.h
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/7/30.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSDPage6Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *ib_textLeft;

@property (weak, nonatomic) IBOutlet UILabel *ib_textRight;

@property (weak, nonatomic) IBOutlet UIImageView *ib_imgStatus;

-(void)setData:(NSDictionary*)data;

@end
