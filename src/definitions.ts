export interface CapacitorAuth0Plugin {
  login(): Promise<Auth0User>;
  logout(): Promise<void>;
}

export interface Auth0User {
  id: string;
  name: string;
  email: string;
}
