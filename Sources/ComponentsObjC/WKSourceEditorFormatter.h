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
- (void)applySyntaxHighlightingInString:(NSMutableAttributedString *)string toRange:(NSRange)range;
@end

NS_ASSUME_NONNULL_END
