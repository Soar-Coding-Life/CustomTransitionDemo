#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CellData : NSObject

@property (nonatomic, strong, readonly) UIImage *image;
@property (nonatomic, copy, readonly) NSString *title;

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
