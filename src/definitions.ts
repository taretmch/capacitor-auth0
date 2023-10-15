export interface CapacitorAuth0Plugin {
  configure(options: CapacitorAuth0Conf): Promise<void>;
  login(): Promise<Auth0User>;
  logout(): Promise<void>;
}

export interface CapacitorAuth0Conf {
  domain: string;
  clientId: string;
}

export interface Auth0User {
  id: string;
  name: string;
  email: string;
}
