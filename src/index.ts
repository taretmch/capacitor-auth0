import { registerPlugin } from '@capacitor/core';

import type { CapacitorAuth0Plugin } from './definitions';

const CapacitorAuth0 = registerPlugin<CapacitorAuth0Plugin>('CapacitorAuth0', {
  web: () => import('./web').then(m => new m.CapacitorAuth0Web()),
});

export * from './definitions';
export { CapacitorAuth0 };
