var apimanUrl = UrlHelpers.join("http://localhost:8998/", Kubernetes.kubernetesApiUrl(), Kubernetes.kubernetesNamespacePath(), "/services/apiman")
var APIMAN_CONFIG_DATA = {
    "apiman" : {
        "version" : "1.1.1",
        "builtOn" : "fabric8",
        "logoutUrl" : "/notavailable"
    },
    "user" : {
        "username" : "n/a"
    },
    "ui" : {
        "header" : false
    },
    "api" : {
        "endpoint" : apimanUrl,
        "auth" : {
            "type" : "none"
        }
    }
}
