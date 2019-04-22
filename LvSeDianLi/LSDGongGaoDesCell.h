//
//  LSDGongGaoDesCell.h
//  LvSeDianLi
//
//  Created by TianLinqiang on 2017/1/21.
//  Copyright © 2017年 TianLinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"

@interface LSDGongGaoDesCell : UITableViewCell<RTLabelDelegate>

@property (nonatomic,strong) void (^backAtion)(NSURL*url);

@property (weak, nonatomic) IBOutlet UIView *ib_view;
@property (weak, nonatomic) IBOutlet UILabel *ib_title;
@property (weak, nonatomic) IBOutlet UILabel *ib_time;
@property (weak, nonatomic) IBOutlet RTLabel *ib_content;

-(void)setData:(NSDictionary *)data;
@end
