//
//  LSDPage5ViewController.m
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/7/29.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import "LSDPage5ViewController.h"
#import "LSDPage5DefultCell.h"

@interface LSDPage5ViewController ()
{
    NSArray *dataArr;
}

@end

@implementation LSDPage5ViewController

//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil
//                                                        image:[UIImage imageNamed:@"page5_selected"]
//                                                selectedImage:[UIImage imageNamed:@"page5_selected"]];
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    __weak BaseViewController* selfWeak = self;
    
    [self addLeftNavBarWithText:@"返回" block:^{
        [selfWeak.navigationController dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)initData0
{
//    dataArr = @[@{@"title":LocalString(@"装机容量"), @"value":[self.dataDic stringForKey:@"Capacity"]},
//                @{@"title":LocalString(@"功率"), @"value":[self.dataDic stringForKey:@"pac"]},
//                @{@"title":LocalString(@"单位发电量"), @"value":[self.dataDic stringForKey:@"unitPac"]},
//                @{@"title":LocalString(@"今日发电量"), @"value":[self.dataDic stringForKey:@"pac_today"]},
//                @{@"title":LocalString(@"今日收益"), @"value":[self.dataDic stringForKey:@"profit_today"]},
//                @{@"title":LocalString(@"累计发电量"), @"value":[self.dataDic stringForKey:@"pac_total"]},
//                @{@"title":LocalString(@"累计收益"), @"value":[self.dataDic stringForKey:@"profit_total"]}                    ];
    
    [self.mTableView headerEndRefreshing];
    [self.mTableView reloadData];
}

- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

//设置行的高度
- (CGFloat)tableView:(UITableView*)tableView
heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.row==0) {
        return 60;
    }else if(indexPath.row==1) {
        return 40;
    }else{
        return 40;
    }
}

//5.	功率和今日发电量取橙色
/*
 自定义表格单元格
 */
- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.row>1) {
        static NSString * CustomTableViewIdentifier =@"LSDPage5DefultCell";
        
        LSDPage5DefultCell * cell = [tableView dequeueReusableCellWithIdentifier:CustomTableViewIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:CustomTableViewIdentifier
                                                  owner:self
                                                options:nil] firstObject];
        }
        
        [cell setData:[dataArr objectAtIndex:indexPath.row-2]];
        
        if(indexPath.row==4){
            cell.ib_textRight.textColor = [UIColor colorWithRed:173/255.0 green:81/255.0 blue:10/255.0 alpha:1.0];//173  81 10
        }
        
        if(indexPath.row==6){
            cell.ib_textRight.textColor = [UIColor colorWithRed:173/255.0 green:81/255.0 blue:10/255.0 alpha:1.0];//173  81 10
        }
        
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }

    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
