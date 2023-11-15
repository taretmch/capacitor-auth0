package com.github.taretmch.capacitor.auth0

import android.util.Log
import com.auth0.android.Auth0
import com.auth0.android.authentication.AuthenticationAPIClient
import com.auth0.android.authentication.AuthenticationException
import com.auth0.android.provider.WebAuthProvider
import com.auth0.android.result.UserProfile
import com.getcapacitor.JSObject
import com.getcapacitor.Plugin
import com.getcapacitor.PluginCall
import com.getcapacitor.PluginMethod
import com.getcapacitor.annotation.CapacitorPlugin
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

@CapacitorPlugin(name = "CapacitorAuth0")
class CapacitorAuth0Plugin : Plugin() {

    private lateinit var auth0: Auth0

    @PluginMethod
    fun configure(call: PluginCall) {
        try {
            val clientId = call.getString("clientId")
                    ?: throw IllegalArgumentException("clientId is required.")
            val domain = call.getString("domain")
                    ?: throw IllegalArgumentException("domain is required.")
            this.auth0 = Auth0(context)
            call.resolve()
        } catch (e: IllegalArgumentException) {
            call.reject(e.message)
        }
    }

    @PluginMethod
    fun login(call: PluginCall) {
        CoroutineScope(Dispatchers.Main).launch {
            try {
                val credentials = WebAuthProvider.login(auth0)
                        .withScheme("demo")
                        .withScope("openid profile email")
                        .await(context)
                val userProfile = getUserProfile(credentials.accessToken)

                val data = JSObject()
                data.put("id", userProfile.getId())
                data.put("name", userProfile.name)
                data.put("email", userProfile.email)
                call.resolve(data)
            } catch(e: AuthenticationException) {
                call.reject(e.getDescription())
            }
        }
    }

    @PluginMethod
    fun logout(call: PluginCall) {
        CoroutineScope(Dispatchers.Main).launch {
            try {
                WebAuthProvider.logout(auth0)
                        .withScheme("demo")
                        .await(context)

                call.resolve()
            } catch (e: AuthenticationException) {
                call.reject(e.getDescription())
            }
        }
    }

    private suspend fun getUserProfile(accessToken: String): UserProfile {
        val apiClient = AuthenticationAPIClient(this.auth0)
        return apiClient.userInfo(accessToken).await()
    }

}
