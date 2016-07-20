//
//  Definition.h
//  1516网络-蔡耿鸿
//
//  Created by Hello Cai on 16/3/25.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#ifndef Definition_h
#define Definition_h

// 屏幕宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

//屏幕高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height


#define Notification_LxTopView_BtnClick @"Notification_LxTaBarView_BtnClick"

//不同设备的屏幕比例(当然倍数可以自己控制)
#define SizeScale_H ((ScreenHeight > 568) ? ScreenHeight/568 : 1)
#endif /* Definition_h */
