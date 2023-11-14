import { WebPlugin } from '@capacitor/core';

import type { CapacitorAuth0Plugin, Auth0User, CapacitorAuth0Conf } from './definitions';

export class CapacitorAuth0Web
  extends WebPlugin
  implements CapacitorAuth0Plugin
{

  configure(_options: CapacitorAuth0Conf): Promise<void> {
    return Promise.reject('Not implemented on web.');
  }

  login(): Promise<Auth0User> {
    return Promise.reject('Not implemented on web.');
  }

  logout(): Promise<void> {
    return Promise.reject('Not implemented on web.');
  }

  isAuthenticated(): Promise<boolean> {
    return Promise.reject('Not implemented on web.');
  }

  getUserInfo(): Promise<Auth0User> {
    return Promise.reject('Not implemented on web.');
  }

}
