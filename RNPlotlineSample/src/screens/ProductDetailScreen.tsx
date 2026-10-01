import React from 'react';
import {View, Text, StyleSheet, TouchableOpacity} from 'react-native';
import {SafeAreaView} from 'react-native-safe-area-context';
import type {NativeStackScreenProps} from '@react-navigation/native-stack';
import type {RootStackParamList} from '../../App';
import {PRODUCTS} from '../data/products';
import Plotline from 'plotline-engage';

type Props = NativeStackScreenProps<RootStackParamList, 'ProductDetail'>;

export default function ProductDetailScreen({route}: Props) {
  const product = PRODUCTS.find(p => p.id === route.params.id);
  if (!product) {
    return (
      <SafeAreaView style={styles.container}>
        <Text style={styles.name}>Product not found</Text>
      </SafeAreaView>
    );
  }
  return (
    <SafeAreaView style={styles.container} edges={['bottom']}>
      <View testID = "product_detail" style={styles.hero}>
        <Text style={styles.emoji}>{product.emoji}</Text>
      </View>
      <View style={styles.body}>
        <Text style={styles.name}>{product.name}</Text>
        <Text style={styles.price}>${product.price}</Text>
        <Text style={styles.desc}>{product.description}</Text>
        <TouchableOpacity style={styles.btn}
          onPress={() => Plotline.track('add_to_cart', {productId: product.id, price: product.price})}>
          <Text style={styles.btnText}>Add to cart</Text>
        </TouchableOpacity>
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {flex: 1, backgroundColor: '#0f1115'},
  hero: {height: 240, backgroundColor: '#1a1d24', alignItems: 'center', justifyContent: 'center'},
  emoji: {fontSize: 96},
  body: {padding: 20},
  name: {color: '#fff', fontSize: 24, fontWeight: '700'},
  price: {color: '#5b6cff', fontSize: 20, marginTop: 6},
  desc: {color: '#9aa0aa', fontSize: 15, lineHeight: 22, marginTop: 14},
  btn: {backgroundColor: '#5b6cff', paddingVertical: 14, borderRadius: 12, alignItems: 'center', marginTop: 28},
  btnText: {color: '#fff', fontWeight: '600', fontSize: 16},
});
