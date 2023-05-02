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
- (void)applySyntaxHighlightRegexInString:(NSMutableAttributedString *)string toRange:(NSRange)range;
- (void)updateColors:(WKSourceEditorTextStorageColors *)colors inString:(NSMutableAttributedString *)string inRange:(NSRange)range;
- (void)updateFonts:(WKSourceEditorTextStorageFonts *)fonts inString:(NSMutableAttributedString *)string inRange:(NSRange)range;
@end

NS_ASSUME_NONNULL_END
