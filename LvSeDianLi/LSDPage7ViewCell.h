//
//  LSDPage7ViewCell.h
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/8/1.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSDPage7ViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *ib_btnViews;
@property (weak, nonatomic) IBOutlet UIButton *ib_btn0;
@property (weak, nonatomic) IBOutlet UIButton *ib_btn1;
@property (weak, nonatomic) IBOutlet UIButton *ib_btn2;

@property (weak, nonatomic) IBOutlet UIView *ib_lbViews;
@property (weak, nonatomic) IBOutlet UILabel *ib_textLable;
@property (weak, nonatomic) IBOutlet UILabel *ib_textDate;

typedef void (^selectAction)(NSInteger sIndex);

-(void)setDefultIndex:(NSInteger)defultIndex
                 show:(NSArray*)arr
                block:(selectAction)selectBlock;
@end
