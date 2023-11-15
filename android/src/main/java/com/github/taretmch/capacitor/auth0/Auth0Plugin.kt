package com.github.taretmch.capacitor.auth0

import android.util.Log
import com.auth0.android.Auth0
import com.auth0.android.authentication.AuthenticationAPIClient
import com.auth0.android.authentication.AuthenticationException
import com.auth0.android.authentication.storage.CredentialsManagerException
import com.auth0.android.authentication.storage.SecureCredentialsManager
import com.auth0.android.authentication.storage.SharedPreferencesStorage
import com.auth0.android.callback.Callback
import com.auth0.android.provider.WebAuthProvider
import com.auth0.android.result.Credentials
import com.auth0.android.result.UserProfile
import com.getcapacitor.JSObject
import com.getcapacitor.Plugin
import com.getcapacitor.PluginCall
import com.getcapacitor.PluginMethod
import com.getcapacitor.annotation.CapacitorPlugin

@CapacitorPlugin(name = "Auth0")
class Auth0Plugin : Plugin() {

    private lateinit var auth0: Auth0
    private lateinit var manager: SecureCredentialsManager

    @PluginMethod
    fun load(call: PluginCall) {
        auth0 = Auth0(context)
        manager = SecureCredentialsManager(context, AuthenticationAPIClient(auth0), SharedPreferencesStorage(context))
        Log.d("CapacitorAuth0", "Auth0 clientId: " + auth0.clientId)
        Log.d("CapacitorAuth0", "Auth0 domain: " + auth0.getDomainUrl())

        manager.getCredentials(object: Callback<Credentials, CredentialsManagerException> {
            override fun onSuccess(credentials: Credentials) {
                val callbackSuccess = { userProfile: UserProfile ->
                    val data = JSObject()
                    data.put("id", userProfile.getId())
                    data.put("name", userProfile.name)
                    data.put("email", userProfile.email)
                    call.resolve(data)
                }
                val callbackFailure = { exception: AuthenticationException ->
                    call.reject("Failed with AuthenticationException : ", exception.message)
                }
                getUserProfile(credentials.accessToken, callbackSuccess, callbackFailure)
            }

            override fun onFailure(error: CredentialsManagerException) {
                // No credentials were previously saved or they couldn't be refreshed
                call.resolve()
            }
        })
    }

    @PluginMethod
    fun login(call: PluginCall) {

        val loginCallback = object : Callback<Credentials, AuthenticationException> {
            override fun onFailure(exception: AuthenticationException) {
                call.reject("Failed with AuthenticationException : ", exception.message)
            }
            override fun onSuccess(credentials: Credentials) {
                Log.d("CapacitorAuth0", "Login succeeded.")
                val callbackSuccess = { userProfile: UserProfile ->
                    val data = JSObject()
                    data.put("id", userProfile.getId())
                    data.put("name", userProfile.name)
                    data.put("email", userProfile.email)
                    call.resolve(data)
                }
                val callbackFailure = { exception: AuthenticationException ->
                    call.reject("Failed with AuthenticationException : ", exception.message)
                }
                manager.saveCredentials(credentials)
                getUserProfile(credentials.accessToken, callbackSuccess, callbackFailure)
            }
        }

        WebAuthProvider.login(auth0)
            .withScheme("demo")
            .withScope("openid profile email offline_access")
            .start(context, loginCallback)
    }

    @PluginMethod
    fun logout(call: PluginCall) {
        val callbackLogout = object: Callback<Void?, AuthenticationException> {
            override fun onSuccess(payload: Void?) {
                Log.d("CapacitorAuth0", "Logout succeeded.")
                manager.clearCredentials()
                call.resolve()
            }
            override fun onFailure(error: AuthenticationException) {
                call.reject("Failed with ", error.message)
            }
        }

        WebAuthProvider.logout(auth0)
            .withScheme("demo")
            .start(context, callbackLogout)
    }

    @PluginMethod
    fun isAuthenticated(call: PluginCall) {
        val loggedIn = manager.hasValidCredentials()
        val data = JSObject()
        data.put("result", loggedIn)
        call.resolve(data)
    }

    @PluginMethod
    fun getUserInfo(call: PluginCall) {
        manager.getCredentials(object: Callback<Credentials, CredentialsManagerException> {
            override fun onSuccess(credentials: Credentials) {
                val callbackSuccess = { userProfile: UserProfile ->
                    val data = JSObject()
                    data.put("id", userProfile.getId())
                    data.put("name", userProfile.name)
                    data.put("email", userProfile.email)
                    call.resolve(data)
                }
                val callbackFailure = { exception: AuthenticationException ->
                    call.reject("Failed with AuthenticationException : ", exception.message)
                }
                getUserProfile(credentials.accessToken, callbackSuccess, callbackFailure)
            }

            override fun onFailure(error: CredentialsManagerException) {
                // No credentials were previously saved or they couldn't be refreshed
                call.reject("Failed with CredentialsManagerException", error.message)
            }
        })
    }

    private fun getUserProfile(accessToken: String, callbackSuccess: (UserProfile) -> Unit, callbackFailure: (AuthenticationException) -> Unit) {
        AuthenticationAPIClient(auth0)
                .userInfo(accessToken)
                .start(object : Callback<UserProfile, AuthenticationException> {
                    override fun onFailure(exception: AuthenticationException) {
                        callbackFailure(exception)
                    }
                    override fun onSuccess(profile: UserProfile) {
                        callbackSuccess(profile)
                    }
                })
    }
}
