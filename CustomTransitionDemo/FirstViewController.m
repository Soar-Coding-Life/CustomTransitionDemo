#import "FirstViewController.h"
#import "SecondViewController.h"
#import "CollectionViewCell.h"
#import "DataManager.h"
#import "Animator.h"

@interface FirstViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIViewControllerTransitioningDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end

@implementation FirstViewController

static NSString * const kCellIdentifier = @"CollectionViewCellIdentifier";
static const CGFloat kCellSpacing = 8.0;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = kCellSpacing;
    layout.minimumInteritemSpacing = kCellSpacing;
    [self.collectionView setCollectionViewLayout:layout animated:NO];
}

- (void)presentSecondViewControllerWithData:(CellData *)data {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SecondViewController *secondViewController = [storyboard instantiateViewControllerWithIdentifier:@"SecondViewController"];
    
    secondViewController.transitioningDelegate = self;
    secondViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    secondViewController.data = data;
    [self presentViewController:secondViewController animated:YES completion:nil];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [DataManager data].count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    [cell configureWithCellData:[DataManager data][indexPath.row]];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedCell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    self.selectedCellImageViewSnapshot = [self.selectedCell.locationImageView snapshotViewAfterScreenUpdates:NO];
    [self presentSecondViewControllerWithData:[DataManager data][indexPath.row]];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (collectionView.bounds.size.width - kCellSpacing) / 2;
    return CGSizeMake(width, width);
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    FirstViewController *firstVC = (FirstViewController *)presenting;
    SecondViewController *secondVC = (SecondViewController *)presented;
    
    if (![firstVC isKindOfClass:[FirstViewController class]] || ![secondVC isKindOfClass:[SecondViewController class]] || !self.selectedCellImageViewSnapshot) {
        return nil;
    }

    self.animator = [[Animator alloc] initWithType:PresentationTypePresent firstViewController:firstVC secondViewController:secondVC selectedCellImageViewSnapshot:self.selectedCellImageViewSnapshot];
    return self.animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    SecondViewController *secondVC = (SecondViewController *)dismissed;
    if (![secondVC isKindOfClass:[SecondViewController class]] || !self.selectedCellImageViewSnapshot) {
        return nil;
    }
    
    self.animator = [[Animator alloc] initWithType:PresentationTypeDismiss firstViewController:self secondViewController:secondVC selectedCellImageViewSnapshot:self.selectedCellImageViewSnapshot];
    return self.animator;
}

@end
