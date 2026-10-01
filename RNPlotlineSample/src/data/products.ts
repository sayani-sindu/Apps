export type Product = {
  id: string;
  name: string;
  price: number;
  description: string;
  emoji: string;
};

export const PRODUCTS: Product[] = [
  {id: '1', name: 'Aurora Headphones', price: 129, emoji: '🎧', description: 'Wireless over-ear headphones with active noise cancellation.'},
  {id: '2', name: 'Nimbus Smartwatch', price: 199, emoji: '⌚', description: 'Fitness tracking, notifications, and a 7-day battery.'},
  {id: '3', name: 'Pixel Camera', price: 349, emoji: '📷', description: 'Compact mirrorless camera with 4K video.'},
  {id: '4', name: 'Bolt Speaker', price: 79, emoji: '🔊', description: 'Portable Bluetooth speaker, waterproof.'},
  {id: '5', name: 'Glide Keyboard', price: 59, emoji: '⌨️', description: 'Mechanical keyboard with hot-swappable switches.'},
];
