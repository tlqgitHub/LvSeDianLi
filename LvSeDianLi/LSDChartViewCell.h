//
//  LSDChartViewCell.h
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/8/1.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PNChart.h"

@interface LSDChartViewCell : UITableViewCell<PNChartDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *ib_sv;
@property (weak, nonatomic) IBOutlet UILabel *ib_lableText;

@property (weak, nonatomic) IBOutlet UILabel *ib_textLable1;
@property (weak, nonatomic) IBOutlet UILabel *ib_textLable2;

@property (weak, nonatomic) IBOutlet UIView *ib_lbViews;

@property (nonatomic,copy)void (^showInfo) (NSInteger infoIndex);

@property (nonatomic, strong) NSArray *tmpArr;

-(void)setData:(NSArray*)dataArr;

-(void)setNewLineWithData:(NSArray*)newArr;

-(void)setNewLineWithData1:(NSArray*)newArr;

-(void)setLineData:(NSArray*)dataArr;

-(void)setBarData:(NSArray*)dataArr;

-(void)setBarYearData:(NSArray*)dataArr;

@end
