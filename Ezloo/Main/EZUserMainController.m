//
//
//  EZUserMainController.h
//  Ezloo
//
//  Created by 杨卓树 on 8/14/17.
//  Copyright © 2017 zhuoshu. All rights reserved.

//

#import "EZUserMainController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>
#import <BaiduMapAPI_Search/BMKPoiSearchType.h>

//#define kBaiduMapMaxHeight 300
//#define kCurrentLocationBtnWH 50
//#define kPading 10

@interface EZUserMainController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,BMKPoiSearchDelegate>
{
    CLLocationCoordinate2D leftBottomPoint;
    CLLocationCoordinate2D rightBottomPoint;
    BMKPoiSearch* _poisearch;
}

@property(nonatomic,strong)BMKMapView* mapView;
@property(nonatomic,strong)BMKLocationService* locService;
@property(nonatomic,strong)BMKGeoCodeSearch* geocodesearch;

//@property(nonatomic,strong)UITableView *tableView;
//@property(nonatomic,strong)NSMutableArray *dataSource;

@property(nonatomic,assign)CLLocationCoordinate2D currentCoordinate;
//@property(nonatomic,assign)NSInteger currentSelectLocationIndex;
@property(nonatomic,strong)UIImageView *centerCallOutImageView;
@property(nonatomic,strong)UIButton *currentLocationBtn;

@end

@implementation EZUserMainController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.upSwipe.enabled = NO; //屏蔽右滑返回手势
    
    [self configUI];
    
    [self startLocation];
    
}

-(void)configUI
{
    //BMKMapView
    self.mapView.frame = self.view.frame;
    [self.view addSubview:self.mapView];
    
    //固定定位图标
    self.centerCallOutImageView.frame = CGRectMake(0, 0, 30, 30);
    self.centerCallOutImageView.center = self.mapView.center;
    [self.view addSubview:self.centerCallOutImageView];
    [self.view bringSubviewToFront:self.centerCallOutImageView];
    
    [self.mapView layoutIfNeeded];
    
//    //定位按钮
//    self.currentLocationBtn =[UIButton buttonWithType:UIButtonTypeCustom];
//    [self.currentLocationBtn setImage:[UIImage imageNamed:@"Location_black_icon"] forState:UIControlStateNormal];
//    [self.currentLocationBtn setImage:[UIImage imageNamed:@"Location_blue_icon"] forState:UIControlStateSelected];
//    [self.currentLocationBtn addTarget:self action:@selector(startLocation) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.currentLocationBtn];
//    [self.view bringSubviewToFront:self.currentLocationBtn];
//    self.currentLocationBtn.frame = CGRectMake(10, CGRectGetMaxY(self.mapView.frame)-kCurrentLocationBtnWH-10, kCurrentLocationBtnWH, kCurrentLocationBtnWH);
}

#pragma mark - methods

//开始定位
-(void)startLocation
{
//    self.currentSelectLocationIndex=0;
    self.currentLocationBtn.selected=YES;
    [self.locService startUserLocationService];
    self.mapView.showsUserLocation = NO;//先关闭显示的定位图层
    self.mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    self.mapView.showsUserLocation = YES;//显示定位图层
}

-(void)startGeocodesearchWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    //反地理编码
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = coordinate;
    [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
}

-(void)setCurrentCoordinate:(CLLocationCoordinate2D)currentCoordinate
{
    _currentCoordinate=currentCoordinate;
    [self startGeocodesearchWithCoordinate:currentCoordinate];
}

#pragma mark - BMKMapViewDelegate

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [self.mapView updateLocationData:userLocation];
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    self.currentLocationBtn.selected=NO;
    [self.mapView updateLocationData:userLocation];
    self.currentCoordinate=userLocation.location.coordinate;
    
    if (self.currentCoordinate.latitude!=0)
    {
        [self.locService stopUserLocationService];
    }
}

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    CLLocationCoordinate2D tt =[mapView convertPoint:self.centerCallOutImageView.center toCoordinateFromView:self.centerCallOutImageView];
    self.currentCoordinate=tt;
    
    leftBottomPoint = [_mapView convertPoint:CGPointMake(0,_mapView.frame.size.height) toCoordinateFromView:mapView];  // //西南角（左下角） 屏幕坐标转地理经纬度
    rightBottomPoint = [_mapView convertPoint:CGPointMake(_mapView.frame.size.width,0) toCoordinateFromView:mapView];  //东北角（右上角）同上
}

