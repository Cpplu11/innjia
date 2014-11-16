//
//  INNJPoint.h
//  innjiaios
//
//  Created by wl on 14-11-15.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "BMKCircle.h"
#import "BMKCircleView.h"
#import "BMKAnnotationView.h"
#import "BMKPointAnnotation.h"
#define REUSEID @"Point"

@interface INNJPoint :BMKPointAnnotation
@property (nonatomic,assign) NSInteger tag;
@property (nonatomic,assign) NSString *key;
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;
@end

@interface INNJPointView : BMKAnnotationView
@property (nonatomic,strong) UILabel *label;
-(id) initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier;
@end
