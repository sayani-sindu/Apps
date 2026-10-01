import React from 'react';
import {Text, StyleSheet, FlatList, TouchableOpacity, View} from 'react-native';
import {SafeAreaView} from 'react-native-safe-area-context';
import {useNavigation} from '@react-navigation/native';
import type {NativeStackNavigationProp} from '@react-navigation/native-stack';
import type {RootStackParamList} from '../../App';
import {PRODUCTS} from '../data/products';
import Plotline, { PlotlineWidget } from 'plotline-engage';

export default function ProductsScreen() {
  const navigation = useNavigation<NativeStackNavigationProp<RootStackParamList>>();
  return (
    <SafeAreaView style={styles.container} edges={['top']}>
      <PlotlineWidget testID="native6" />
      <PlotlineWidget testID="native7" />
      <Text style={styles.title}>Products</Text>
      <FlatList
        data={PRODUCTS}
        keyExtractor={i => i.id}
        contentContainerStyle={{padding: 16}}
        renderItem={({item}) => (
          <TouchableOpacity
            style={styles.row}
            onPress={() =>{
                Plotline.track('product_opened', {productId: item.id, name: item.name});

              navigation.navigate('ProductDetail', {id: item.id, name: item.name})
            }
            }>
            <Text style={styles.emoji}>{item.emoji}</Text>
            <View style={{flex: 1}}>
              <Text style={styles.name}>{item.name}</Text>
              <Text style={styles.price}>${item.price}</Text>
            </View>
            <Text style={styles.chev}>›</Text>
          </TouchableOpacity>
        )}
      />
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {flex: 1, backgroundColor: '#0f1115'},
  title: {color: '#fff', fontSize: 24, fontWeight: '700', padding: 16},
  row: {flexDirection: 'row', alignItems: 'center', backgroundColor: '#1a1d24', borderRadius: 12, padding: 14, marginBottom: 12},
  emoji: {fontSize: 32, marginRight: 14},
  name: {color: '#fff', fontSize: 16, fontWeight: '600'},
  price: {color: '#5b6cff', fontSize: 14, marginTop: 2},
  chev: {color: '#9aa0aa', fontSize: 28},
});
