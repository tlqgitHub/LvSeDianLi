//
//  LSDPage4Cell.h
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/7/16.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBAutoScrollLabel.h"

@interface LSDPage4Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet CBAutoScrollLabel *ib_lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *ib_lbKwh;
@property (weak, nonatomic) IBOutlet UILabel *ib_lbTime;
@property (weak, nonatomic) IBOutlet UIImageView *ib_imageStyle;


-(void)setData:(NSDictionary*)data;
@end
