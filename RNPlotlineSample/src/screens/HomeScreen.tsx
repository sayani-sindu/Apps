import React, { useEffect } from 'react';
import {View, Text, StyleSheet, TouchableOpacity, ScrollView} from 'react-native';
import {SafeAreaView} from 'react-native-safe-area-context';
import {useNavigation} from '@react-navigation/native';
import type {BottomTabNavigationProp} from '@react-navigation/bottom-tabs';
import type {TabParamList} from '../../App';
import Plotline, { PlotlineWidget } from 'plotline-engage';

export default function HomeScreen() {
  const navigation = useNavigation<BottomTabNavigationProp<TabParamList>>();
  useEffect(() => {
        Plotline.identify({
          name: 'sindu',
          email: 'sindusayani@gmail.com',
          mobile: ' +91 9014985249',
        });

        // Set Locale
      Plotline.setLocale("hi");

      // Set light mode/dark mode
      Plotline.identify({"uiMode": "light"});
      }, [])
  return (
    <SafeAreaView style={styles.container} edges={['top']}>
      <ScrollView contentContainerStyle={styles.content}>
        <PlotlineWidget testID="native1" />
        <Text nativeID="PL_welcome_message" testID = "PL_welcome_message" style={styles.hello}>Welcome back 👋</Text>
        <Text  nativeID="PL_sample" testID = "PL_sample" style={styles.title}>RN Plotline Sample</Text>
        <View style={styles.card}>
          <Text testID = "PL_arrivals" style={styles.cardTitle}>New arrivals</Text>
          <Text  testID = "PL_car_body" style={styles.cardBody}>
            Explore the latest gear hand-picked for you.
          </Text>
          <PlotlineWidget testID="PL_native2" />
          <TouchableOpacity
            style={styles.btn}
            onPress={() => {
              Plotline.track('browse_products_clicked', {});
              navigation.navigate('Products')
            }}>
            <Text style={styles.btnText}>Browse products</Text>
          </TouchableOpacity>
        </View>
        <View testID = "PL_cart" style={styles.card}>
          <Text style={styles.cardTitle}>Your cart</Text>
          <Text style={styles.cardBody}>Pick up where you left off.</Text>
          <TouchableOpacity
            style={[styles.btn, styles.btnAlt]}
            onPress={() => navigation.navigate('Cart')}>
            <Text style={styles.btnText}>Go to cart</Text>
          </TouchableOpacity>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {flex: 1, backgroundColor: '#0f1115'},
  content: {padding: 20},
  hello: {color: '#9aa0aa', fontSize: 16},
  title: {color: '#fff', fontSize: 28, fontWeight: '700', marginBottom: 20},
  card: {backgroundColor: '#1a1d24', borderRadius: 16, padding: 18, marginBottom: 16},
  cardTitle: {color: '#fff', fontSize: 18, fontWeight: '600', marginBottom: 6},
  cardBody: {color: '#9aa0aa', fontSize: 14, marginBottom: 14},
  btn: {backgroundColor: '#5b6cff', paddingVertical: 12, borderRadius: 10, alignItems: 'center'},
  btnAlt: {backgroundColor: '#2b8a63'},
  btnText: {color: '#fff', fontWeight: '600'},
});
