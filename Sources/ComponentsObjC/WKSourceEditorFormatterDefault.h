//
//  WKSourceEditorFormatterCommon.h
//  
//
//  Created by Toni Sevener on 5/1/23.
//

#import "WKSourceEditorFormatter.h"

@class WKSourceEditorTextStorageColors;
@class WKSourceEditorTextStorageFonts;

NS_ASSUME_NONNULL_BEGIN

@interface WKSourceEditorFormatterDefault : WKSourceEditorFormatter
- (instancetype)initWithColors:(nonnull WKSourceEditorTextStorageColors *)colors fonts:(nonnull WKSourceEditorTextStorageFonts *)fonts;
- (void)applySyntaxHighlightingInString:(NSMutableAttributedString *)string toRange:(NSRange)range;
@end

NS_ASSUME_NONNULL_END
