import { WebPlugin } from '@capacitor/core';

import type { CapacitorAuth0Plugin, Auth0User } from './definitions';

export class CapacitorAuth0Web
  extends WebPlugin
  implements CapacitorAuth0Plugin
{

  login(): Promise<Auth0User> {
    return Promise.reject('Not implemented on web.');
  }

  logout(): Promise<void> {
    return Promise.reject('Not implemented on web.');
  }

}
