//
//  WaterFallController.m
//  WaterFall
//
//  Created by 陈舒澳 on 16/4/8.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import "WaterFallController.h"
#import "CustomCollectionViewLayout.h"
#import "WaterFallCollectionCell.h"
@interface WaterFallController ()<CustomCollectionViewLayoutDelegate>
@property (nonatomic,strong) CustomCollectionViewLayout * customLayout;
@end
@implementation WaterFallController

static NSString * const reuseIdentifier = @"Cell";

-(void)viewDidLoad{
    [super viewDidLoad];
    _customLayout = (CustomCollectionViewLayout *)self.collectionViewLayout;
    _customLayout.delegate = self;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1000;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WaterFallCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    int imageIndex = arc4random() % 30;
    //下面这种方式加载图片，内存最终会被释放
    NSString * imageName = [NSString stringWithFormat:@"%d.jpg",imageIndex];
    NSString * path = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
    cell.imageCell.image = [UIImage imageWithContentsOfFile:path];
    //下面这种图片加载方式常驻内存，不会被释放
    //    cell.imageCell.image = [UIImage imageNamed:imageName];
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"选中了第%d张",indexPath.row);
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < 0) {
        offsetY = 0 ;
    }
    self.navigationController.navigationBar.alpha = (300 - offsetY) / 300;
}
#pragma mark --- CustomCollectionViewLayoutDelegate
-(NSInteger)CustomCollectionViewLayout:(CustomCollectionViewLayout *)collectionViewLayout marginOfCellWithCollectionView:(UICollectionView *)collectionView{
    return 2;
}
-(NSInteger)CustomCollectionViewLayout:(CustomCollectionViewLayout *)collectionViewLayout maxrOfCellWithCollectionView:(UICollectionView *)collectionView{
    return 150;
}
-(NSInteger)CustomCollectionViewLayout:(CustomCollectionViewLayout *)collectionViewLayout minHeightOfCellWithCollectionView:(UICollectionView *)collectionView{
    return 100;
}
-(NSInteger)CustomCollectionViewLayout:(CustomCollectionViewLayout *)collectionViewLayout numberOfColumnWithCollectionView:(UICollectionView *)collectionView{
    return 2;
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



#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
