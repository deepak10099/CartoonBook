//
//  ViewController.m
//  CartoonBook
//
//  Created by Deepak on 10/08/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import "ViewController.h"
#import "MyCollectionViewCell.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    //    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    //    [self setUpViewForOrientation:interfaceOrientation];

//    NSData *dataFromURL = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://fathomless-shelf-5846.herokuapp.com/api/photos"]];
//    OR

    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:@"http://fathomless-shelf-5846.herokuapp.com/api/photos"]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                NSError *dataImportError = nil;
                self.dataFromURLDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&dataImportError];
                self.sectionsNamesArray = [self.dataFromURLDictionary allKeys];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.collectionView reloadData];
                });
            }] resume];

    
    self.sectionsNamesArray = [self.dataFromURLDictionary allKeys];
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setItemSize:CGSizeMake(100, 100)];
    [flowLayout setMinimumInteritemSpacing:0.f];
    [flowLayout setMinimumLineSpacing:7.f];
    [flowLayout setSectionInset:UIEdgeInsetsMake(20, 10, 10, 20)];
    //flowLayout.sectionInset = UIEdgeInsetsMake(20, 10, 20, 10);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //self.view.backgroundColor = [UIColor greenColor];
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[UICollectionReusableView class]
            forSupplementaryViewOfKind: UICollectionElementKindSectionHeader
                   withReuseIdentifier:@"HeaderView"];
    [self.view addSubview:self.collectionView];
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        UILabel *label = nil;
        UICollectionReusableView *collectionReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        if ([collectionReusableView viewWithTag:100] == nil)
        {
            label=[[UILabel alloc] initWithFrame:collectionReusableView.layer.bounds];
            label.tag = 100;
            label.textColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            collectionReusableView.layer.contents = (id)[UIImage imageNamed:@"sectionHeader1.jpg"].CGImage;
        }
        else
        {
            label = (UILabel*)[collectionReusableView viewWithTag:100];
        }
        label.text=self.sectionsNamesArray[indexPath.section];
        [collectionReusableView addSubview:label];
        return collectionReusableView;
    }
    return nil;
}


//- (void) cellTapped:(UITapGestureRecognizer*)sender
//{
//    if(selected == YES)
//    {
////        [sender view].frame = CGRectMake(0, 0, 300, 500);
////        for (<#initialization#>; <#condition#>; <#increment#>) {
////            <#statements#>
////        }
////        self.collectionView.indexPathsForSelectedItems ;
//
//    }
//    else
//    {
//         selected = YES;
//        [sender view].frame = CGRectMake(0, 0, 100, 100);
//
//       // [self.collectionView performBatchUpdates:nil completion:nil];
//    }
//}



- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //    if ([collectionView.indexPathsForSelectedItems containsObject:indexPath])
    if (((MyCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:indexPath]).isLarge) {
        
        if ([[UIDevice currentDevice] orientation] != UIInterfaceOrientationPortrait)
        {
            return CGSizeMake(((self.view.bounds.size.width-40)/4)*2, 100*2);
        }
        else
        {
            return CGSizeMake(((self.view.bounds.size.width-40)/3)*2, 100*2);
        }
        //return CGSizeMake(collectionView.bounds.size.width - 200, collectionView.bounds.size.height - (300 + [self.topLayoutGuide length]));
    }
    else
    {
        if ([[UIDevice currentDevice] orientation] != UIInterfaceOrientationPortrait)
        {
            return CGSizeMake(((self.view.bounds.size.width-40)/4), 100);
        }
        else
        {
            return CGSizeMake(((self.view.bounds.size.width-40)/3), 100);
        }
    }
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //UIImageView *favouriteIconImageView = [UIImageView alloc] initWithFrame:<#(CGRect)#>
    if (  ((MyCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:indexPath]).isLarge  )
    {
        // [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
        ((MyCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:indexPath]).isLarge = NO;
        [collectionView performBatchUpdates:nil completion:nil];
        [self.selectedCellsIndexPathMutableArray removeObject:indexPath];
        // self.favouritesMutableArray
        //        [((MyCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:indexPath]) setNeedsLayout];
        
    }
    else
    {
        //        UIImage *disabledIconImage = [UIImage imageNamed:@"disabledTick.png"];
        //        UIImageView *favouriteIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(((MyCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath]).bounds.size.width-5.0,5.0, 10, 10)];
        //        favouriteIconImageView.image = disabledIconImage;
        // [((MyCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:indexPath]) addSubview:favouriteIconImageView];
        ((MyCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:indexPath]).isLarge = YES;
        [collectionView performBatchUpdates:nil completion:nil];
        [self.selectedCellsIndexPathMutableArray  addObject:indexPath];
        //        [((MyCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:indexPath]) setNeedsLayout];
        
    }
}

//-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
//    ((MyCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:indexPath]).isLarge = NO;
//    [collectionView performBatchUpdates:nil completion:nil];
//}


//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (UIDeviceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
//        self.view.frame = [[UIScreen mainScreen] bounds];
//        self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight |
//        UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
//        UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
//        return CGSizeMake(70.f, 70.f);
//
//    }
//    return CGSizeMake(100.f, 100.f);
//
//}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:
(NSTimeInterval)duration {
    self.collectionView.frame = self.view.bounds;
    [self.collectionView performBatchUpdates:nil completion:nil];
    //self.contentMode = UIViewContentModeScaleToFill;
    //    // Fade the collectionView out
    //    [self.collectionView setAlpha:0.0f];
    //
    //    // Suppress the layout errors by invalidating the layout
    //    [self.collectionView.collectionViewLayout invalidateLayout];
    //
    //    // Calculate the index of the item that the collectionView is currently displaying
    //    CGPoint currentOffset = [self.collectionView contentOffset];
    //    self.currentIndex = currentOffset.x / self.collectionView.frame.size.width;
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    self.collectionView.frame = self.view.bounds;
    [self.collectionView performBatchUpdates:nil completion:nil];
    //    // Force realignment of cell being displayed
    //    CGSize currentSize = self.collectionView.bounds.size;
    //    float offset = self.currentIndex * currentSize.width;
    //    [self.collectionView setContentOffset:CGPointMake(offset, 0)];
    //
    //    // Fade the collectionView back in
    //    [UIView animateWithDuration:0.125f animations:^{
    //        [self.collectionView setAlpha:1.0f];
    //    }];
}


//  layoutAttributesForItemAtIndexPath:






- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize headerSize = CGSizeMake(320, 44);
    return headerSize;
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.sectionsNamesArray.count;
    
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *cartoonsInEachSectionArray = self.dataFromURLDictionary[self.sectionsNamesArray[section]];
    return cartoonsInEachSectionArray.count;
}

-(UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //MyCollectionViewCell *myCell = [[MyCollectionViewCell alloc] init];
    MyCollectionViewCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSArray *cartoonsInEachSectionArray = self.dataFromURLDictionary[self.sectionsNamesArray[indexPath.section]];
    myCell.dictionaryForEachCartoonFromViewController = cartoonsInEachSectionArray[indexPath.row];
    //myCell.selectedCellsIndexPathMutableArray = self.selectedCellsIndexPathMutableArray;
    myCell.setImageToCell;
    
    // UICollectionViewCell *cell = [myCell blackAndWhiteGradientWithCollectionView:(UICollectionView*)collectionView andIndexPath:(NSIndexPath*)indexPath];
    //    UITapGestureRecognizer *cellTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTapped:)];
    //    [cell addGestureRecognizer:cellTapGestureRecognizer];
    //    [myCell configure];
    //  [myCell provideIndexPath:indexPath];
    return myCell;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
