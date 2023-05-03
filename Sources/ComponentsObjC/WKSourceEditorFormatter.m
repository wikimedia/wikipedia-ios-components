//
//  WKSourceEditorFormatter.m
//  
//
//  Created by Toni Sevener on 5/1/23.
//

#import "WKSourceEditorFormatter.h"
#import "WKSourceEditorTextStorageColors.h"
#import "WKSourceEditorTextStorageFonts.h"

@implementation WKSourceEditorFormatter
- (nonnull instancetype)initWithColors:(nonnull WKSourceEditorTextStorageColors *)colors fonts:(nonnull WKSourceEditorTextStorageFonts *)fonts {
    self = [super init];
    return self;
}
-(void)applySyntaxHighlightRegexInAttributedString:(NSMutableAttributedString *)attributedString toRange:(NSRange)range {
    // must override
}

- (void)updateColors:(WKSourceEditorTextStorageColors *)colors inAttributedString:(NSMutableAttributedString *)attributedString inRange:(NSRange)range {
    // must override
}

- (void)updateFonts:(WKSourceEditorTextStorageFonts *)fonts inAttributedString:(NSMutableAttributedString *)attributedString inRange:(NSRange)range {
    // must override
}
@end
