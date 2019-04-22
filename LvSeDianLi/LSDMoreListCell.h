//
//  LSDMoreListCell.h
//  LvSeDianLi
//
//  Created by TianLinqiang on 2017/1/21.
//  Copyright © 2017年 TianLinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBAutoScrollLabel.h"

@interface LSDMoreListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *ib_view;

@property (weak, nonatomic) IBOutlet CBAutoScrollLabel *ib_title;

@property (weak, nonatomic) IBOutlet UILabel *ib_text10;
@property (weak, nonatomic) IBOutlet UILabel *ib_text11;

@property (weak, nonatomic) IBOutlet UILabel *ib_text20;
@property (weak, nonatomic) IBOutlet UILabel *ib_text21;

@property (weak, nonatomic) IBOutlet UILabel *ib_text30;
@property (weak, nonatomic) IBOutlet CBAutoScrollLabel *ib_text31;

@property (weak, nonatomic) IBOutlet UILabel *ib_isRead;

-(void)setData:(NSDictionary *)data withType:(NSString*)type;

@end
