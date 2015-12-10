//
//  HWStatusPhotosView.m
//  微博项目
//
//  Created by Youngfev on 15/12/10.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWStatusPhotosView.h"
#import "HWPhoto.h"
#import "UIImageView+WebCache.h"

#define HWStatusPhotoWH 70
#define HWStatusPhotoMargin 10
#define HWStatusPhotoMaxCol(count) ((count==4)?2:3)

@implementation HWStatusPhotosView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor brownColor];
    }
    return self;
}

-(void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    NSInteger photosCount = photos.count;
    
    while (self.subviews.count < photosCount) {
        UIImageView *photoView = [[UIImageView alloc] init];
        [self addSubview:photoView];
    }
    
    for (NSInteger i = 0; i < self.subviews.count; i ++) {
        UIImageView *photoView = self.subviews[i];
        
        if (i < photosCount) {
            photoView.hidden = NO;
            
            HWPhoto *photo = photos[i];
            
            [photoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        }else{
            photoView.hidden = YES;
        }
    }
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger photosCount = self.photos.count;
    for (NSInteger i = 0; i < photosCount; i ++) {
        UIImageView *photoView = self.subviews[i];
        
        NSInteger col = i % 3;
        NSInteger row = i / 3;
        photoView.x = col * (HWStatusPhotoWH + HWStatusPhotoMargin);
        photoView.y = row * (HWStatusPhotoWH + HWStatusPhotoMargin);
        photoView.width = HWStatusPhotoWH;
        photoView.height = HWStatusPhotoWH;
    }

}

+ (CGSize)photosSizeWithCount:(NSInteger)count
{
    // 最大列数（一行最多有多少列）
    int maxCols = 3;
    
    NSInteger cols = (count >= maxCols)? maxCols : count;
    CGFloat photosW = cols * HWStatusPhotoWH + (cols - 1) * HWStatusPhotoMargin;
    
    // 行数
    NSInteger rows = (count + maxCols - 1) / maxCols;
    CGFloat photosH = rows * HWStatusPhotoWH + (rows - 1) * HWStatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}
@end
