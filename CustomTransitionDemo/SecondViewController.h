#import <UIKit/UIKit.h>
#import "CellData.h"

NS_ASSUME_NONNULL_BEGIN

@interface SecondViewController : UIViewController

@property (nonatomic, strong) CellData *data;
@property (nonatomic, weak, readonly) IBOutlet UIImageView *locationImageView;
@property (nonatomic, weak, readonly) IBOutlet UILabel *locationLabel;
@property (nonatomic, weak, readonly) IBOutlet UIButton *closeButton;

@end

NS_ASSUME_NONNULL_END
