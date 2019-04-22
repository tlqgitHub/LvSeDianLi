//
//  LSDPage5678BaseController.h
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/7/29.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import "BaseTableViewController.h"

@interface LSDPage5678BaseController : BaseTableViewController

//@property (strong, nonatomic) NSDictionary *dataDic;

@property (strong, nonatomic) NSDictionary *param;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end
