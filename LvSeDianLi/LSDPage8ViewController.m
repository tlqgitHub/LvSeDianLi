//
//  LSDPage8ViewController.m
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/7/29.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import "LSDPage8ViewController.h"

#import "LSDStatusViewCell.h"
#import "LSDPage8Cell.h"

#import "LSDPage8DesViewController.h"

@interface LSDPage8ViewController () {
    NSArray* dataArr;
}

@end

@implementation LSDPage8ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initData0
{
    NSDictionary* pram = @{ @"userId" : [USER_DEFAULT stringForKey:KEY_USERID],
        @"psId" : [NSNumber numberWithInteger:[self.param integerForKey:@"PsId"]] };
    NSString* urlStr = [NSString stringWithFormat:@"%@", API_URL_GetInverterDeviceByUser];

    [self httpGetUrl:urlStr
        WithData:pram
        completionHandler:^(NSDictionary* data) {

            dataArr = [self isNoArr:data key:@"InverterInfo"];
//            dataArr = [data arrayForKey:@"InverterInfo"];
//            if(!dataArr){
//                dataArr = @[[data dictionaryForKey:@"InverterInfo"]];
//            }
            [self.mTableView headerEndRefreshing];
            [self.mTableView reloadData];
        }
        errorHandler:^(NSString* errMsg) {
            [self.mTableView headerEndRefreshing];
        }];
}

- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return dataArr?dataArr.count+2:2;;
}

//设置行的高度
- (CGFloat)tableView:(UITableView*)tableView
    heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.row == 0) {
        return 60;
    }
    else if (indexPath.row == 1) {
        return 40;
    }
    else {
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
    if (indexPath.row == 1) {
        static NSString* CustomTableViewIdentifier = @"LSDStatusViewCell";

        LSDStatusViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CustomTableViewIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:CustomTableViewIdentifier
                                                  owner:self
                                                options:nil] firstObject];
        }

        cell.ib_textLeft.text = LocalString(@"逆变器");
        cell.ib_textCenter.text = LocalString(@"发电量(kWh)");
        cell.ib_textRight.text = LocalString(@"状态");
        cell.ib_img_icon.hidden = YES;
//        [cell setData:self.dataDic];
        return cell;
    }
    else if (indexPath.row > 1) {
        static NSString* CustomTableViewIdentifier = @"LSDPage8Cell";

        LSDPage8Cell* cell = [tableView dequeueReusableCellWithIdentifier:CustomTableViewIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:CustomTableViewIdentifier
                                                  owner:self
                                                options:nil] firstObject];
        }

        [cell setData:[dataArr objectAtIndex:indexPath.row - 2]];

        return cell;
    }
    else {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }

    return nil;
}

#pragma mark Table Delegate Methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row>1) {
        [self.navigationController pushViewController:[[LSDPage8DesViewController alloc] initWithParmsDic:[dataArr objectAtIndex:indexPath.row - 2]] animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
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
