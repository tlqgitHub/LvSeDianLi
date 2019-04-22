//
//  BaseTableViewController.m
//  Vcooline
//
//  Created by TianLinqiang on 15/2/4.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import "BaseTableViewController.h"


@interface BaseTableViewController ()
{
    NSMutableArray *mList;
}

@end

///**
// *  设置尾部控件的文字
// */
//@property (copy, nonatomic) NSString *footerPullToRefreshText; // 默认:@"上拉可以加载更多数据"
//@property (copy, nonatomic) NSString *footerReleaseToRefreshText; // 默认:@"松开立即加载更多数据"
//@property (copy, nonatomic) NSString *footerRefreshingText; // 默认:@"MJ哥正在帮你加载数据..."
//
///**
// *  设置头部控件的文字
// */
//@property (copy, nonatomic) NSString *headerPullToRefreshText; // 默认:@"下拉可以刷新"
//@property (copy, nonatomic) NSString *headerReleaseToRefreshText; // 默认:@"松开立即刷新"
//@property (copy, nonatomic) NSString *headerRefreshingText; // 默认:@"MJ哥正在帮你刷新..."

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setExtraCellLineHidden:self.mTableView];
    
    self.mTableView.backgroundColor = [UIColor clearColor];
//    5.自动进入刷新状态
//    1> [self.tableView headerBeginRefreshing];
//    2> [self.tableView footerBeginRefreshing];
//    
//    6.结束刷新
//    1> [self.tableView headerEndRefreshing];
//    2> [self.tableView footerEndRefreshing];
    
    [self.mTableView addHeaderWithCallback:^{
        self.indexPage = 1;
        [self fRefresh];
    } dateKey:[NSString stringWithUTF8String:object_getClassName(self)]];//存储刷新时间的key
    
    [self.mTableView addFooterWithCallback:^{
        self.indexPage++;
        [self fRefresh];
    }];
    
    self.mTableView.footerPullToRefreshText = LocalString(@"上拉可以加载更多数据");//上拉可以加载更多数据
    self.mTableView.footerReleaseToRefreshText = LocalString(@"松开立即加载更多数据");//松开立即加载更多数据
    self.mTableView.footerRefreshingText = LocalString(@"加载数据...");//加载数据...
    
    self.mTableView.headerPullToRefreshText = LocalString(@"下拉可以刷新");//下拉可以刷新
    self.mTableView.headerReleaseToRefreshText = LocalString(@"松开立即刷新");//松开立即刷新
    self.mTableView.headerRefreshingText = LocalString(@"刷新...");//刷新...
}

- (void)fRefresh
{
    [self.mTableView headerEndRefreshing];
}

- (void)fGetMore
{
    [self.mTableView footerEndRefreshing];
}

#pragma mark -
#pragma mark Table View Data Source Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

//返回组的名称
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

//设置行的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

/*
 自定义表格单元格
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark Table Delegate Methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//去掉多余的分割线
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
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
