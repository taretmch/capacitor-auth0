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
        padding: env(safe-area-inset-top, 15px) 15px env(safe-area-inset-bottom, 15px);
      }
      main p {
        color: #333;
      }
      #userInfo {
        display: none;
        text-align: center;
        margin-top: 20px;
        padding: 20px;
        background-color: #f5f5f5;
        border-radius: 5px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
      }

      #userInfo h2 {
        font-size: 1.2em;
        margin-bottom: 20px;
        color: #333;
      }
      
      #userInfo p {
        padding: 10px 0;
        border-bottom: 1px solid #ccc;
      }

      #userInfo p:last-child {
        border-bottom: none;
      }

      #login, #logout {
        display: block;
        width: 100%;
        margin-top: 20px;
        padding: 15px 0;
        font-size: 1em;
        background-color: #73B5F6;
        border: none;
        border-radius: 5px;
        color: #fff;
        cursor: pointer;
        text-align: center;
        transition: background-color 0.2s ease;
      }

      #login:hover, #logout:hover {
        background-color: #558cc4;
      }
    </style>
    <div>
      <main>
        <div id="userInfo">
          <h2>User Information</h2>
          <p>ID: <span id="userId"></span></p>
          <p>Name: <span id="userName"></span></p>
          <p>Email: <span id="userEmail"></span></p>
        </div>
        <p>
          <button class="button" id="login">Login</button>
          <button class="button" id="logout" style="display: none;">Logout</button>
        </p>
      </main>
    </div>
    `;
    }

    connectedCallback() {
      const self = this;

      function updateUI(user) {
        if (user) {
          self.shadowRoot.querySelector('#login').style.display = 'none';
          self.shadowRoot.querySelector('#logout').style.display = 'block';
          self.shadowRoot.querySelector('#userInfo').style.display = 'block';
          self.shadowRoot.querySelector('#userId').textContent = user.id;
          self.shadowRoot.querySelector('#userName').textContent = user.name;
          self.shadowRoot.querySelector('#userEmail').textContent = user.email;
        } else {
          self.shadowRoot.querySelector('#login').style.display = 'block';
          self.shadowRoot.querySelector('#logout').style.display = 'none';
          self.shadowRoot.querySelector('#userInfo').style.display = 'none';
        }
      }

      self.shadowRoot.querySelector('#login').addEventListener('click', async function (e) {
        try {
          const user = await CapacitorAuth0.login()
          console.log('login', user);
          updateUI(user);
        } catch (e) {
          console.error(e);
        }
      });

      self.shadowRoot.querySelector('#logout').addEventListener('click', async function (e) {
        try {
          const res = await CapacitorAuth0.logout()
          console.log('logout', res);
          updateUI(null);
        } catch (e) {
          console.error(e);
        }
      });

      updateUI(null); // 初期表示設定
    }
  }
);
