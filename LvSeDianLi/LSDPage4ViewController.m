//
//  LSDPage4ViewController.m
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/7/16.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import "LSDPage4ViewController.h"

#import "LSDPage4Cell.h"

#import "LSDHelpViewController.h"

//#import "LSDPage5678BaseController.h"
//#import "LSDPage5ViewController.h"

#import "LSDPageTabViewController.h"

#import "UIImage+Color.h"

@interface LSDPage4ViewController ()<UISearchBarDelegate>
{
    NSArray* mListData;
    
    NSString *psName;
}

@end

@implementation LSDPage4ViewController

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText   // called when text changes (including clear)
{
    psName = searchBar.text;
    
    if([psName isEqualToString:@""])
    {
        [searchBar resignFirstResponder];
        
        [self.mTableView headerBeginRefreshing];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    psName = searchBar.text;
    
    [searchBar resignFirstResponder];
    [self.mTableView headerBeginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:LocalString(@"p1_app_name")];
    
    self.ib_searchBar.backgroundImage = [UIImage imageWithColor:[UIColor colorWithRed:55/255.0 green:167/255.0 blue:145/255.0 alpha:1]];
    self.ib_searchBar.delegate = self;
    self.ib_searchBar.placeholder = LocalString(@"搜索电站");
    
    UITextField *sbTextField = [self.ib_searchBar valueForKey:@"searchField"]; //首先取出textfield
    sbTextField.textColor = [UIColor whiteColor]; //输入的颜色
    sbTextField.backgroundColor = UIColorFromRGB(0x31a892);
    
    ViewBorderRadius(sbTextField, 4, 0.5, [UIColor darkGrayColor]);
    
    UILabel *sbPlaceholderLabel = [sbTextField valueForKey:@"placeholderLabel"]; //然后取出textField的placeHolder
    sbPlaceholderLabel.textColor = [UIColor whiteColor]; //改变颜色
    
    self.mTableView.footerHidden = YES;
//    self.mTableView.headerHidden = YES;
    
    psName = @"";
    
    //自动刷新
    [self.mTableView headerBeginRefreshing];

    [self addRightNavBarWithImage:[UIImage imageNamed:@"tishi.png"]];
}

- (void)navRightAction
{
    [self.navigationController pushViewController:[[LSDHelpViewController alloc] init] animated:YES];
}

- (void)fRefresh
{
    [self initData];
}

- (void)initData
{
    NSDictionary *pram = @{@"userId":[USER_DEFAULT stringForKey:KEY_USERID],
                           @"psName":psName};
    NSString* urlStr = [NSString stringWithFormat:@"%@", API_URL_SearchPsInfo];
    
    [self httpGetUrl:urlStr WithData:pram completionHandler:^(NSDictionary *data) {

        mListData = [self isNoArr:data key:@"PsInfo"];
//        mListData = [data arrayForKey:@"PsInfo"];
//        if(!mListData){
//            mListData = @[[data dictionaryForKey:@"PsInfo"]];
//        }
        [self.mTableView headerEndRefreshing];
        [self.mTableView reloadData];
    } errorHandler:^(NSString *errMsg) {
        [self.mTableView headerEndRefreshing];
    }];
}

- (CGFloat)tableView:(UITableView*)tableView
heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
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
    return 91;
}

/*
 自定义表格单元格
 */
- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSDictionary* mDic = [mListData objectAtIndex:indexPath.row];
    
    static NSString* CustomTableViewIdentifier = @"LSDPage4Cell";
    LSDPage4Cell* cell =
    [tableView dequeueReusableCellWithIdentifier:CustomTableViewIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:CustomTableViewIdentifier
                                              owner:self
                                            options:nil] firstObject];
    }
    
    
    [cell setData:mDic];
    
    return cell;
    
    return nil;
}

#pragma mark Table Delegate Methods
- (void)tableView:(UITableView*)tableView
didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
//    NSDictionary *object = mListData[indexPath.row];
//    [USER_DEFAULT setObject:object forKey:@"cur_psData"];
//    [USER_DEFAULT synchronize];
//    
//    LSDPageTabViewController *contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LSDPageTabViewController"];
//    
//    [contentViewController setValue:object forKey:@"param"];
//    [self.navigationController pushViewController:contentViewController animated:YES];
//    [self.navigationController presentViewController:[[UINavigationController alloc]initWithRootViewController:contentViewController] animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    UIViewController *destination = segue.destinationViewController;
    if ([destination respondsToSelector:@selector(setParam:)]) {
        NSIndexPath *indexPath = [self.mTableView indexPathForCell:sender];
        id object = mListData[indexPath.row];
        [destination setValue:object forKey:@"param"];
    }
}


@end
