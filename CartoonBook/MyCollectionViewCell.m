//
//  MyCollectionViewCell.m
//  CartoonBook
//
//  Created by Deepak on 11/08/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import "MyCollectionViewCell.h"
#import "MyGradientView.h"

@implementation MyCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.favouriteIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width-20, 5, 10, 10)];
        self.favouriteIconImageView.image = [UIImage imageNamed:@"disabledTick.png"];
        [self addSubview:self.favouriteIconImageView];
        [self.favouriteIconImageView setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin];
       
        UIView *gradientView = [[MyGradientView alloc] initWithFrame:self.bounds];
        gradientView.tag = 121;
        gradientView.backgroundColor = [UIColor clearColor];
        [self.layer setBorderWidth:3.0f];
        [self.layer setBorderColor:[UIColor blackColor].CGColor];
        [self.layer setCornerRadius:20.0f];
        //self.contentMode = UIViewContentModeScaleToFill;
        
//        NSArray *colors = [NSArray arrayWithObjects:(id)[UIColor blackColor].CGColor,(id)[UIColor whiteColor].CGColor, nil];
//        NSArray *locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],[NSNumber numberWithFloat:1.0], nil];
//        CAGradientLayer *myGradientLayer = [CAGradientLayer layer];
//        myGradientLayer.colors = colors;
//        myGradientLayer.locations = locations;
//        myGradientLayer.frame = self.bounds;
//        
//        CATextLayer *textLayer = [CATextLayer layer];
//        textLayer.string = @"hey";
//        [textLayer.contents setAlignment:NSTextAlignmentCenter];
//        textLayer.frame = myGradientLayer.bounds;
//        [textLayer setAlignmentMode:@"center"];
//        textLayer.position = CGPointMake(CGRectGetMidX(self.layer.bounds), CGRectGetMidY(self.layer.bounds));
//        textLayer.masksToBounds = YES;
//        
//        //  [textLayer setBorderWidth:10.0f];
//        //   textLayer.backgroundColor = [UIColor orangeColor].CGColor;
//        //[textLayer setBorderColor:[UIColor redColor].CGColor];
//        //[self.layer addSublayer:myLayer];
//        //[self.layer replaceSublayer:self.layer with:myLayer];
//        
//        [self.layer insertSublayer:myGradientLayer atIndex:0];
//        [myGradientLayer addSublayer:textLayer];
//        self.layer.masksToBounds = YES;
//        myGradientLayer.masksToBounds = YES;
        //self.backgroundColor = [UIColor orangeColor];
       // self.layer.backgroundColor = [UIColor greenColor].CGColor;

        
        [self addSubview:gradientView];
        [gradientView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
        self.layer.masksToBounds = YES;
//        self.isLarge = NO;
        return  self;
    }
    return nil;
}

- (void) setImageToCell
{
    UIImageView *imageView = [[UIImageView alloc] init];

//    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.dictionaryForEachCartoonFromViewController[@"imageUrl"]]]];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//
//    OR

    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:self.dictionaryForEachCartoonFromViewController[@"imageUrl"]]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                UIImage *image = [[UIImage alloc] initWithData:data];
                [imageView setImage:image];
            }] resume];

    imageView.frame = self.contentView.bounds;
    [imageView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    [(MyGradientView*)[self viewWithTag:121] sendTitle:self.dictionaryForEachCartoonFromViewController[@"name"] andDescription:self.dictionaryForEachCartoonFromViewController[@"description"]];
    if (self.isLarge == YES)
    {
        if ([[UIDevice currentDevice] orientation] != UIInterfaceOrientationPortrait)
        {
            [self sizeThatFits:CGSizeMake(((self.superview.bounds.size.width-40)/4)*2, 100*2)];
        }
        else
        {
            [self sizeThatFits:CGSizeMake(((self.superview.bounds.size.width-40)/3)*2, 100*2)];
        }
    }
    else
    {
        if ([[UIDevice currentDevice] orientation] != UIInterfaceOrientationPortrait)
        {
            [self sizeThatFits:CGSizeMake(((self.superview.bounds.size.width-40)/4), 100)];
        }
        else
        {
            [self sizeThatFits:CGSizeMake(((self.superview.bounds.size.width-40)/3), 100)];
        }
    }
    [self.contentView addSubview:imageView];
}

//- (void)provideIndexPath:(NSIndexPath*)indexPath
//{
//    self.indexPath = indexPath;
//}





@end
