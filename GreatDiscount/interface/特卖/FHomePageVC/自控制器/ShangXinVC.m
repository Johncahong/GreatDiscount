//
//  ShangXinVC.m
//  GreatDiscount
//
//  Created by Hello Cai on 16/4/18.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "ShangXinVC.h"
#import "AdsModel.h"
#import "ProModel.h"
#import "SXView.h"
#import "ImgModel.h"
#import "SXCellTableViewCell.h"
@interface ShangXinVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UIScrollView *commonScrollView;
@property(nonatomic,strong)SXView *sxview;
@property(nonatomic,strong)UIView *topview;
@property(nonatomic,strong)NSMutableArray *scrolArray;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ShangXinVC
-(NSMutableArray *)scrolArray{
    if(!_scrolArray){
        _scrolArray = [[NSMutableArray alloc] init];
    }
    return _scrolArray;
}

-(NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getHeaderView];
    [self getTopHeaderRequest];
    
    [self getRequest];
}

-(void)getHeaderView{
    
    _topview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 267*SizeScale_H+42)];
    [self.view addSubview:_topview];
    
    //广告图片
    _commonScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100 *SizeScale_H)];
    _commonScrollView.pagingEnabled = YES;
    _commonScrollView.showsHorizontalScrollIndicator = NO;
    [_topview addSubview:_commonScrollView];
    
    //无规律的视图，已经自定义
    _sxview = [[SXView alloc] initWithFrame:CGRectMake(0, 100*SizeScale_H, ScreenWidth, 167*SizeScale_H)];
    [_topview addSubview:_sxview];
    
    //每日特价的标题
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 267*SizeScale_H, ScreenWidth, 42)];
    [_topview addSubview:view];
    
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 7)];
    bgview.backgroundColor = [UIColor grayColor];
    bgview.alpha = 0.1;
    [view addSubview:bgview];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, ScreenWidth, 36)];
    label.text = @"- 今日上新 每天9点上新 -";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];

    
    _tableView.tableHeaderView = _topview;
    _tableView.rowHeight = 154*SizeScale_H ;
}

#pragma mark - 网络数据请求
-(void)getTopHeaderRequest{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:KScroll_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for (NSDictionary *dict in responseObject[@"ads"]) {
            AdsModel *model = [[AdsModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [self.scrolArray addObject:model];
        }
        
        NSMutableArray *newArr = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in responseObject[@"promotion_shortcuts"]) {

            ProModel *promodel = [[ProModel alloc] init];
            [promodel setValuesForKeysWithDictionary:dict];
            [newArr addObject:promodel];
        }
        _sxview.array = newArr;
        
        //过滤掉注册的轮播图
        _commonScrollView.contentSize = CGSizeMake(ScreenWidth * (_scrolArray.count-1), 100*SizeScale_H);
        for (int i = 1; i <_scrolArray.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth*(i-1), 0, ScreenWidth, 100*SizeScale_H)];
            AdsModel *model = _scrolArray[i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@""]];
            [_commonScrollView addSubview:imageView];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败%@",error);
    }];
}

-(void)getRequest{
     AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:TeMai_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for (NSDictionary *dict in responseObject[@"mz_martshows"]) {
            ImgModel *model = [[ImgModel alloc] init];
            model.main_img = dict[@"main_img"];
            [self.dataArray addObject:model];
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败%@",error);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SXCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SXCellTableViewCell"];
    cell.model = self.dataArray[indexPath.row];
    return cell;
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
