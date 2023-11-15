/**
 * Capacitor Auth0 Plugin
 */
export interface CapacitorAuth0Plugin {

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
