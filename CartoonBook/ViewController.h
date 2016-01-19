//
//  ViewController.h
//  CartoonBook
//
//  Created by Deepak on 10/08/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import "MyCollectionViewCell.h"
#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"

@interface ViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource>

@property UICollectionView *collectionView;
@property NSMutableArray *selectedCellsIndexPathMutableArray;
@property NSDictionary *dataFromURLDictionary;
@property NSArray *sectionsNamesArray;
@property (nonatomic) int currentIndex;

@end

