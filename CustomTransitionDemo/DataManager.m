#import "DataManager.h"

@implementation DataManager

+ (NSArray<CellData *> *)data {
    static NSArray<CellData *> *data = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        data = @[
            [[CellData alloc] initWithImage:[UIImage imageNamed:@"images/1"] title:@"Seychelles"],
            [[CellData alloc] initWithImage:[UIImage imageNamed:@"images/2"] title:@"Königssee"],
            [[CellData alloc] initWithImage:[UIImage imageNamed:@"images/5"] title:@"Zanzibar"],
            [[CellData alloc] initWithImage:[UIImage imageNamed:@"images/6"] title:@"Serengeti"],
            [[CellData alloc] initWithImage:[UIImage imageNamed:@"images/3"] title:@"Castle"],
            [[CellData alloc] initWithImage:[UIImage imageNamed:@"images/4"] title:@"Kyiv"],
            [[CellData alloc] initWithImage:[UIImage imageNamed:@"images/7"] title:@"Munich"],
            [[CellData alloc] initWithImage:[UIImage imageNamed:@"images/8"] title:@"Lake"]
        ];
    });
    return data;
}

@end
