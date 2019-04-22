//
//  LSDTitleViewCell.h
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/7/29.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CBAutoScrollLabel.h"

@interface LSDTitleViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *ib_contentView;

@property (weak, nonatomic) IBOutlet CBAutoScrollLabel *ib_lbpaomaName;

-(void)setData:(NSDictionary*)data;
@end
