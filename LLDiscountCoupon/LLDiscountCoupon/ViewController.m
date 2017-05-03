//
//  ViewController.m
//  LLDiscountCoupon
//
//  Created by 宇航 on 17/5/3.
//  Copyright © 2017年 青岛市北区. All rights reserved.
//

#import "ViewController.h"
#import "UserOrderManageCollectionViewCell.h"
#import "UIViewExt.h"
#import "CardCouponCell.h"
#import "CardCouponModel.h"

#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic)  UICollectionView *collectionView;
@property (weak, nonatomic)  UITableView * tableView;
@property (strong, nonatomic) NSArray *titleArrays;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;
@property (nonatomic, strong) NSMutableArray <CardCouponModel *> *models;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUPCollectionView];
    [self setUPTableViewView];
    self.navigationController.navigationBar.translucent = NO;
    [self initData];
}

- (void)initData {
    
    _models = [NSMutableArray arrayWithCapacity:0];
    
    for (int i = 0; i < 15; i ++) {
        
        CardCouponModel *model = [[CardCouponModel alloc] init];
        
        model.content = @"http://192.168.1.123:8080http://192.168.1.123:8080http://192.168.1.123:8080http://192.168.1.123:8080http://192.168.1.123:8080http://192.168.1.123:8080http://192.168.1.123:8080http://192.168.1.123:8080";
        
        model.open = NO;
        
        [_models addObject:model];
    }
    
    
    
}

- (void)setUPTableViewView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.collectionView.bottom, KScreenWidth, KScreenHeight - 64 - 45)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*return cell.frame.size.height;*/
    
    CardCouponModel *model = nil;
    if ([self.models count] > indexPath.row)
    {
        model = [self.models objectAtIndex:indexPath.row];
    }
    
    // 根据isShowMoreText属性判断cell的高度
    if (model.open)
    {
        return [CardCouponCell cellMoreHeight:model];
    }
    else
    {
        return [CardCouponCell cellDefaultHeight:model];
    }
    return 0;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CardCouponCell * cell = [[CardCouponCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"123"];
//    cell.textLabel.text = @"2233213";
    
    if ([self.models count] > indexPath.row)
    {
        //这里的判断是为了防止数组越界
        cell.model = [self.models objectAtIndex:indexPath.row];
    }
    
    
    cell.refresh = ^(UITableViewCell *currentCell) {
        
        // 这里多传一个model，如果有id可以判断indexPath，因为小心分页加载的问题
        
        NSIndexPath *indexRow = [self.tableView indexPathForCell:(CardCouponCell *)currentCell];
        
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexRow, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    
    return cell;
}

- (void)setUPCollectionView {
    
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
    //flowLayout.itemSize = CGSizeMake(floorf([UIScreen mainScreen].bounds.size.width / self.titleArrays.count) - 1, 45);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical]; //横向滚动
    //分别为上、左、下、右
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 45) collectionViewLayout:flowLayout];
    //
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionView];
    _collectionView = collectionView;
    
    UINib *nibName = [UINib nibWithNibName:NSStringFromClass([UserOrderManageCollectionViewCell class]) bundle:nil];
    [self.collectionView registerNib:nibName forCellWithReuseIdentifier:NSStringFromClass([UserOrderManageCollectionViewCell class])];
    self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
}

#pragma mark - Getters & Setters

- (NSArray *)titleArrays {
    if (!_titleArrays) {
        _titleArrays = @[
                         @"未使用",
                         @"已使用",
                         @"已过期"
                         ];
    }
    return _titleArrays;
}
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.titleArrays.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UserOrderManageCollectionViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UserOrderManageCollectionViewCell class])
                                              forIndexPath:indexPath];
    NSString *title = self.titleArrays[indexPath.item];
    cell.backgroundColor = [UIColor whiteColor];
    cell.titleLabel.text = [NSString stringWithFormat:@"%@",title];
    cell.lineView.hidden = ![self.selectedIndexPath isEqual:indexPath];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(floorf([UIScreen mainScreen].bounds.size.width / self.titleArrays.count) - 1, 45);
}

// 该方法是设置一个section的上左下右边距
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    // 注意，这里默认会在top有+64的边距，因为状态栏+导航栏是64.
//    // 因为我们常常把[[UIScreen mainScreen] bounds]作为CollectionView的区域，所以苹果API就默认给了+64的EdgeInsets，这里其实是一个坑，一定要注意。
//    // 这里我暂时不用这个边距，所以top减去64
//    // 所以这是就要考虑你是把Collection从屏幕左上角(0,0)开始放还是(0,64)开始放。
//    return UIEdgeInsetsMake(-44, 0, 0, 0);
//}

// 两个cell之间的最小间距，是由API自动计算的，只有当间距小于该值时，cell会进行换行
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

// 两行之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndexPath = indexPath;
    [collectionView reloadData];
    NSString *title = self.titleArrays[indexPath.item];
    UserOrderType type = [self getOrderTypeWithTitle:title];
    NSLog(@"type:::::::%@",@(type));
}

#pragma mark - private

- (UserOrderType)getOrderTypeWithTitle:(NSString *)title {
    if ([title isEqualToString:@"全部"]) {
        return UserCouponTypeAll;
    } else if ([title isEqualToString:@"未使用"]) {
        return UserCouponTypeAvailable;
    } else if ([title isEqualToString:@"已使用"]) {
        return UserCouponTypeUnavailable;
    } else if ([title isEqualToString:@"已过期"]) {
        return UserCouponTypeOutOfDate;
    }
    return UserCouponTypeAll;
}

@end
