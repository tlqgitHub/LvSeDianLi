//
//  LSDGongGaoListViewController.m
//  LvSeDianLi
//
//  Created by TianLinqiang on 2017/1/21.
//  Copyright © 2017年 TianLinqiang. All rights reserved.
//

#import "LSDGongGaoListViewController.h"

#import "LSDGonggaoDesViewController.h"

#import "LSDGongGaoCell.h"
#import "NSDate+Addition.h"

#import "LSDHost.h"

@interface LSDGongGaoListViewController ()
{
    NSArray *mListData;
}

@end

@implementation LSDGongGaoListViewController

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
    
    NSDictionary *params = @{@"languageId":[self LanguageId]};
    
    [self httpGetUrl:urlStr WithData:params completionHandler:^(NSDictionary *data) {
        
        mListData = [self isNoArr:data key:[self.parmsDic stringForKey:@"key"]];
        
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
    return 60;
}

/*
 自定义表格单元格
 */
- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSDictionary* mDic = [mListData objectAtIndex:indexPath.row];
    
    static NSString* CustomTableViewIdentifier = @"LSDGongGaoCell";
    
    LSDGongGaoCell *cell =
    [tableView dequeueReusableCellWithIdentifier:CustomTableViewIdentifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:CustomTableViewIdentifier
                                              owner:self
                                            options:nil] firstObject];
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    if (indexPath.row==0)
    {
        cell.ib_view.backgroundColor = [UIColor whiteColor];
    }else{
        cell.ib_view.backgroundColor = UIColorFromRGB(0xE3EFD9);
    }
    
    [cell setData:mDic];
    
    return cell;
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSDictionary* mDic = [mListData objectAtIndex:indexPath.row];
    
    LSDGonggaoDesViewController *vc = [[LSDGonggaoDesViewController alloc] initWithParmsDic:mDic];
    [self.navigationController pushViewController:vc animated:YES];
}

-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 50)];
    
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
    
    UILabel *num = [[UILabel alloc] initWithFrame:CGRectMake(Main_Screen_Width-8-100-4-10, 11, 100, 20)];
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

-(NSString*)stringForNow
{
    return [[NSDate date] dateWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}
//中国就是1 日文就是3 其它就是2
-(NSString*)LanguageId
{
    NSString *str = @"2";
    
    if ([[LSDHost sharedClient].getHost isEqualToString:@"http://www.lvsedianli.com:8080/"])
    {
        str = @"1";
    }else if ([[LSDHost sharedClient].getHost isEqualToString:@"http://jp.smart-pv.net:8080/"])
    {
        str = @"3";
    }else{
        
        str = @"2";
    }
    
    return str;
}

- (NSString*)getPreferredLanguage

{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray * allLanguages = [defaults objectForKey:@"AppleLanguages"];
    
    NSString * preferredLang = [allLanguages objectAtIndex:0];
    
    NSLog(@"当前语言:%@", preferredLang);
    
    return preferredLang;
    
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
