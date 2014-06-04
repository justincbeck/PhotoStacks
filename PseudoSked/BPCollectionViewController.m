//
//  BPViewController.m
//  PseudoSked
//
//  Created by Justin C. Beck on 6/3/14.
//  Copyright (c) 2014 BeckProduct. All rights reserved.
//

#import "BPCollectionViewController.h"
#import "BPPhotoAlbumLayout.h"
#import "BPPhotoAlbumCell.h"
#import "BPAlbumTitleReusableView.h"
#import "BPAlbum.h"
#import "BPPhoto.h"

static NSString * const PhotoCellIdentifier = @"PhotoCell";
static NSString * const AlbumTitleIdentifier = @"AlbumTitle";

@interface BPCollectionViewController ()

@property (weak, nonatomic) IBOutlet BPPhotoAlbumLayout *photoAlbumLayout;

@property (nonatomic, strong) NSMutableArray *albums;
@property (nonatomic, strong) NSOperationQueue *thumbnailQueue;

@end

@implementation BPCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self collectionView] setBackgroundColor:[UIColor colorWithWhite:0.25f alpha:1.0f]];;
    [[self collectionView] registerClass:[BPPhotoAlbumCell class] forCellWithReuseIdentifier:PhotoCellIdentifier];
    
    _albums = [NSMutableArray array];
    
    NSURL *urlPrefix = [NSURL URLWithString:@"https://raw.github.com/ShadoFlameX/PhotoCollectionView/master/Photos/"];
    
    NSInteger photoIndex = 0;
    
    for (NSInteger a = 0; a < 12; a++) {
        BPAlbum *album = [[BPAlbum alloc] init];
        album.name = [NSString stringWithFormat:@"Photo Album %d",a + 1];
        
        NSUInteger photoCount = arc4random()%4 + 2;
        for (NSInteger p = 0; p < photoCount; p++) {
            
            // there are up to 25 photos available to load from the code repository
            
            NSString *photoFilename = [NSString stringWithFormat:@"thumbnail%d.jpg",photoIndex % 25];
            NSURL *photoURL = [urlPrefix URLByAppendingPathComponent:photoFilename];
            BPPhoto *photo = [BPPhoto photoWithImageURL:photoURL];
            [album addPhoto:photo];
            
            photoIndex++;
        }
        
        [self.albums addObject:album];
    }
    
    self.thumbnailQueue = [[NSOperationQueue alloc] init];
    self.thumbnailQueue.maxConcurrentOperationCount = 3;
    
    [self.collectionView registerClass:[BPAlbumTitleReusableView class]
            forSupplementaryViewOfKind:BHPhotoAlbumLayoutAlbumTitleKind
                   withReuseIdentifier:AlbumTitleIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.albums.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    BPAlbum *album = self.albums[section];
    
    return album.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BPPhotoAlbumCell *photoCell = [collectionView dequeueReusableCellWithReuseIdentifier:PhotoCellIdentifier forIndexPath:indexPath];
    
    BPAlbum *album = self.albums[indexPath.section];
    BPPhoto *photo = album.photos[indexPath.item];
    
    __weak BPCollectionViewController *weakSelf = self;
    
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        
        UIImage *image = [photo image];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([weakSelf.collectionView.indexPathsForVisibleItems containsObject:indexPath]) {
                BPPhotoAlbumCell *cell =
                (BPPhotoAlbumCell *)[weakSelf.collectionView cellForItemAtIndexPath:indexPath];
                cell.imageView.image = image;
            }
        });
        
    }];
    
    operation.queuePriority = (indexPath.item == 0) ? NSOperationQueuePriorityHigh : NSOperationQueuePriorityNormal;
    
    [self.thumbnailQueue addOperation:operation];
    
    return photoCell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath;
{
    BPAlbumTitleReusableView *titleView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                             withReuseIdentifier:AlbumTitleIdentifier
                                                                                    forIndexPath:indexPath];
    
    BPAlbum *album = [[self albums] objectAtIndex:[indexPath section]];
    
    [[titleView titleLabel] setText:[album name]];
    
    return titleView;
}

#pragma mark - View Rotation

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation))
    {
        [[self photoAlbumLayout] setNumberOfColumns:3];
        
        CGFloat sideInset = [UIScreen mainScreen].preferredMode.size.width == 1136.0f ? 45.0f : 25.0f;
        
        self.photoAlbumLayout.itemInsets = UIEdgeInsetsMake(22.0f, sideInset, 13.0f, sideInset);
    }
    else
    {
        self.photoAlbumLayout.numberOfColumns = 2;
        
        self.photoAlbumLayout.itemInsets = UIEdgeInsetsMake(22.0f, 22.0f, 13.0f, 22.0f);
    }
}

@end
