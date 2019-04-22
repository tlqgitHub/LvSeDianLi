//
//  BaseTableViewController.h
//  Vcooline
//
//  Created by TianLinqiang on 15/2/4.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import "BaseHTTPViewController.h"

#import "MJRefresh.h"

@interface BaseTableViewController : BaseHTTPViewController

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@property (nonatomic) NSInteger indexPage;

@end
