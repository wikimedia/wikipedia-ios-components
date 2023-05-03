//
//  WKSourceEditorFormatter.h
//  
//
//  Created by Toni Sevener on 5/1/23.
//

#import <Foundation/Foundation.h>
@class WKSourceEditorTextStorageColors, WKSourceEditorTextStorageFonts;

NS_ASSUME_NONNULL_BEGIN

@interface WKSourceEditorFormatter : NSObject
- (instancetype)initWithColors:(nonnull WKSourceEditorTextStorageColors *)colors fonts:(nonnull WKSourceEditorTextStorageFonts *)fonts;
- (void)applySyntaxHighlightRegexInAttributedString:(NSMutableAttributedString *)attributedString toRange:(NSRange)range;
- (void)updateColors:(WKSourceEditorTextStorageColors *)colors inAttributedString:(NSMutableAttributedString *)attributedString inRange:(NSRange)range;
- (void)updateFonts:(WKSourceEditorTextStorageFonts *)fonts inAttributedString:(NSMutableAttributedString *)attributedString inRange:(NSRange)range;
@end

NS_ASSUME_NONNULL_END
