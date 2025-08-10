#import "CellData.h"

@implementation CellData

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title {
    self = [super init];
    if (self) {
        _image = image;
        _title = [title copy];
    }
    return self;
}

@end
