//
//  MyGradientView.m
//  CartoonBook
//
//  Created by Deepak on 17/08/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import "MyGradientView.h"

@implementation MyGradientView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.frame = CGRectMake(0, 0, self.bounds.size.width-20, self.bounds.size.height*0.2);
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.tag = 111;
        //textLabel.backgroundColor = [UIColor greenColor];
        [nameLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];

        [self addSubview:nameLabel];
        
        UILabel *descriptionLabel = [[UILabel alloc] init];
        descriptionLabel.frame = CGRectMake(0, nameLabel.bounds.size.height+10, self.bounds.size.width, self.bounds.size.height*0.8);
        descriptionLabel.textColor = [UIColor whiteColor];
        descriptionLabel.textAlignment = NSTextAlignmentCenter;
        descriptionLabel.tag = 222;
        //textLabel.backgroundColor = [UIColor greenColor];
        [descriptionLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [self addSubview:descriptionLabel];
        
    }
    
    return self;
}

- (void)sendTitle:(NSString*)title andDescription:(NSString*)description
{
    ((UILabel*)[self viewWithTag:111]).text = title;
    ((UILabel*)[self viewWithTag:222]).text = description;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGGradientRef glossGradient;
    CGColorSpaceRef rgbColorspace;
    size_t num_locations = 2;
    self.backgroundColor = [UIColor clearColor];
    self.layer.backgroundColor = [UIColor clearColor].CGColor;

    CGFloat locations[2] = { 0.0, 1.0 };
//    CGFloat locations[2] = { 0.0, 0.5 };
    //CGFloat components[8] = { 1.0, 1.0, 1.0, 0.35,  // Start color
    //    1.0, 1.0, 1.0, 0.06 }; // End color
    CGFloat components[8] = { 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.5 };
    rgbColorspace = CGColorSpaceCreateDeviceRGB();
    glossGradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, num_locations);
    CGRect currentBounds = self.bounds;
    CGPoint topCenter = CGPointMake(CGRectGetMidX(currentBounds), 0.0f);
    CGPoint midCenter = CGPointMake(CGRectGetMidX(currentBounds), currentBounds.size.height);
    CGContextDrawLinearGradient(currentContext, glossGradient, topCenter, midCenter, 0);
    
    self.backgroundColor = [UIColor clearColor];
//    self.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:1.0];
    CGGradientRelease(glossGradient);
    CGColorSpaceRelease(rgbColorspace);
    
//            CATextLayer *textLayer = [CATextLayer layer];
//            textLayer.string = @"hey";
//            [textLayer.contents setAlignment:NSTextAlignmentCenter];
//            textLayer.frame = self.bounds;
//            [self.layer insertSublayer:textLayer above:self.layer];
//            [textLayer setAlignmentMode:@"center"];
//            textLayer.position = CGPointMake(CGRectGetMidX(self.layer.bounds), CGRectGetMidY(self.layer.bounds));
//            textLayer.masksToBounds = YES;
    
            //  [textLayer setBorderWidth:10.0f];
            //   textLayer.backgroundColor = [UIColor orangeColor].CGColor;
            //[textLayer setBorderColor:[UIColor redColor].CGColor];
            //[self.layer addSublayer:myLayer];
            //[self.layer replaceSublayer:self.layer with:myLayer];
    
    
    
    
    
}

@end
