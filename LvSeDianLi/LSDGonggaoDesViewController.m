//
//  LSDGonggaoDesViewController.m
//  LvSeDianLi
//
//  Created by TianLinqiang on 2017/1/21.
//  Copyright © 2017年 TianLinqiang. All rights reserved.
//

#import "LSDGonggaoDesViewController.h"
#import "NSDate+Addition.h"
#import "LSDGongGaoDesCell.h"

#import "WWJOpenFileViewController.h"

#import "RTLabel.h"

@interface LSDGonggaoDesViewController ()
{
    NSArray *mListData;
}

@end

@implementation LSDGonggaoDesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)initData
{
    NSString* urlStr = [NSString stringWithFormat:@"%@", @"GetMessageDetail"];
    
    NSDictionary *params = @{@"id":[self.parmsDic stringForKey:@"id"]};
    
    [self httpGetUrl:urlStr WithData:params completionHandler:^(NSDictionary *data) {
        
        mListData = @[data];
        
        [[NSUserDefaults standardUserDefaults] setObject:[[NSDate date] dateWithFormat:@"yyyy-MM-dd HH:mm:ss"]
                                                  forKey:[NSString stringWithFormat:@"lastTime%@", @"GetGonggao"]];
        
        [self.mTableView headerEndRefreshing];
        [self.mTableView reloadData];
    } errorHandler:^(NSString *errMsg) {
        [self.mTableView headerEndRefreshing];
    }];
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
    
    CGFloat h1 = [self heightForFont:[UIFont systemFontOfSize:14] width:Main_Screen_Width-32 str:[mDic stringForKey:@"title"]];
    
//    CGFloat h2 = [self heightForFont:[UIFont systemFontOfSize:14] width:Main_Screen_Width-32 str:[mDic stringForKey:@"content"]];
    
    RTLabel *ib_content = [[RTLabel alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width-32, 200)];
    ib_content.text = [mDic stringForKey:@"content"];
    ib_content.font= [UIFont systemFontOfSize:14];
    
    CGSize optimumSize = [ib_content optimumSize];
    CGFloat height = optimumSize.height+10;
    
    return 58+h1+height;
}

/*
 自定义表格单元格
 */
- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSDictionary* mDic = [mListData objectAtIndex:indexPath.row];
    
    static NSString* CustomTableViewIdentifier = @"LSDGongGaoDesCell";
    
    LSDGongGaoDesCell *cell =
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
    
    cell.backAtion = ^(NSURL*url)
    {
        if (url) {
            
            [self openAction:url];
        }
    };
    
    return cell;
    return nil;
}

-(void)openAction:(NSURL*)url
{
    WWJOpenFileViewController *vc = [[WWJOpenFileViewController alloc] initWithParmsDic:@{@"url":[url absoluteString]}];
    
    [self.navigationController presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{

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
    if(LocalString(@"公告").length>0)
    {
        title.hidden = NO;
        title.text = LocalString(@"公告");
    }
    
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont systemFontOfSize:16];
    
    return view;
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
