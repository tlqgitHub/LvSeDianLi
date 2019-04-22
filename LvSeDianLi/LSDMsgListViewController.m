//
//  LSDMsgListViewController.m
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/8/29.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import "LSDMsgListViewController.h"

#import "LSDMsgDesViewController.h"

#import "LSDMsgMoreListViewController.h"
#import "LSDGongGaoListViewController.h"

#import "NSDate+Addition.h"
#import "UIView+BlockGesture.h"

#import "LSDPage3Cell.h"

@interface LSDMsgListViewController ()
{
    NSArray *mListData;
}

@property (strong, nonatomic) NSDictionary *gongGaoDic;

@end

@implementation LSDMsgListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self setTitle:LocalString(@"消息中心")];
    
    self.mTableView.footerHidden = YES;
    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //自动刷新
    [self.mTableView headerBeginRefreshing];
}

- (void)fRefresh
{
    [self initData];
}

- (void)initData
{
    NSString* urlStr = [NSString stringWithFormat:@"%@", API_URL_GetShuliang];
    
    NSDictionary *params = @{@"userId":[USER_DEFAULT stringForKey:KEY_USERID],
                             @"GetLixian_Shebei_Time":[self stringForDataApi:@"GetLixian_Shebei"],
                             @"GetLixian_Caijiqi_Time":[self stringForDataApi:@"GetLixian_Caijiqi"],
                             @"GetTingji_Shebei_Time":[self stringForDataApi:@"GetLixian_Shebei"],
                             @"GetTingji_Dianzhan_Time":[self stringForDataApi:@"GetTingji_Dianzhan"],
                             @"GetDixiao_Shebei_Time":[self stringForDataApi:@"GetDixiao_Shebei"],
                             @"GetDixiao_Dianzhan_Time":[self stringForDataApi:@"GetDixiao_Dianzhan"],
                             @"GetGuzhang_Time":[self stringForDataApi:@"GetGuzhang"],
                             @"GetGonggao_Time":[self stringForDataApi:@"GetGonggao"],};
    
    [self httpGetUrl:urlStr WithData:params completionHandler:^(NSDictionary *data) {
        
        self.gongGaoDic = @{@"icon":@"",@"title":@"公告",@"unReadNum":[data stringForKey:@"Gonggao_UnReadNum"]};
        
        self->mListData = @[
                      @{@"icon":@"alarm_red",@"title":@"故障",@"key":@"ErrorInfo",
                        @"unReadNum":[data stringForKey:@"Guzhang_UnReadNum"],@"api":@"GetGuzhang"},
                      @{@"icon":@"alarm_gry",@"title":@"采集器离线",@"key":@"LixianInfo",@"unReadNum":[data stringForKey:@"Lixian_Caijiqi_UnReadNum"],@"api":@"GetLixian_Caijiqi"},
                      @{@"icon":@"alarm_brown",@"title":@"设备离线",@"key":@"LixianInfo",@"unReadNum":[data stringForKey:@"Lixian_Shebei_UnReadNum"],@"api":@"GetLixian_Shebei"},
                      @{@"icon":@"alarm_half",@"title":@"逆变器日停机",@"key":@"GaojingInfo",@"unReadNum":[data stringForKey:@"Tingji_Shebei_UnReadNum"],@"api":@"GetTingji_Shebei"},
                      @{@"icon":@"alarm_yellow",@"title":@"电站日停机",@"key":@"GaojingInfo",@"unReadNum":[data stringForKey:@"Tingji_Dianzhan_UnReadNum"],@"api":@"GetTingji_Dianzhan"},
                      @{@"icon":@"alarm_purple",@"title":@"逆变器月度低效",@"key":@"GaojingInfo",@"unReadNum":[data stringForKey:@"Dixiao_Shebei_UnReadNum"],@"api":@"GetDixiao_Shebei"},
                      @{@"icon":@"alarm_purple_2",@"title":@"电站月度低效",@"key":@"GaojingInfo",@"unReadNum":[data stringForKey:@"Dixiao_Dianzhan_UnReadNum"],@"api":@"GetDixiao_Dianzhan"}];

        [self.mTableView headerEndRefreshing];
        [self.mTableView reloadData];
    } errorHandler:^(NSString *errMsg) {
        [self.mTableView headerEndRefreshing];
    }];
}

