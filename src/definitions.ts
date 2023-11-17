/**
 * Capacitor Auth0 Plugin
 */
export interface Auth0Plugin {

  /**
   * Load auth0 plugin.
   * For android, initialize the plugin with your Auth0 configuration.
   * @returns Promise<Auth0User>  Current authenticated user or undefined.
   */
  load(): Promise<Auth0User>;

  /**
   * Web Auth: Login with Auth0.
   * @returns Promise<Auth0User>
   */
  login(): Promise<Auth0User>;

  /**
   * Web Auth: Logout from Auth0.
   * @returns Promise<void>
   */
  logout(): Promise<void>;

  /**
   * Check if a user is authenticated.
   * @returns Promise<{ result: boolean }>
   */
  isAuthenticated(): Promise<{ result: boolean }>;

  /**
   * Get a latest authenticated user profile.
   */
  getUserInfo(): Promise<Auth0User>;

  /**
   * Get credentials.
   * @returns Promise<Credentials>
   */
  getCredentials(): Promise<Credentials>;
}

/**
 * Auth0 user profile.
 */
export interface Auth0User {

  /**
   * User ID.
   */
  id: string;

  /**
   * User name.
   */
  name: string;

  /**
   * User email.
   */
  email: string;
}

/**
 * Auth0 credentials.
 */
export interface Credentials {

  /**
   * Identity token that contains user profile information.
   */
  idToken: string;

  /**
   * Access token for Auth0 API.
   */
  accessToken: string;

  /**
   * Access token expiration date.
   * Once expired, the Access Token can no longer be used to access an API and a new Access Token needs to be obtained.
   */
  expiresAt: string;

  /**
   * Granted scopes for the access token.
   */
  scope: string;

  /**
   * Refresh token that can be used to request a new access token without signin again.
   */
  refreshToken: string;

  /**
   * Type of received token.
   */
  tokenType: string;
}
