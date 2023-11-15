import { registerPlugin } from '@capacitor/core';

import type { Auth0Plugin } from './definitions';

const Auth0 = registerPlugin<Auth0Plugin>('Auth0', {
  web: () => import('./web').then(m => new m.Auth0Web()),
});

export * from './definitions';
export { Auth0 };
