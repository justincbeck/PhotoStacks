//
//  BPAlbum.m
//  PseudoSked
//
//  Created by Justin C. Beck on 6/3/14.
//  Copyright (c) 2014 BeckProduct. All rights reserved.
//

#import "BPAlbum.h"
#import "BPPhoto.h"

@interface BPAlbum ()

@property (nonatomic, strong) NSMutableArray *mutablePhotos;

@end

@implementation BPAlbum

#pragma mark - Properties

- (NSArray *)photos
{
    return [[self mutablePhotos] copy];
}


#pragma mark - Lifecycle

- (id)init
{
    if (self = [super init])
    {
        [self setMutablePhotos:[NSMutableArray array]];
    }
    
    return self;
}

#pragma mark - Photos

- (void)addPhoto:(BPPhoto *)photo
{
    [[self mutablePhotos] addObject:photo];
}

- (BOOL)removePhoto:(BPPhoto *)photo
{
    if ([[self mutablePhotos] indexOfObject:photo] == NSNotFound)
    {
        return NO;
    }
    
    [[self mutablePhotos] removeObject:photo];
    
    return YES;
}



@end
