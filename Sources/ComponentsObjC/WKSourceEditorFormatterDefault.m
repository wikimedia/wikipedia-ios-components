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

@property (strong, nonatomic) NSDictionary *attributes;

@end

@implementation WKSourceEditorFormatterDefault

- (instancetype)initWithColors:(nonnull WKSourceEditorTextStorageColors *)colors fonts:(nonnull WKSourceEditorTextStorageFonts *)fonts {
    self = [super initWithColors:colors fonts:fonts];
    if (self) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5];
        [paragraphStyle setLineHeightMultiple:1.1];

        _attributes = @{
            NSFontAttributeName: fonts.defaultFont,
            NSParagraphStyleAttributeName: paragraphStyle,
            NSForegroundColorAttributeName: colors.defaultForegroundColor
        };
    }
    return self;
}

- (void)applySyntaxHighlightRegexInAttributedString:(NSMutableAttributedString *)attributedString toRange:(NSRange)range {
    [super applySyntaxHighlightRegexInAttributedString:attributedString toRange:range];
    [attributedString addAttributes:self.attributes range:range];
}

- (void)updateColors:(WKSourceEditorTextStorageColors *)colors inAttributedString:(NSMutableAttributedString *)attributedString inRange:(NSRange)range {
    [super updateColors:colors inAttributedString:attributedString inRange:range];
    NSMutableDictionary *mutAttributes = [[NSMutableDictionary alloc] initWithDictionary:self.attributes];
    [mutAttributes setObject:colors.defaultForegroundColor forKey:NSForegroundColorAttributeName];
    self.attributes = [[NSDictionary alloc] initWithDictionary:mutAttributes];

    [attributedString addAttributes:self.attributes range:range];
}

- (void)updateFonts:(WKSourceEditorTextStorageFonts *)fonts inAttributedString:(NSMutableAttributedString *)attributedString inRange:(NSRange)range {
    [super updateFonts:fonts inAttributedString:attributedString inRange:range];
    NSMutableDictionary *mutAttributes = [[NSMutableDictionary alloc] initWithDictionary:self.attributes];
    [mutAttributes setObject:fonts.defaultFont forKey:NSFontAttributeName];
    self.attributes = [[NSDictionary alloc] initWithDictionary:mutAttributes];

    [attributedString addAttributes:self.attributes range:range];
}

@end
