/**
 * Capacitor Auth0 Plugin
 */
export interface CapacitorAuth0Plugin {

  /**
   * Configure the plugin with your Auth0 credentials.
   * @param options  CapacitorAuth0Conf
   * @returns Promise<void>
   */
  configure(options: CapacitorAuth0Conf): Promise<void>;

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
 * Configuration options for the plugin.
 */
export interface CapacitorAuth0Conf {

  /**
   * Your Auth0 domain.
   */
  domain: string;

  /**
   * Your Auth0 client ID.
   */
  clientId: string;
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
