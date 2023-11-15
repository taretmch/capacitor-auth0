import { WebPlugin } from '@capacitor/core';

import type { CapacitorAuth0Plugin, Auth0User } from './definitions';

export class CapacitorAuth0Web
  extends WebPlugin
  implements CapacitorAuth0Plugin
{

  load(): Promise<Auth0User> {
    return Promise.reject('Not implemented on web.');
  }

  login(): Promise<Auth0User> {
    return Promise.reject('Not implemented on web.');
  }

  logout(): Promise<void> {
    return Promise.reject('Not implemented on web.');
  }

  isAuthenticated(): Promise<{ result: boolean }> {
    return Promise.reject('Not implemented on web.');
  }

  getUserInfo(): Promise<Auth0User> {
    return Promise.reject('Not implemented on web.');
  }

}
