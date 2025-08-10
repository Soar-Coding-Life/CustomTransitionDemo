#import <UIKit/UIKit.h>
#import "CellData.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewCell : UICollectionViewCell

@property (nonatomic, weak, readonly) IBOutlet UIImageView *locationImageView;
@property (nonatomic, weak, readonly) IBOutlet UILabel *locationLabel;

- (void)configureWithCellData:(CellData *)cellData;

@end

NS_ASSUME_NONNULL_END
