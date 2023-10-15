export interface CapacitorAuth0Plugin {
  login(): Promise<LoginResult>;
  logout(): Promise<void>;
}

export interface LoginResult {
  user: Auth0User;
}

export interface Auth0User {
  id: string;
  name: string;
  email: string;
}
