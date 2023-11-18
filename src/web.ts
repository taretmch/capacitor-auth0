import { WebPlugin } from '@capacitor/core';

import type { Auth0Plugin, User, Credentials } from './definitions';

export class Auth0Web
  extends WebPlugin
  implements Auth0Plugin
{

  load(): Promise<User> {
    return Promise.reject('Not implemented on web.');
  }

  login(): Promise<User> {
    return Promise.reject('Not implemented on web.');
  }

  logout(): Promise<void> {
    return Promise.reject('Not implemented on web.');
  }

  isAuthenticated(): Promise<{ result: boolean }> {
    return Promise.reject('Not implemented on web.');
  }

  getUserInfo(): Promise<User> {
    return Promise.reject('Not implemented on web.');
  }

  getCredentials(): Promise<Credentials> {
    return Promise.reject('Not implemented on web.');
  }

}
