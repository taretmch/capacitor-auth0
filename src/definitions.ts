export interface CapacitorAuth0Plugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
