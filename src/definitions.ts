/**
 * Capacitor Auth0 Plugin
 */
export interface Auth0Plugin {

  /**
   * Load auth0 plugin.
   * Get the authenticated user profile and update the credentials
   * using the refresh token if the access token is expired.
   * For android, initialize the plugin with your Auth0 configuration.
   * Return undefined if the user is not authenticated.
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
   * Check if the user is authenticated.
   * @returns Promise<{ result: boolean }>
   */
  isAuthenticated(): Promise<{ result: boolean }>;

  /**
   * Get the authenticated user profile.
   * If the access token is expired, yield new credentials using the refresh token.
   * Throws an error if the user is not authenticated.
   * @returns Promise<Auth0User>
   */
  getUserInfo(): Promise<Auth0User>;

  /**
   * Get credentials and yield new credentials using the refresh token if the access token is expired.
   * Return undefined if the user is not authenticated.
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
