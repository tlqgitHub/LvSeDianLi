//
//  LSDPage5DefultCell.h
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/7/29.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSDPage5DefultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ib_textLeft;

@property (weak, nonatomic) IBOutlet UILabel *ib_textRight;

@property (weak, nonatomic) IBOutlet UILabel *ib_textValue;

-(void)setData:(NSDictionary*)data;
@end
