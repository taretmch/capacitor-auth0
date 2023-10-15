package com.github.taretmch.capacitor.auth0

import android.R
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


@CapacitorPlugin(name = "CapacitorAuth0")
class CapacitorAuth0Plugin : Plugin() {

    private val auth0: Auth0 = Auth0(
        context.resources.getString(R.string.com_auth0_client_id),
        context.resources.getString(R.string.com_auth0_domain)
    )

    @PluginMethod
    suspend fun login(call: PluginCall) {
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

    @PluginMethod
    suspend fun logout(call: PluginCall) {
        try {
            WebAuthProvider.logout(auth0)
                .withScheme("demo")
                .await(context)

            call.resolve()
        } catch (e: AuthenticationException) {
            call.reject(e.getDescription())
        }
    }

    private suspend fun getUserProfile(accessToken: String): UserProfile {
        var apiClient = AuthenticationAPIClient(auth0)
        return apiClient.userInfo(accessToken).await()
    }

}