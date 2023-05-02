//
//  WKSourceEditorFormatterCommon.m
//  
//
//  Created by Toni Sevener on 5/1/23.
//

#import "WKSourceEditorFormatterDefault.h"
#import "WKSourceEditorTextStorageColors.h"
#import "WKSourceEditorTextStorageFonts.h"

@interface WKSourceEditorFormatterDefault ()

@property (strong, nonatomic) NSDictionary *defaultAttributes;

@end

@implementation WKSourceEditorFormatterDefault

- (instancetype)initWithColors:(nonnull WKSourceEditorTextStorageColors *)colors fonts:(nonnull WKSourceEditorTextStorageFonts *)fonts {
    self = [super init];
    if (self) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5];
        [paragraphStyle setLineHeightMultiple:1.1];

        _defaultAttributes = @{
            NSFontAttributeName: fonts.defaultFont,
            NSParagraphStyleAttributeName: paragraphStyle,
            NSForegroundColorAttributeName: colors.defaultForegroundColor
        };
    }
    return self;
}

- (void)applySyntaxHighlightingInString:(NSMutableAttributedString *)string toRange:(NSRange)range {
    [string addAttributes:self.defaultAttributes range:range];
}

@end
