//
//  MyCollectionViewCell.h
//  CartoonBook
//
//  Created by Deepak on 11/08/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionViewCell : UICollectionViewCell


//- (MyCollectionViewCell*) blackAndWhiteGradientWithCollectionView:(UICollectionView*)collectionView andIndexPath:(NSIndexPath*)indexPath;

@property BOOL isLarge;
@property NSDictionary *dictionaryForEachCartoonFromViewController;
@property UIImageView *favouriteIconImageView;
//@property NSMutableArray *selectedCellsIndexPathMutableArray;
- (instancetype)initWithFrame:(CGRect)frame;
- (void) setImageToCell;


@end
