import { WebPlugin } from '@capacitor/core';

import type { CapacitorAuth0Plugin, LoginResult } from './definitions';

export class CapacitorAuth0Web
  extends WebPlugin
  implements CapacitorAuth0Plugin
{

  login(): Promise<LoginResult> {
    return Promise.reject('Not implemented on web.');
  }

  logout(): Promise<void> {
    return Promise.reject('Not implemented on web.');
  }

}
