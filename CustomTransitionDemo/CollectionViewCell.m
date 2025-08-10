#import "CollectionViewCell.h"

@interface CollectionViewCell ()
@property (nonatomic, weak) IBOutlet UIImageView *locationImageView;
@property (nonatomic, weak) IBOutlet UILabel *locationLabel;
@end

@implementation CollectionViewCell {
    BOOL _didSetup;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if (!_didSetup) {
        self.contentView.layer.cornerRadius = 12.0;
        self.contentView.layer.masksToBounds = YES;

        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 1.0);
        self.layer.shadowRadius = 1.0;
        self.layer.shadowOpacity = 0.2;
        self.layer.masksToBounds = NO;
        self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.contentView.layer.cornerRadius].CGPath;
        _didSetup = YES;
    }
}

- (void)configureWithCellData:(CellData *)cellData {
    self.locationImageView.image = cellData.image;
    self.locationLabel.text = cellData.title;
}

@end
