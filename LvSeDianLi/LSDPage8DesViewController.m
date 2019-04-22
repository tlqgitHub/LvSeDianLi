//
//  LSDPage8DesViewController.m
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/8/1.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import "LSDPage8DesViewController.h"
#import "NSDate+Addition.h"

#import "LSDPage8HeadCell.h"

#import "LSDChartViewCell.h"

@interface LSDPage8DesViewController ()
{
    NSArray *dataArr;
}

@end

@implementation LSDPage8DesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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

//+ (NSString *)currentDateStringWithFormat:(NSString *)format;
-(NSString *)getCurDate
{
    return [NSDate currentDateStringWithFormat:@"yyyy-MM-dd"];
    return @"";
}

//GET /iosService.asmx/GetInverterDayPac?inverter_id=string&date=string
- (void)initData
{
    NSDictionary *pram = @{@"inverter_id":[self.parmsDic stringForKey:@"InverterId"],@"date":[self getCurDate]};
    NSString* urlStr = [NSString stringWithFormat:@"%@", API_URL_GetInverterDayPac];
    
    [self httpGetUrl:urlStr WithData:pram completionHandler:^(NSDictionary *data) {
        
        dataArr = [self isNoArr:data key:@"InverterDayInfo"];
//        dataArr = [data arrayForKey:@"InverterDayInfo"];
//        if(!dataArr){
//            dataArr = @[[data dictionaryForKey:@"InverterDayInfo"]];
//        }
        [self.mTableView headerEndRefreshing];
        [self.mTableView reloadData];
    } errorHandler:^(NSString *errMsg) {
        [self.mTableView headerEndRefreshing];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

//设置行的高度
- (CGFloat)tableView:(UITableView*)tableView
heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 460;
    
//    if (indexPath.row==0) {
//        return 60;
//    }else if(indexPath.row==1) {
//        return 420;
//    }else{
//        
//    }
//    return 360;
}

/*
 自定义表格单元格
 */
- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString * CustomTableViewIdentifier =@"LSDChartViewCell";
    
    LSDChartViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CustomTableViewIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:CustomTableViewIdentifier
                                              owner:self
                                            options:nil] firstObject];
    }
    
    [cell setNewLineWithData1:dataArr];
    
    return cell;
//    
//    if (indexPath.row==0) {
//        static NSString * CustomTableViewIdentifier =@"LSDPage8HeadCell";
//        
//        LSDPage8HeadCell * cell = [tableView dequeueReusableCellWithIdentifier:CustomTableViewIdentifier];
//        if (cell == nil) {
//            cell = [[[NSBundle mainBundle] loadNibNamed:CustomTableViewIdentifier
//                                                  owner:self
//                                                options:nil] firstObject];
//        }
//        
//        [cell setData:self.parmsDic lastDic:dataArr?[dataArr lastObject]:nil];
//        return cell;
//    }else if(indexPath.row==1) {
//        static NSString * CustomTableViewIdentifier =@"LSDChartViewCell";
//        
//        LSDChartViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CustomTableViewIdentifier];
//        if (cell == nil) {
//            cell = [[[NSBundle mainBundle] loadNibNamed:CustomTableViewIdentifier
//                                                  owner:self
//                                                options:nil] firstObject];
//        }
//        
//        [cell setNewLineWithData1:dataArr];
//        
//        return cell;
//    }else{
//        
//    }
    
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
