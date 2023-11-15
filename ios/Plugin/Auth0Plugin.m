#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(Auth0Plugin, "Auth0",
           CAP_PLUGIN_METHOD(load, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(login, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(logout, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(isAuthenticated, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(getUserInfo, CAPPluginReturnPromise);
)
