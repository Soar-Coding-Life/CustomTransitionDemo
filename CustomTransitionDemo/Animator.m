#import "Animator.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "CollectionViewCell.h"

@interface Animator ()

@property (nonatomic, assign) PresentationType type;
@property (nonatomic, weak) FirstViewController *firstViewController;
@property (nonatomic, weak) SecondViewController *secondViewController;
@property (nonatomic, strong) UIView *selectedCellImageViewSnapshot;
@property (nonatomic, assign) CGRect cellImageViewRect;
@property (nonatomic, assign) CGRect cellLabelRect;

@end

@implementation Animator

static const NSTimeInterval duration = 0.45;

- (instancetype)initWithType:(PresentationType)type
         firstViewController:(FirstViewController *)firstViewController
        secondViewController:(SecondViewController *)secondViewController
 selectedCellImageViewSnapshot:(UIView *)selectedCellImageViewSnapshot {
    self = [super init];
    if (self) {
        _type = type;
        _firstViewController = firstViewController;
        _secondViewController = secondViewController;
        _selectedCellImageViewSnapshot = selectedCellImageViewSnapshot;

        UIWindow *window = firstViewController.view.window ?: secondViewController.view.window;
        CollectionViewCell *selectedCell = firstViewController.selectedCell;

        if (!window || !selectedCell) {
            return nil;
        }

        _cellImageViewRect = [selectedCell.locationImageView convertRect:selectedCell.locationImageView.bounds toView:window];
        _cellLabelRect = [selectedCell.locationLabel convertRect:selectedCell.locationLabel.bounds toView:window];
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = transitionContext.containerView;
    UIView *toView = self.secondViewController.view;

    if (!toView) {
        [transitionContext completeTransition:NO];
        return;
    }

    [containerView addSubview:toView];

    CollectionViewCell *selectedCell = self.firstViewController.selectedCell;
    UIWindow *window = self.firstViewController.view.window ?: self.secondViewController.view.window;

    UIView *cellImageSnapshot = [selectedCell.locationImageView snapshotViewAfterScreenUpdates:YES];
    UIView *controllerImageSnapshot = [self.secondViewController.locationImageView snapshotViewAfterScreenUpdates:YES];
    UIView *cellLabelSnapshot = [selectedCell.locationLabel snapshotViewAfterScreenUpdates:YES];
    UIView *closeButtonSnapshot = [self.secondViewController.closeButton snapshotViewAfterScreenUpdates:YES];

    if (!selectedCell || !window || !cellImageSnapshot || !controllerImageSnapshot || !cellLabelSnapshot || !closeButtonSnapshot) {
        [transitionContext completeTransition:YES];
        return;
    }

    BOOL isPresenting = self.type == PresentationTypePresent;

    UIView *backgroundView;
    UIView *fadeView = [[UIView alloc] initWithFrame:containerView.bounds];
    fadeView.backgroundColor = self.secondViewController.view.backgroundColor;

    if (isPresenting) {
        self.selectedCellImageViewSnapshot = cellImageSnapshot;
        backgroundView = [[UIView alloc] initWithFrame:containerView.bounds];
        [backgroundView addSubview:fadeView];
        fadeView.alpha = 0;
    } else {
        backgroundView = [self.firstViewController.view snapshotViewAfterScreenUpdates:YES] ?: fadeView;
        [backgroundView addSubview:fadeView];
    }

    toView.alpha = 0;

    [containerView addSubview:backgroundView];
    [containerView addSubview:self.selectedCellImageViewSnapshot];
    [containerView addSubview:controllerImageSnapshot];
    [containerView addSubview:cellLabelSnapshot];
    [containerView addSubview:closeButtonSnapshot];

    CGRect controllerImageViewRect = [self.secondViewController.locationImageView convertRect:self.secondViewController.locationImageView.bounds toView:window];
    CGRect controllerLabelRect = [self.secondViewController.locationLabel convertRect:self.secondViewController.locationLabel.bounds toView:window];
    CGRect closeButtonRect = [self.secondViewController.closeButton convertRect:self.secondViewController.closeButton.bounds toView:window];

    self.selectedCellImageViewSnapshot.frame = isPresenting ? self.cellImageViewRect : controllerImageViewRect;
    controllerImageSnapshot.frame = isPresenting ? self.cellImageViewRect : controllerImageViewRect;
    
    self.selectedCellImageViewSnapshot.layer.cornerRadius = isPresenting ? 12 : 0;
    controllerImageSnapshot.layer.cornerRadius = isPresenting ? 12 : 0;
    self.selectedCellImageViewSnapshot.layer.masksToBounds = YES;
    controllerImageSnapshot.layer.masksToBounds = YES;

    controllerImageSnapshot.alpha = isPresenting ? 0 : 1;
    self.selectedCellImageViewSnapshot.alpha = isPresenting ? 1 : 0;

    cellLabelSnapshot.frame = isPresenting ? self.cellLabelRect : controllerLabelRect;

    closeButtonSnapshot.frame = closeButtonRect;
    closeButtonSnapshot.alpha = isPresenting ? 0 : 1;

    [UIView animateKeyframesWithDuration:duration delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 animations:^{
            self.selectedCellImageViewSnapshot.frame = isPresenting ? controllerImageViewRect : self.cellImageViewRect;
            controllerImageSnapshot.frame = isPresenting ? controllerImageViewRect : self.cellImageViewRect;
            fadeView.alpha = isPresenting ? 1 : 0;
            cellLabelSnapshot.frame = isPresenting ? controllerLabelRect : self.cellLabelRect;
            
            self.selectedCellImageViewSnapshot.layer.cornerRadius = isPresenting ? 0 : 12;
            controllerImageSnapshot.layer.cornerRadius = isPresenting ? 0 : 12;
        }];

        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.6 animations:^{
            self.selectedCellImageViewSnapshot.alpha = isPresenting ? 0 : 1;
            controllerImageSnapshot.alpha = isPresenting ? 1 : 0;
        }];

        [UIView addKeyframeWithRelativeStartTime:isPresenting ? 0.7 : 0 relativeDuration:0.3 animations:^{
            closeButtonSnapshot.alpha = isPresenting ? 1 : 0;
        }];
    } completion:^(BOOL finished) {
        [self.selectedCellImageViewSnapshot removeFromSuperview];
        [controllerImageSnapshot removeFromSuperview];
        [backgroundView removeFromSuperview];
        [cellLabelSnapshot removeFromSuperview];
        [closeButtonSnapshot removeFromSuperview];
        toView.alpha = 1;
        [transitionContext completeTransition:YES];
    }];
}

@end
