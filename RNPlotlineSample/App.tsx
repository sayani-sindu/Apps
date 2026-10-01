import React from 'react';
import Plotline, {NavigationContainer} from 'plotline-engage';
import {useEffect} from 'react';
import {createNativeStackNavigator} from '@react-navigation/native-stack';
import {createBottomTabNavigator} from '@react-navigation/bottom-tabs';
import {Text} from 'react-native';
import {SafeAreaProvider} from 'react-native-safe-area-context';
import {Platform, PermissionsAndroid, NativeModules} from 'react-native';
import {PLOTLINE_API_KEY} from '@env';

import HomeScreen from './src/screens/HomeScreen';
import ProductsScreen from './src/screens/ProductsScreen';
import ProductDetailScreen from './src/screens/ProductDetailScreen';
import CartScreen from './src/screens/CartScreen';
import ProfileScreen from './src/screens/ProfileScreen';
import WebViewScreen from './src/screens/WebViewScreen';
import BridgeWebViewScreen from './src/screens/BridgeWebViewScreen';

export type RootStackParamList = {
  Tabs: undefined;
  ProductDetail: {id: string; name: string};
};

export type TabParamList = {
  Home: undefined;
  Products: undefined;
  Cart: undefined;
  Profile: undefined;
  Web: undefined;
  Bridge: undefined;
};

const Stack = createNativeStackNavigator<RootStackParamList>();
const Tab = createBottomTabNavigator<TabParamList>();

const tabIcon =
  (label: string) =>
  ({color}: {color: string}) =>
    <Text style={{color, fontSize: 18}}>{label}</Text>;

function Tabs() {
  return (
    <Tab.Navigator
      screenOptions={({route}) => ({
        headerTitleAlign: 'center',
        tabBarTestID: `PL_tab_$tab_${route.name.toLowerCase()}`, // tab_home, tab_products, etc.
      })}>
      <Tab.Screen
        name="Home"
        component={HomeScreen}
        options={{tabBarIcon: tabIcon('🏠')}}
      />
      <Tab.Screen
        name="Products"
        component={ProductsScreen}
        options={{tabBarIcon: tabIcon('🛍️')}}
      />
      <Tab.Screen
        name="Cart"
        component={CartScreen}
        options={{tabBarIcon: tabIcon('🛒')}}
      />
      <Tab.Screen
        name="Profile"
        component={ProfileScreen}
        options={{tabBarIcon: tabIcon('👤')}}
      />
      <Tab.Screen 
        name="Web" 
        component={WebViewScreen}
        options={{ tabBarIcon: tabIcon('🌐') }} 
      />
        <Tab.Screen 
          name="Bridge" 
          component={BridgeWebViewScreen}
          options={{tabBarIcon: tabIcon('🔗') }} 
        />
    </Tab.Navigator>
  );
}

export default function App() {
  useEffect(() => {
    console.log('FABRIC ON?', (global as any).nativeFabricUIManager != null);

    Plotline.init(PLOTLINE_API_KEY, 'sindu_test1');
    Plotline.debug();

    (async () => {
  if (Platform.OS === 'android' && Platform.Version >= 33) {
    const result = await PermissionsAndroid.request(
      PermissionsAndroid.PERMISSIONS.POST_NOTIFICATIONS,
    );
    console.log('POST_NOTIFICATIONS:', result); // 'granted' | 'denied' | 'never_ask_again'
  } else if (Platform.OS === 'ios') {
    // Explicit iOS push permission request (native PlotlinePushBridge)
    NativeModules.PlotlinePushBridge?.requestPermission();
  }
})();
    
    Plotline.setPlotlineRedirectListener((keyValuePairs) => {
      console.log('Plotline redirect:', keyValuePairs);
      
    });

    Plotline.setPlotlineEventsListener((eventName, properties) => {
      console.log('Plotline event:', eventName, properties);
    });
  }, []);
  return (
    <SafeAreaProvider>
      <NavigationContainer>
        <Stack.Navigator>
          <Stack.Screen
            name="Tabs"
            component={Tabs}
            options={{headerShown: false}}
          />
          <Stack.Screen
            name="ProductDetail"
            component={ProductDetailScreen}
            options={({route}) => ({title: route.params.name})}
          />
        </Stack.Navigator>
      </NavigationContainer>
    </SafeAreaProvider>
  );
}
