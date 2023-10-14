import { WebPlugin } from '@capacitor/core';

import type { CapacitorAuth0Plugin } from './definitions';

export class CapacitorAuth0Web
  extends WebPlugin
  implements CapacitorAuth0Plugin
{
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
