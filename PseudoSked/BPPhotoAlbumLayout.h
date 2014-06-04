//
//  BPPhotoAlbumLayout.h
//  PseudoSked
//
//  Created by Justin C. Beck on 6/3/14.
//  Copyright (c) 2014 BeckProduct. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString * const BHPhotoAlbumLayoutAlbumTitleKind;

@interface BPPhotoAlbumLayout : UICollectionViewLayout

@property (nonatomic, assign) UIEdgeInsets itemInsets;
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGFloat interItemSpacingY;
@property (nonatomic, assign) NSInteger numberOfColumns;
@property (nonatomic, assign) CGFloat titleHeight;

@end
