//
//  pcHeader.h
//  Ezloo
//
//  Created by 杨卓树 on 8/15/17.
//  Copyright © 2017 zhuoshu. All rights reserved.
//

#ifndef pcHeader_h
#define pcHeader_h

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

#define BASESCREENHEIGHT 480.0f    //以ipadAir2屏size做为基准
#define BASESCREENWIDTH  320.0f

// 屏幕宽高适配比例
#define AutoSizeScaleX ScreenW/BASESCREENWIDTH
#define AutoSizeScaleY ScreenH/BASESCREENHEIGHT

#define getAutoSizeX(A) (AutoSizeScaleX * A)
#define getAutoSizeY(A) (AutoSizeScaleY * A)

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
//设置透明色
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//主题颜色
#define Skin_MainColor          RGB(37, 47, 67)
#define TitleColor              RGB(8, 52, 100)
#define Com_WhiteColor          [UIColor whiteColor]
#define Com_BlackColor          [UIColor blackColor]
#define Com_LineColor           RGB(239, 239, 239)    //线灰色
#define Com_lightGrayColor      [UIColor lightGrayColor ]


#endif /* pcHeader_h */
