//
//  SaleViewController.m
//  GreatDiscount
//
//  Created by Hello Cai on 16/4/15.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "SaleViewController.h"
#import "TopbtnView.h"
#import "AdsModel.h"

@interface SaleViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIScrollView *scrollViewVC;

@property(nonatomic,strong)TopbtnView *topView;

@end

@implementation SaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getUI];
    [self addChildVC];

}

-(void)getUI{
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"优折";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    

    self.automaticallyAdjustsScrollViewInsets = NO;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    //获取topview的宽度
    NSString *str = @"上新女装鞋包居家美妆美食母婴童装";
    CGRect rect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    _topView = [[TopbtnView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width + 6*20 +10*2, 40) titlesArray:@[@"上新",@"女装",@"鞋包",@"居家",@"美妆",@"美食",@"母婴童装"]];
    _scrollView.contentSize = CGSizeMake(rect.size.width + 6*20 +10*2, 40);
    [self.scrollView addSubview:_topView];
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TopViewBtnClick:) name:Notification_LxTopView_BtnClick object:nil];

}

-(void)addChildVC{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _scrollViewVC = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth, ScreenHeight-40)];
    [self.view addSubview:_scrollViewVC];
    self.scrollViewVC.pagingEnabled = YES;
    self.scrollViewVC.contentSize = CGSizeMake(7 * _scrollViewVC.width, _scrollViewVC.height);
    ShangXinVC *svc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ShangXinVC"];
    svc.view.frame = CGRectMake(0, 0, _scrollViewVC.width, _scrollViewVC.height);
    [_scrollViewVC addSubview:svc.view];
    
    NvZhuangVC *nvc = [[NvZhuangVC alloc] init];
    nvc .view.frame = CGRectMake(_scrollViewVC.width, 0, _scrollViewVC.width, _scrollViewVC.height);
    [_scrollViewVC addSubview:nvc.view];
    
    XieBaoVC *xvc = [[XieBaoVC alloc] init];
    xvc .view.frame = CGRectMake(_scrollViewVC.width *2, 0, _scrollViewVC.width, _scrollViewVC.height);
    [_scrollViewVC addSubview:xvc.view];
    
    JuJiaVC *jvc = [[JuJiaVC alloc] init];
    jvc .view.frame = CGRectMake(_scrollViewVC.width *3, 0, _scrollViewVC.width, _scrollViewVC.height);
    [_scrollViewVC addSubview:jvc.view];
    
    MeiZhuangVC *mvc = [[MeiZhuangVC alloc] init];
    mvc .view.frame = CGRectMake(_scrollViewVC.width *4, 0, _scrollViewVC.width, _scrollViewVC.height);
    [_scrollViewVC addSubview:mvc.view];
    
    MeiShiVC *vcm = [[MeiShiVC alloc] init];
    vcm .view.frame = CGRectMake(_scrollViewVC.width *5, 0, _scrollViewVC.width, _scrollViewVC.height);
    [_scrollViewVC addSubview:vcm.view];
    
    MumBabyVC *vcb = [[MumBabyVC alloc] init];
    vcb .view.frame = CGRectMake(_scrollViewVC.width *6, 0, _scrollViewVC.width, _scrollViewVC.height);
    [_scrollViewVC addSubview:vcb.view];
    
    //添加视图控制器的层级结构
    //添加视图控制器的层级结构
    [self addChildViewController:svc];
    [self addChildViewController:nvc];
    [self addChildViewController:xvc];
    [self addChildViewController:jvc];
    [self addChildViewController:mvc];
    [self addChildViewController:vcm];
    [self addChildViewController:vcb];
    
    //添加kvo,对当前对象添加一个观察，用来观察scrollView的contentOffset属性
    [_scrollViewVC addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    
}

-(void)TopViewBtnClick:(NSNotification *)notify{
    
    // 获取通知传过来的值
    //    NSDictionary *dict = [notify userInfo];
      _scrollViewVC.contentOffset = CGPointMake(ScreenWidth *self.topView.selectedIndex, 0);
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (object == _scrollViewVC && [keyPath isEqualToString:@"contentOffset"]) {
        NSValue *pointValue = change[@"new"];
        CGPoint point ;
        [pointValue getValue:&point];
        self.topView.selectedIndex = point.x / _scrollViewVC.width;
    }

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
