//
//  CustomCollectionViewLayout.h
//  FZJDemo
//
//  Created by 陈舒澳 on 16/3/29.
//  Copyright © 2016年 FZJ.com. All rights reserved.
//
/**
 *  屏幕宽
 */
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

/**
 *  屏幕高
 */
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#import <UIKit/UIKit.h>
@class CustomCollectionViewLayout;
@protocol CustomCollectionViewLayoutDelegate <NSObject>
@required
/**
 *  @brief 每个cell之间的间距
 */
-(NSInteger)CustomCollectionViewLayout:(CustomCollectionViewLayout *)collectionViewLayout marginOfCellWithCollectionView:(UICollectionView *)collectionView;
/**
 *  @brief cell的最小高度
 */
-(NSInteger)CustomCollectionViewLayout:(CustomCollectionViewLayout *)collectionViewLayout minHeightOfCellWithCollectionView:(UICollectionView *)collectionView;
/**
 *  @brief cell的最大高度
 */
-(NSInteger)CustomCollectionViewLayout:(CustomCollectionViewLayout *)collectionViewLayout maxrOfCellWithCollectionView:(UICollectionView *)collectionView;
/**
 *  @brief 行数
 */
-(NSInteger)CustomCollectionViewLayout:(CustomCollectionViewLayout *)collectionViewLayout numberOfColumnWithCollectionView:(UICollectionView *)collectionView;
@end
@interface CustomCollectionViewLayout : UICollectionViewLayout
@property (nonatomic,weak) id<CustomCollectionViewLayoutDelegate>delegate;
@end
