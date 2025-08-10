#import <UIKit/UIKit.h>

@class CollectionViewCell;
@class Animator;

NS_ASSUME_NONNULL_BEGIN

@interface FirstViewController : UIViewController

@property (nonatomic, strong, nullable) CollectionViewCell *selectedCell;
@property (nonatomic, strong, nullable) UIView *selectedCellImageViewSnapshot;
@property (nonatomic, strong, nullable) Animator *animator;

@end

NS_ASSUME_NONNULL_END
