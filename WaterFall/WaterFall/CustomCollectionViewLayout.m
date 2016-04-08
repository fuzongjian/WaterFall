//
//  CustomCollectionViewLayout.m
//  FZJDemo
//
//  Created by 陈舒澳 on 16/3/29.
//  Copyright © 2016年 FZJ.com. All rights reserved.
//


#import "CustomCollectionViewLayout.h"
@interface CustomCollectionViewLayout ()
@property (nonatomic,assign) NSInteger numberOfSections;//section的数量
@property (nonatomic,assign) NSInteger  numberOfCellInSections;//section中cell的数量
@property (nonatomic,assign) NSInteger  columnCount;//行数
@property (nonatomic,assign) NSInteger  margin;//cell之间的间距
@property (nonatomic,assign) NSInteger  cellMinHeight;//cell的最小高度
@property (nonatomic,assign) NSInteger  cellMaxHeight;//cell的最大高度
@property (nonatomic,assign) NSInteger  cellWidth;//cell的宽度
@property (nonatomic,strong) NSMutableArray * cellHeightArray;//存储每个cell的随机高度
@property (nonatomic,strong) NSMutableArray * cellXArray;//存储每列cell的X坐标
@property (nonatomic,strong) NSMutableArray * cellYArray;//存储每列cell的最新cell的Y坐标
@end
@implementation CustomCollectionViewLayout
/**
 *  @brief 预加载layout，只会被执行一次
 */
- (void)prepareLayout{
    [super prepareLayout];
    [self initCustonCollectionViewLayoutDate];
    [self initCustonCollectionViewLayoutCellWidth];
    [self initCustonCollectionViewLayoutCellHeight];
}
#pragma mark --- 系统方法的实现
#pragma mark --- 返回collectionView的ContenSize的大小
-(CGSize)collectionViewContentSize{
    CGFloat height = [self selectMaxCellYWithArray:_cellYArray];
    return CGSizeMake(SCREEN_WIDTH, height);
}
#pragma mark --- 每个cell绑定一个Layout属性
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    [self initCellYArray];
    NSMutableArray * array = [NSMutableArray array];
    for (int i = 0; i < _numberOfCellInSections; i ++) {
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes * attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [array addObject:attributes];
    }
    return array;
}
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes * attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGRect frame = CGRectZero;
    CGFloat cellHeight = [[_cellHeightArray objectAtIndex:indexPath.row] floatValue];
    NSInteger minYIndex = [self selectMinIndexWithArray:_cellYArray];
    CGFloat X = [[_cellXArray objectAtIndex:minYIndex] floatValue];
    CGFloat Y = [[_cellYArray objectAtIndex:minYIndex] floatValue];
    frame = CGRectMake(X, Y, _cellWidth, cellHeight);
    _cellYArray[minYIndex] = @(Y + cellHeight + _margin);//更新相应的Y坐标
    attributes.frame = frame;//计算每个cell的位置
    return attributes;
}
#pragma mark --- 自定义方法实现
#pragma mark --- 初始化相关数据
- (void)initCustonCollectionViewLayoutDate{
    _numberOfSections = [self.collectionView numberOfSections];
    _numberOfCellInSections = [self.collectionView numberOfItemsInSection:0];
    _margin = [_delegate CustomCollectionViewLayout:self marginOfCellWithCollectionView:self.collectionView];
    _columnCount = [_delegate CustomCollectionViewLayout:self numberOfColumnWithCollectionView:self.collectionView];
    _cellMinHeight = [_delegate CustomCollectionViewLayout:self minHeightOfCellWithCollectionView:self.collectionView];
    _cellMaxHeight = [_delegate CustomCollectionViewLayout:self maxrOfCellWithCollectionView:self.collectionView];
}
#pragma mark --- 根据列数求出cell的宽度
- (void)initCustonCollectionViewLayoutCellWidth{
    _cellWidth = (SCREEN_WIDTH - (_columnCount - 1) * _margin) / _columnCount;//计算每个cell的宽度
    _cellXArray = [[NSMutableArray alloc] initWithCapacity:_columnCount];//每个cell的X坐标
    for (int i = 0; i < _columnCount; i ++) {
        CGFloat cellX = i * (_cellWidth + _margin);
        [_cellXArray addObject:@(cellX)];
    }
}
#pragma mark --- 随机生成cell的高度（根据最大和最小的高度）
- (void)initCustonCollectionViewLayoutCellHeight{
    _cellHeightArray = [[NSMutableArray alloc] initWithCapacity:_numberOfCellInSections];
    for (int i = 0; i < _numberOfCellInSections; i ++) {
        CGFloat cellHeight = arc4random() % _cellMaxHeight + _cellMinHeight;
        [_cellHeightArray addObject:@(cellHeight)];
    }
}
#pragma mark --- 求cellY数组中的最大值并返回
- (CGFloat)selectMaxCellYWithArray:(NSMutableArray *)array{
    if (array.count == 0) {
        return 0.0f;
    }
    CGFloat max = [[array firstObject] floatValue];
    for (NSNumber * number in array) {
        if (max < [number floatValue]) {
            max = [number floatValue];
        }
    }
    return max;
}
#pragma mark --- 求cellY数组中的最小值索引
- (NSInteger)selectMinIndexWithArray:(NSMutableArray *)array{
    if (array.count == 0) {
        return 0.0f;
    }
    NSInteger minIndex = 0;
    CGFloat min = [[array firstObject] floatValue];
    for (int i = 0; i < array.count; i ++) {
        if (min > [array[i] floatValue]) {
            min = [array[i] floatValue];
            minIndex = i;
        }
    }
    return minIndex;
}
#pragma mark --- 初始化每列cell的Y轴坐标
- (void)initCellYArray{
    _cellYArray = [NSMutableArray arrayWithCapacity:_columnCount];
    for (int i = 0; i < _columnCount; i ++) {
        [_cellYArray addObject:@(0)];
    }
}
@end
