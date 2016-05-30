//
//  ViewController.m
//  CollectionView_01
//
//  Created by SuperWang on 16/5/23.
//  Copyright © 2016年 SuperWang. All rights reserved.
//

#import "ViewController.h"
#import "CustomCollectionViewCell.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //每一个collectionView必须有个layout
    //layout布局就是collectionView的精华所在
    //不同的layout可以布局不同的界面效果
    //layout是可以自定义的,系统也给我们提供了常用的子类
    //系统提供的UICollectionViewFlowLayout(显示九宫格样式)
    //flowLayout可以实际大部分程序的布局需求所以一般都使用这个layout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    //设置行间距-最小行间距
    flowLayout.minimumLineSpacing = 0;
    //设置每单元格左右间距
    flowLayout.minimumInteritemSpacing = 0;
    //滑动的方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置view的周边间距
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 0, 10, 0);
    //设置单元格的大小
    flowLayout.itemSize = CGSizeMake(CGRectGetWidth([[UIScreen mainScreen]bounds]),CGRectGetHeight([[UIScreen mainScreen]bounds]));
    
    //一个layout对象不能同时用在多个collectionView上
    
    
    //穿件collectionView
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    collectionView.delegate =self;
    collectionView.pagingEnabled = YES;
    //collectionView 跟tableview类似
    
    [self.view addSubview:collectionView];
    
    collectionView.backgroundColor = [UIColor whiteColor];
    //跟tableview一样,先注册cell
//    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [collectionView registerNib:[UINib nibWithNibName:@"CustomCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:(arc4random()%255)/255.f green:(arc4random()%255)/255.f blue:(arc4random()%255)/255.f alpha:1];
    cell.titleLabel.text = [NSString stringWithFormat:@"-%ld-",indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.row);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end






