#import <UIKit/UIKit.h>

@class FirstViewController;
@class SecondViewController;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PresentationType) {
    PresentationTypePresent,
    PresentationTypeDismiss
};

@interface Animator : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithType:(PresentationType)type
         firstViewController:(FirstViewController *)firstViewController
        secondViewController:(SecondViewController *)secondViewController
 selectedCellImageViewSnapshot:(UIView *)selectedCellImageViewSnapshot;

@end

NS_ASSUME_NONNULL_END