-(NSString*)stringForDataApi:(NSString*)api
{
    NSString *lastTime = [[NSUserDefaults standardUserDefaults] stringForKey:[NSString stringWithFormat:@"lastTime%@", api]];
    if (lastTime==nil) {
        lastTime = @"";
    }
    return lastTime;
}

-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 50)];
    
    UIView*subV = [[UIView alloc] initWithFrame:CGRectMake(6, 6, Main_Screen_Width-12, 38)];
    [view addSubview:subV];
    subV.backgroundColor = [UIColor colorWithRed:227/255.0 green:239/255.0 blue:220/255.0 alpha:1];
    
    ViewRadius(subV, 4);
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 42)];
    [subV addSubview:title];
    title.text = LocalString([self.gongGaoDic stringForKey:@"title"]);
    title.textColor = [UIColor colorWithRed:90/255.0 green:117/255.0 blue:84/255.0 alpha:1];
    title.font = [UIFont systemFontOfSize:16];
    
    UILabel *num = [[UILabel alloc] initWithFrame:CGRectMake(Main_Screen_Width-8-8-20-4, 11, 20, 20)];
    [subV addSubview:num];
    num.backgroundColor = [UIColor colorWithRed:63/255.0 green:182/255.0 blue:100/255.0 alpha:1];
    num.textAlignment = NSTextAlignmentCenter;
    num.textColor = [UIColor whiteColor];
    num.font = [UIFont systemFontOfSize:10];
    num.hidden = YES;
    
    ViewRadius(num, 10);
    
    if ([[self.gongGaoDic stringForKey:@"unReadNum"] isEqualToString:@"0"]||[[self.gongGaoDic stringForKey:@"unReadNum"] isEqualToString:@""]) {
        num.hidden = YES;
    } else {
        num.hidden = NO;
        
        num.text = [self.gongGaoDic stringForKey:@"unReadNum"];
    }
    
    [view addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
        NSDictionary *prams = @{@"api":@"GetMessageByLanguage",
                                @"icon":@"",
                                @"title":LocalString([self.gongGaoDic stringForKey:@"title"]),
                                @"key":@"Message",
                                @"subTitle":@""};
        
        LSDGongGaoListViewController *vc = [[LSDGongGaoListViewController alloc] initWithParmsDic:prams];
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    
    return view;
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
    return 48;
}

/*
 自定义表格单元格
 */
- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSDictionary* mDic = [mListData objectAtIndex:indexPath.row];
    
    static NSString* CustomTableViewIdentifier = @"LSDPage3Cell";
    
    LSDPage3Cell *cell =
    [tableView dequeueReusableCellWithIdentifier:CustomTableViewIdentifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:CustomTableViewIdentifier
                                              owner:self
                                            options:nil] firstObject];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    [cell setData:mDic];
    
    return cell;
    return nil;
}

#pragma mark Table Delegate Methods
- (void)tableView:(UITableView*)tableView
didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSDictionary* mDic = [mListData objectAtIndex:indexPath.row];
    
    NSDictionary *prams = @{@"api":[mDic stringForKey:@"api"],
                            @"icon":[mDic stringForKey:@"icon"],
                            @"title":@"",
                            @"key":[mDic stringForKey:@"key"],
                            @"subTitle":[mDic stringForKey:@"title"]};
    
    LSDMsgMoreListViewController *vc = [[LSDMsgMoreListViewController alloc] initWithParmsDic:prams];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width str:(NSString*)text{
    
    NSDictionary *attributes = @{NSFontAttributeName: font};
    // NSString class method: boundingRectWithSize:options:attributes:context is
    // available only on ios7.0 sdk.
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:attributes
                                              context:nil];
    return rect.size.height;
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
