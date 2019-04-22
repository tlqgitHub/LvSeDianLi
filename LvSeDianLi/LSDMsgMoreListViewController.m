//
//  LSDMsgMoreListViewController.m
//  LvSeDianLi
//
//  Created by TianLinqiang on 2017/1/21.
//  Copyright © 2017年 TianLinqiang. All rights reserved.
//

#import "LSDMsgMoreListViewController.h"

#import "LSDMoreListCell.h"
#import "NSDate+Addition.h"

@interface LSDMsgMoreListViewController ()
{
    NSArray *mListData;
}

@end

@implementation LSDMsgMoreListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.mTableView.footerHidden = YES;
    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //自动刷新
    [self.mTableView headerBeginRefreshing];
}

- (void)fRefresh
{
    [self initData];
}

- (void)initData
{
    NSString* urlStr = [NSString stringWithFormat:@"%@", [self.parmsDic stringForKey:@"api"]];
    
    NSDictionary *params = @{@"userId":[USER_DEFAULT stringForKey:KEY_USERID],
                             @"lastViewTime":[self lastTime:urlStr],
                             @"pageIndex":@"0",
                             @"pageSize":@"100"};
    
    [self httpGetUrl:urlStr WithData:params completionHandler:^(NSDictionary *data) {
        
        self->mListData = [self isNoArr:[data dictionaryForKey:@"details"] key:[self.parmsDic stringForKey:@"key"]];
        
        [[NSUserDefaults standardUserDefaults] setObject:[[NSDate date] dateWithFormat:@"yyyy-MM-dd HH:mm:ss"]
                                                  forKey:[NSString stringWithFormat:@"lastTime%@", urlStr]];
        [self.mTableView headerEndRefreshing];
        [self.mTableView reloadData];
    } errorHandler:^(NSString *errMsg) {
        [self.mTableView headerEndRefreshing];
    }];
}

- (CGFloat)tableView:(UITableView*)tableView
heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView*)tableView
heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return mListData ? mListData.count : 0;
}

//设置行的高度
- (CGFloat)tableView:(UITableView*)tableView
heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSDictionary* mDic = [mListData objectAtIndex:indexPath.row];
    
    if ([[self.parmsDic stringForKey:@"api"] isEqualToString:@"GetGuzhang"]) {
        
        if ([mDic stringForKey:@"isRead"]) {
            return 140;
        } else {
            return 140;
        }
    }else if ([[self.parmsDic stringForKey:@"api"] isEqualToString:@"GetDixiao_Shebei"])
    {
        if ([mDic stringForKey:@"isRead"]) {
            return 140;
        } else {
            return 140;
        }
    }else if ([[self.parmsDic stringForKey:@"api"] isEqualToString:@"GetDixiao_Dianzhan"])
    {
        if ([mDic stringForKey:@"isRead"]) {
            return 120;
        } else {
            return 120;
        }
    }
    //GetTingji_Dianzhan
    else if ([[self.parmsDic stringForKey:@"api"] isEqualToString:@"GetTingji_Dianzhan"])
    {
        if ([mDic stringForKey:@"isRead"]) {
            return 90;
        } else {
            return 90;
        }
    }
    //GetTingji_Shebei
    else if ([[self.parmsDic stringForKey:@"api"] isEqualToString:@"GetTingji_Shebei"])
    {
        if ([mDic stringForKey:@"isRead"]) {
            return 120;
        } else {
            return 120;
        }
    }
    //GetLixian_Shebei
    else if ([[self.parmsDic stringForKey:@"api"] isEqualToString:@"GetLixian_Shebei"])
    {
        if ([mDic stringForKey:@"isRead"]) {
            return 120;
        } else {
            return 120;
        }
    }
    //GetLixian_Caijiqi
    else if ([[self.parmsDic stringForKey:@"api"] isEqualToString:@"GetLixian_Caijiqi"])
    {
        if ([mDic stringForKey:@"isRead"]) {
            return 120;
        } else {
            return 120;
        }
    }
    return 48;
}

/*
 自定义表格单元格
 */
- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSDictionary* mDic = [mListData objectAtIndex:indexPath.row];
    
    static NSString* CustomTableViewIdentifier = @"LSDMoreListCell";
    
    LSDMoreListCell *cell =
    [tableView dequeueReusableCellWithIdentifier:CustomTableViewIdentifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:CustomTableViewIdentifier
                                              owner:self
                                            options:nil] firstObject];
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    [cell setData:mDic withType:[self.parmsDic stringForKey:@"api"]];
    
    return cell;
    return nil;
}

-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 50)];
    view.backgroundColor = [UIColor colorWithRed:48/255.0 green:168/255.0 blue:145/255.0 alpha:1.0];
    
    UIView*subV = [[UIView alloc] initWithFrame:CGRectMake(6, 6, Main_Screen_Width-12, 38)];
    [view addSubview:subV];
    subV.backgroundColor = [UIColor colorWithRed:0 green:156/255.0 blue:128/255.0 alpha:1];
    
    ViewRadius(subV, 4);
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 42)];
    [subV addSubview:title];
    title.hidden = YES;
    if([self.parmsDic stringForKey:@"title"].length>0)
    {
        title.hidden = NO;
        title.text = LocalString([self.parmsDic stringForKey:@"title"]);
    }
    
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont systemFontOfSize:16];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 4, 30, 30)];
    [subV addSubview:imageV];
    imageV.hidden = YES;
    if([self.parmsDic stringForKey:@"icon"].length>0)
    {
        imageV.hidden = NO;
        imageV.image = [UIImage imageNamed:[self.parmsDic stringForKey:@"icon"]];
    }
    
    UILabel *num = [[UILabel alloc] initWithFrame:CGRectMake(Main_Screen_Width-8-200-4-10, 11, 200, 20)];
    [subV addSubview:num];

    num.textAlignment = NSTextAlignmentRight;
    num.textColor = [UIColor whiteColor];
    num.font = [UIFont systemFontOfSize:14];
    num.hidden = YES;
    
    if([self.parmsDic stringForKey:@"subTitle"].length>0)
    {
        num.hidden = NO;
        num.text = LocalString([self.parmsDic stringForKey:@"subTitle"]);
    }
    
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString*)lastTime:(NSString*)urlStr
{
    NSString *str = [[NSUserDefaults standardUserDefaults] stringForKey:[NSString stringWithFormat:@"lastTime%@", urlStr]];
    if (!str) {
        str = @"";
    }
    return str;
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
