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
   * @returns Promise<User>  Current authenticated user or undefined.
   */
  load(): Promise<User>;

  /**
   * Web Auth: Login with Auth0.
   * @returns Promise<User>
   */
  login(): Promise<User>;

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
   * @returns Promise<User>
   */
  getUserInfo(): Promise<User>;

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
export interface User {

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
   * Once expired, the access token can no longer be used to access an API and
   * a new access token needs to be obtained.
   */
  expiresAt: string;

  /**
   * Granted scopes for the access token.
   * Undefined if no scope is granted.
   */
  scope: string;

  /**
   * Refresh token that can be used to request a new access token without signin again.
   * Undefined if no refresh token is granted.
   */
  refreshToken: string;

  /**
   * Type of received token.
   */
  tokenType: string;
}
