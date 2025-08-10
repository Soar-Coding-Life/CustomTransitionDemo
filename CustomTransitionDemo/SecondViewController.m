#import "SecondViewController.h"

@interface SecondViewController ()
@property (nonatomic, weak) IBOutlet UIImageView *locationImageView;
@property (nonatomic, weak) IBOutlet UILabel *locationLabel;
@property (nonatomic, weak) IBOutlet UIButton *closeButton;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImage *cross = [[UIImage imageNamed:@"cross"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.closeButton setImage:cross forState:UIControlStateNormal];
    self.closeButton.tintColor = [UIColor whiteColor];

    self.locationImageView.image = self.data.image;
    self.locationLabel.text = self.data.title;
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