- (void)mapViewDidFinishLoading:(BMKMapView *)mapView
{
    leftBottomPoint = [_mapView convertPoint:CGPointMake(0,_mapView.frame.size.height) toCoordinateFromView:mapView];  // //西南角（左下角） 屏幕坐标转地理经纬度
    rightBottomPoint = [_mapView convertPoint:CGPointMake(_mapView.frame.size.width,0) toCoordinateFromView:mapView];  //东北角（右上角）同上
    [self initMapView];
    
}

- (void)initMapView{
    _poisearch = [[BMKPoiSearch alloc]init];
    _poisearch.delegate = self;
    
    BMKBoundSearchOption*boundSearchOption = [[BMKBoundSearchOption alloc]init];
    boundSearchOption.pageIndex = 0;
    boundSearchOption.pageCapacity = 20;
    boundSearchOption.keyword = @"洗手间";
    boundSearchOption.leftBottom =leftBottomPoint;
    boundSearchOption.rightTop =rightBottomPoint;
    
    BOOL flag = [_poisearch poiSearchInbounds:boundSearchOption];
    if(flag)
    {
        NSLog(@"范围内检索发送成功");
    }
    else
    {
        NSLog(@"范围内检索发送失败");
    }
}

- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
        [_mapView removeAnnotations:array];
        array = [NSArray arrayWithArray:_mapView.overlays];
        [_mapView removeOverlays:array];
        
        //在此处理正常结果
        for (int i = 0; i < result.poiInfoList.count; i++)
        {
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
            [self addAnimatedAnnotationWithName:poi.name withAddress:poi.pt];
            
            //逆地理编码
            BMKGeoCodeSearch *_geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
            _geoCodeSearch.delegate = self;
            //初始化逆地理编码类
            BMKReverseGeoCodeOption *reverseGeoCodeOption= [[BMKReverseGeoCodeOption alloc] init];
            //需要逆地理编码的坐标位置
            reverseGeoCodeOption.reverseGeoPoint = poi.pt;
            [_geoCodeSearch reverseGeoCode:reverseGeoCodeOption];
        }
        
    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
    }
}

// 添加动画Annotation
- (void)addAnimatedAnnotationWithName:(NSString *)name withAddress:(CLLocationCoordinate2D)coor {
    
    BMKPointAnnotation*animatedAnnotation = [[BMKPointAnnotation alloc]init];
    animatedAnnotation.coordinate = coor;
    animatedAnnotation.title = name;
    [_mapView addAnnotation:animatedAnnotation];
    
}

#pragma mark - BMKGeoCodeSearchDelegate

/**
 *返回反地理编码搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果
 *@param error 错误号，@see BMKSearchErrorCode
 */

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error==0) {
        
        //BMKReverseGeoCodeResult是编码的结果，包括地理位置，道路名称，uid，城市名等信息
        BMKAddressComponent *address = result.addressDetail;
        NSLog(@"详细地址：省份：%@，区县地址：%@，城市： %@，街道： %@，街道号码：%@",address.province,address.city,address.district,address.streetName,address.streetNumber);
        
    }
}

#pragma mark - Getters

-(BMKMapView*)mapView
{
    if (_mapView==nil)
    {
        _mapView =[BMKMapView new];
        _mapView.zoomEnabled=NO;
        _mapView.zoomEnabledWithTap=NO;
        _mapView.zoomLevel=17;
    }
    return _mapView;
}

-(BMKLocationService*)locService
{
    if (_locService==nil)
    {
        _locService = [[BMKLocationService alloc]init];
    }
    return _locService;
}

-(BMKGeoCodeSearch*)geocodesearch
{
    if (_geocodesearch==nil)
    {
        _geocodesearch=[[BMKGeoCodeSearch alloc]init];
    }
    return _geocodesearch;
}

-(UIImageView*)centerCallOutImageView
{
    if (_centerCallOutImageView==nil)
    {
        _centerCallOutImageView=[UIImageView new];
        [_centerCallOutImageView setImage:[UIImage imageNamed:@"Location_green_icon"]];
    }
    return _centerCallOutImageView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.mapView viewWillAppear];
    self.mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    self.locService.delegate = self;
    self.geocodesearch.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil; // 不用时，置nil
    self.locService.delegate = nil;
    self.geocodesearch.delegate = nil;
}


@end
