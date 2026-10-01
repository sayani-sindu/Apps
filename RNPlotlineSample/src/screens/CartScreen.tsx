import React from 'react';
import {View, Text, StyleSheet, FlatList} from 'react-native';
import {SafeAreaView} from 'react-native-safe-area-context';
import {PRODUCTS} from '../data/products';
import { PlotlineWidget } from 'plotline-engage';

const CART = PRODUCTS.slice(0, 2);

export default function CartScreen() {
  const total = CART.reduce((s, p) => s + p.price, 0);
  return (
    <SafeAreaView style={styles.container} edges={['top']}>
      <PlotlineWidget testID="native3" />
      <Text testID = "cart" style={styles.title}>Cart</Text>
      <FlatList
        data={CART}
        keyExtractor={i => i.id}
        contentContainerStyle={{padding: 16}}
        renderItem={({item}) => (
          <View testID = "itens" style={styles.row}>
            <Text testID = "item_1" style={styles.emoji}>{item.emoji}</Text>
            <Text style={styles.name}>{item.name}</Text>
            <Text style={styles.price}>${item.price}</Text>
          </View>
        )}
        ListFooterComponent={
          
          <View testID = "footer" style={styles.totalRow}>
            <PlotlineWidget testID="native4" />
            <Text style={styles.totalLabel}>Total</Text>
            <Text style={styles.totalValue}>${total}</Text>
          </View>
        }
      />
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {flex: 1, backgroundColor: '#0f1115'},
  title: {color: '#fff', fontSize: 24, fontWeight: '700', padding: 16},
  row: {flexDirection: 'row', alignItems: 'center', backgroundColor: '#1a1d24', borderRadius: 12, padding: 14, marginBottom: 12},
  emoji: {fontSize: 28, marginRight: 14},
  name: {color: '#fff', fontSize: 16, flex: 1},
  price: {color: '#5b6cff', fontSize: 16, fontWeight: '600'},
  totalRow: {flexDirection: 'row', justifyContent: 'space-between', paddingVertical: 18, borderTopWidth: 1, borderTopColor: '#22262f', marginTop: 8},
  totalLabel: {color: '#9aa0aa', fontSize: 18},
  totalValue: {color: '#fff', fontSize: 20, fontWeight: '700'},
});
