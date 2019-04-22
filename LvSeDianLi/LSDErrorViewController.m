//
//  LSDErrorViewController.m
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/7/30.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import "LSDErrorViewController.h"

#import "LSDErrorHeadCell.h"
#import "LSDErrorViewCell.h"

@interface LSDErrorViewController ()
{
    NSInteger psId;
    
    NSArray *dataArr;
}

@end

@implementation LSDErrorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:LocalString(@"p1_app_name")];
    
    self.mTableView.footerHidden = YES;
    //    self.mTableView.headerHidden = YES;
    
    //自动刷新
    [self.mTableView headerBeginRefreshing];
}

- (void)fRefresh
{
    [self initData];
}

- (void)initData
{
    NSDictionary *pram = @{@"UserId":[USER_DEFAULT stringForKey:KEY_USERID],@"PsId":self.parmsDic[@"PsId"]};
    NSString* urlStr = [NSString stringWithFormat:@"%@", API_URL_GetPsError];
    
    [self httpGetUrl:urlStr WithData:pram completionHandler:^(NSDictionary *data) {
        
        dataArr = [self isNoArr:data key:@"ErrorInfo"];

        [self.mTableView headerEndRefreshing];
        [self.mTableView reloadData];
    } errorHandler:^(NSString *errMsg) {
        [self.mTableView headerEndRefreshing];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    return dataArr?dataArr.count:0;
}

//设置行的高度
- (CGFloat)tableView:(UITableView*)tableView
heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section==0) {
        return 60;
    }else{
       return 120;
    }
}

/*
 自定义表格单元格
 */
- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section==0) {
        static NSString * CustomTableViewIdentifier =@"LSDErrorHeadCell";
        
        LSDErrorHeadCell * cell = [tableView dequeueReusableCellWithIdentifier:CustomTableViewIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:CustomTableViewIdentifier
                                                  owner:self
                                                options:nil] firstObject];
        }
        
        return cell;
    }else{
        
        NSDictionary *curDic = [dataArr objectAtIndex:indexPath.row];
        
        static NSString * CustomTableViewIdentifier =@"LSDErrorViewCell";
        
        LSDErrorViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CustomTableViewIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:CustomTableViewIdentifier
                                                  owner:self
                                                options:nil] firstObject];
        }
        
        [cell setData:curDic];
        
        return cell;
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
