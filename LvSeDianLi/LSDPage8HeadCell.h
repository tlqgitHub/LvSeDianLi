//
//  LSDPage8HeadCell.h
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/8/1.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSDPage8HeadCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *ib_contentView;
@property (weak, nonatomic) IBOutlet UILabel *ib_textLeft;

@property (weak, nonatomic) IBOutlet UILabel *ib_textRight;

-(void)setData:(NSDictionary*)data lastDic:(NSDictionary*)lastData;
@end
