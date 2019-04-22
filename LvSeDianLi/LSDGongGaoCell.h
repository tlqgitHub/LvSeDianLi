//
//  LSDGongGaoCell.h
//  LvSeDianLi
//
//  Created by TianLinqiang on 2017/1/21.
//  Copyright © 2017年 TianLinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSDGongGaoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *ib_view;

@property (weak, nonatomic) IBOutlet UILabel *ib_title;
@property (weak, nonatomic) IBOutlet UILabel *ib_time;
-(void)setData:(NSDictionary *)data;

@end
