//
//  LSDPage3Cell.h
//  LvSeDianLi
//
//  Created by TianLinqiang on 2017/1/20.
//  Copyright © 2017年 TianLinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACMacros.h"

@interface LSDPage3Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *ib_bgView;
@property (weak, nonatomic) IBOutlet UIImageView *ib_statusImg;
@property (weak, nonatomic) IBOutlet UILabel *ib_title;
@property (weak, nonatomic) IBOutlet UILabel *ib_unReadNum;


-(void)setData:(NSDictionary *)data;
@end
