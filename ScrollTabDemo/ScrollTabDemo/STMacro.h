//
//  STMacro.h
//  ScrollTabDemo
//
//  Created by Jasonzb on 16/3/23.
//  Copyright © 2016年 vx173. All rights reserved.
//

#ifndef STMacro_h
#define STMacro_h

#define SCREEN_WIDTH        [[UIScreen mainScreen] bounds].size.width
#define RGBA(R, G, B, A)    [UIColor colorWithRed:(R)/255.f green:(G)/255.f blue:(B)/255.f alpha:(A)]
#define FONT_COLOR          RGBA(230,153,153,1)
#define WS(weakSelf)        __weak __typeof(&*self)weakSelf = self;

#endif /* STMacro_h */
