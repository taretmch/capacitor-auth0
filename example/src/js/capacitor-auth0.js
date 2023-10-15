import { SplashScreen } from '@capacitor/splash-screen';
import { CapacitorAuth0 } from '@taretmch/capacitor-auth0';

window.customElements.define(
  'capacitor-auth0',
  class extends HTMLElement {
    constructor() {
      super();

      SplashScreen.hide();

      const root = this.attachShadow({ mode: 'open' });

      root.innerHTML = `
    <style>
      :host {
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol";
        display: block;
        width: 100%;
        height: 100%;
      }
      .button {
        display: inline-block;
        padding: 10px;
        background-color: #73B5F6;
        color: #fff;
        font-size: 0.9em;
        border: 0;
        border-radius: 3px;
        text-decoration: none;
        cursor: pointer;
      }
      main {
        padding: 15px;
      }
      main p {
        color: #333;
      }
    </style>
    <div>
      <main>
        <p>
          <button class="button" id="login">Login</button>
        </p>
        <p>
          <button class="button" id="logout">Logout</button>
        </p>
      </main>
    </div>
    `;
    }

    connectedCallback() {
      const self = this;

      self.shadowRoot.querySelector('#login').addEventListener('click', async function (e) {
        try {
          const res = await CapacitorAuth0.login()
          console.log('login', res);
        } catch (e) {
          console.error(e);
        }
      });

      self.shadowRoot.querySelector('#logout').addEventListener('click', async function (e) {
        try {
          const res = await CapacitorAuth0.logout()
          console.log('logout', res);
        } catch (e) {
          console.error(e);
        }
      });
    }
  }
);
