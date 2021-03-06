Opensrp-web
===========

OpenSRP Web is the default frontend for the OpenSRP Server API, providing access to the data collected on the server, configuration options as well as any functionality provided by the API server.

## TL;DR

```bash
$ helm repo add opensrp https://helm.smartregister.org
$ helm install opensrp-web opensrp/opensrp-web
```

## Introduction

This chart bootstraps  [opensrp web](https://github.com/OpenSRP/web) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.12+
- Helm 3.1.0

## Installing the Chart

To install the chart with the release name `opensrp-web`:

## Prerequisites for installing Opensrp Web
An Opensrp Server Web Instance

Sample value.yaml
````yaml
---
image:
  tag: "v1.0.5"

ingress:
  enabled: true
  annotations:
    kubernetes.io/ingress.class: nginx
    kubernetes.io/tls-acme: "true"
    cert-manager.io/cluster-issuer: "<cluster-issuer>"
    cert-manager.io/acme-challenge-type: http01
    nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
  hosts:
    - host: <website-url>
      paths: ["/"]
  tls:
    - secretName: <website-tls-name>
      hosts:
        - <website-url>

sharedVars:
  keycloakUrl: "keycloak-url"
  appDomainName: "<app-domain-name>"
  opensrpClientId: "<opensrp-client-id>"
  opensrpServer: "<opensrp-server>"
  keycloakRealm: "<keycloak-realm>"
  opensrpClientSecret: sample
  
express:
  opensrpClientId: "<opensrp-client-id>"
  sessionName: "<session-name>"
  opensrpClientSecret: sample
  sessionSecret: sample-secret
  
reactEnvironmentVariables:
  REACT_APP_ENABLE_LOCATIONS: "true"
  REACT_APP_ENABLE_TEAMS: "true"
  REACT_APP_WEBSITE_NAME: "<website-name>"
  REACT_APP_ENABLE_TEAMS_ASSIGNMENT_MODULE: "true"
````

## Common Parameters
| Parameter                | Description             | Default        |  
| ------------------------ | ----------------------- | -------------- |  
| `replicaCount` | `Number of pods` | `1` |  
| `image.registry` | `Image regsitry` | `"docker.io"` |  
| `image.repository` | `Image name` | `"opensrp/opensrp-web"` |  
| `image.pullPolicy` | `Image pull policy` | `"IfNotPresent"` |  
| `image.tag` | `Image tag` | `"v1.0.5"` |  
| `imagePullSecrets` |  | `[]` |  
| `nameOverride` | `Paritally overrides opensrp-web.fullname` | `""` |  
| `fullnameOverride` | `Fully Overrides opensrp-web.fullname`  | `""` |  
| `serviceAccount.create` | `Created Serivce Accounts for the setup` | `true` |  
| `serviceAccount.annotations` |  | `{}` |  
| `serviceAccount.name` |  | `""` |  
| `podAnnotations` | `if recreatePodsWhenConfigMapChange is false then default will be {}` | `{{checksum/config: {{ include (print $.Template.BasePath "/configmap.yaml") . \| sha256sum }}}}` |  
| `podSecurityContext` |  | `{}` |  
| `securityContext` |  | `{}` |  
| `service.type` |  | `"ClusterIP"` |  
| `service.port` |  | `8080` |  
| `ingress.enabled` |  | `false` |  
| `ingress.annotations` |  | `{}` |  
| `ingress.hosts` |  | `[{"host": "opensrp-web.local", "paths": []}]` |  
| `ingress.tls` |  | `[]` |  
| `resources` |  | `{}` |  
| `autoscaling.enabled` |  | `false` |  
| `autoscaling.minReplicas` |  | `1` |  
| `autoscaling.maxReplicas` |  | `100` |  
| `autoscaling.targetCPUUtilizationPercentage` |  | `80` |  
| `nodeSelector` |  | `{}` |  
| `tolerations` |  | `[]` |  
| `affinity` |  | `{}` |  

## Opensrp Web  Parameters

The following table lists the configurable parameters of the Opensrp-web chart and their default values.

| Parameter                | Description             | Default        |
| ------------------------ | ----------------------- | -------------- |
| `recreatePodsWhenConfigMapChange` |  | `true` |
| `containerEnvironmentVariables.EXPRESS_OPENSRP_AUTHORIZATION_URL` |  | `"https://{{ .sharedVars.keycloakUrl }}/auth/realms/{{ .sharedVars.keycloakRealm }}/protocol/openid-connect/auth"` |
| `containerEnvironmentVariables.EXPRESS_OPENSRP_ACCESS_TOKEN_URL` |  | `"https://{{ .sharedVars.keycloakUrl }}/auth/realms/{{ .sharedVars.keycloakRealm }}/protocol/openid-connect/token"` |
| `containerEnvironmentVariables.EXPRESS_OPENSRP_CALLBACK_URL` |  | `"https://{{ .sharedVars.appDomainName }}/oauth/callback/OpenSRP/"` |
| `containerEnvironmentVariables.EXPRESS_OPENSRP_USER_URL` |  | `"https://{{ .sharedVars.opensrpServer  }}/opensrp/user-details/"` |
| `containerEnvironmentVariables.EXPRESS_OPENSRP_CLIENT_ID` |  | `"{{ .sharedVars.opensrpClientId }}"` |
| `containerEnvironmentVariables.EXPRESS_OPENSRP_CLIENT_SECRET` |  | `"{{ .sharedVars.opensrpClientSecret }}"` |
| `containerEnvironmentVariables.EXPRESS_SESSION_NAME` |  | `"{{ .express.sessionName }}"` |
| `containerEnvironmentVariables.EXPRESS_OAUTH_GET_STATE_URL` |  | `"https://{{ .sharedVars.appDomainName }}/oauth/state"` |
| `containerEnvironmentVariables.EXPRESS_SESSION_SECRET` |  | `"{{ .express.sessionSecret }}"` |
| `containerEnvironmentVariables.EXPRESS_FRONTEND_OPENSRP_CALLBACK_URL` |  | `"https://{{ .sharedVars.appDomainName }}/fe/oauth/callback/opensrp"` |
| `containerEnvironmentVariables.EXPRESS_REACT_BUILD_PATH` |  | `"{{ .express.reactBuildPath }}"` |
| `containerEnvironmentVariables.NODE_ENV` |  | `"{{ .express.nodeEnv }}"` |
| `containerEnvironmentVariables.EXPRESS_FRONTEND_LOGIN_URL` |  | `"{{ .express.frontEndLoginUrl }}"` |
| `containerEnvironmentVariables.EXPRESS_OPENSRP_OAUTH_STATE` |  | `"{{ .express.opensrpOauthState }}"` |
| `containerEnvironmentVariables.EXPRESS_SESSION_PATH` |  | `"{{ .express.sessionPath }}"` |
| `containerEnvironmentVariables.EXPRESS_SESSION_LOGIN_URL` |  | `"{{ .express.sessionLoginUrl }}"` |
| `containerEnvironmentVariables.EXPRESS_SESSION_FILESTORE_PATH` |  | `"{{ .express.frontEndLogoutUrl }}"` |
| `containerEnvironmentVariables.EXPRESS_FRONTEND_LOGOUT_URL` |  | `"{{ .express.sessionFileStorePath }}"` |
| `containerEnvironmentVariables.EXPRESS_PRELOADED_STATE_FILE` |  | `"{{ .express.preloadedStateFile }}"` |
| `reactEnvironmentVariables.REACT_APP_DOMAIN_NAME` |  | `"https://{{ .sharedVars.appDomainName }}"` |
| `reactEnvironmentVariables.REACT_APP_EXPRESS_OAUTH_GET_STATE_URL` |  | `"https://{{ .sharedVars.appDomainName }}/oauth/state"` |
| `reactEnvironmentVariables.REACT_APP_EXPRESS_OAUTH_LOGOUT_URL` |  | `"https://{{ .sharedVars.appDomainName }}/logout"` |
| `reactEnvironmentVariables.REACT_APP_KEYCLOAK_API_BASE_URL` |  | `"https://{{ .sharedVars.keycloakUrl }}/auth/admin/realms/{{ .sharedVars.keycloakRealm }}"` |
| `reactEnvironmentVariables.REACT_APP_KEYCLOAK_LOGOUT_URL` |  | `"https://{{ .sharedVars.keycloakUrl }}/auth/realms/{{ .sharedVars.keycloakRealm }}/protocol/openid-connect/logout"` |
| `reactEnvironmentVariables.REACT_APP_OPENSRP_ACCESS_TOKEN_URL` |  | `"https://{{ .sharedVars.keycloakUrl }}/auth/realms/{{ .sharedVars.keycloakRealm }}/protocol/openid-connect/token"` |
| `reactEnvironmentVariables.REACT_APP_OPENSRP_AUTHORIZATION_URL` |  | `"https://{{ .sharedVars.keycloakUrl }}/auth/realms/{{ .sharedVars.keycloakRealm }}/protocol/openid-connect/auth"` |
| `reactEnvironmentVariables.REACT_APP_OPENSRP_LOGOUT_URL` |  | `"https://{{ .sharedVars.opensrpServer  }}/opensrp/logout.do"` |
| `reactEnvironmentVariables.REACT_APP_OPENSRP_USER_URL` |  | `"https://{{ .sharedVars.opensrpServer  }}/opensrp/user-details/"` |
| `reactEnvironmentVariables.REACT_APP_OPENSRP_API_BASE_URL` |  | `"https://{{ .sharedVars.opensrpServer }}/opensrp/rest/"` |
| `reactEnvironmentVariables.REACT_APP_FHIR_API_BASE_URL` |  | `"https://{{ .sharedVars.fhirServer }}/fhir"` |
| `reactEnvironmentVariables.REACT_APP_OPENSRP_CLIENT_ID` |  | `"{{ .sharedVars.opensrpClientId }}"` |
| `reactEnvironmentVariables.REACT_APP_ENABLE_FHIR_PATIENTS` |  | `"false"` |
| `reactEnvironmentVariables.REACT_APP_BACKEND_ACTIVE` |  | `"true"` |
| `reactEnvironmentVariables.REACT_APP_DISABLE_LOGIN_PROTECTION` |  | `"false"` |
| `reactEnvironmentVariables.REACT_APP_ENABLE_OPENSRP_OAUTH` |  | `"true"` |
| `reactEnvironmentVariables.REACT_APP_WEBSITE_NAME` |  | `"opensrp-web"` |
| `reactEnvironmentVariables.REACT_APP_ACTION_UUID_NAMESPACE` |  | `"35968df5-f335-44ae-8ae5-25804caa2d86"` |
| `reactEnvironmentVariables.REACT_APP_PLAN_UUID_NAMESPACE` |  | `"85f7dbbf-07d0-4c92-aa2d-d50d141dde00"` |
| `reactEnvironmentVariables.REACT_APP_ENABLE_PRODUCT_CATALOGUE` |  | `"false"` |
| `reactEnvironmentVariables.REACT_APP_ENABLE_PLANS` |  | `"false"` |
| `reactEnvironmentVariables.REACT_APP_ENABLE_INVENTORY` |  | `"false"` |
| `reactEnvironmentVariables.REACT_APP_ENABLE_LOCATIONS` |  | `"false"` |
| `reactEnvironmentVariables.REACT_APP_ENABLE_TEAMS` |  | `"false"` |
| `reactEnvironmentVariables.REACT_APP_ENABLE_CARD_SUPPORT` |  | `"false"` |
| `reactEnvironmentVariables.REACT_APP_MAIN_LOGO_SRC` |  | `"https://github.com/OpenSRP/web/raw/master/app/src/assets/images/opensrp-logo-color.png"` |
| `reactEnvironmentVariables.REACT_APP_DEFAULT_PLAN_DURATION_DAYS` |  | `"20"` |
| `reactEnvironmentVariables.REACT_APP_DEFAULT_ACTIVITY_DURATION_DAYS` |  | `"7"` |
| `reactEnvironmentVariables.REACT_APP_DATE_FORMAT` |  | `"yyyy-mm-dd"` |
| `reactEnvironmentVariables.REACT_APP_ENABLE_TEAMS_ASSIGNMENT_MODULE` |  | `"false"` |
| `reactEnvironmentVariables.REACT_APP_DEFAULT_PLAN_ID` |  | `"27362060-0309-411a-910c-64f55ede3758"` |
| `reactEnvironmentVariables.SKIP_PREFLIGHT_CHECK` |  | `"true"` |
| `reactEnvironmentVariables.REACT_APP_PLAN_ASSIGNMENT_AT_GEO_LEVEL` |  | `"0"` |
| `reactEnvironmentVariables.REACT_APP_SENTRY_DSN` |  | `""` |
| `reactEnvironmentVariables.REACT_APP_DEFAULT_PLAN_VERSION` |  | `"1"` |
| `reactEnvironmentVariables.REACT_APP_TASK_GENERATION_STATUS` |  | `"False"` |
| `reactEnvironmentVariables.REACT_APP_PROJECT_LANGUAGE_CODE` |  | `"core"` |
| `reactEnvironmentVariables.REACT_APP_LANGUAGE_CODE` |  | `"en"` |
| `reactEnvironmentVariables.REACT_APP_SUPPORTED_LANGUAGES` |  | `"en"` |
| `reactEnvironmentVariables.REACT_APP_ENABLE_LANGUAGE_SWITCHER` |  | `"false"` |
| `sharedVars.keycloakUrl` |  | `"keycloakUrl"` |
| `sharedVars.appDomainName` |  | `"appDomainName"` |
| `sharedVars.opensrpClientId` |  | `"opensrpClientId"` |
| `sharedVars.opensrpServer` |  | `"opensrpServer"` |
| `sharedVars.keycloakRealm` |  | `"keycloakRealm"` |
| `sharedVars.fhirServer` |  | `"fhirServer"` |
| `express.opensrpClientId` |  | `""` |
| `express.opensrpClientSecret` |  | `""` |
| `express.sessionName` |  | `"express_sessionName"` |
| `express.sessionSecret` |  | `"express_sessionSecret"` |
| `express.opensrpOauthState` |  | `"opensrp"` |
| `express.sessionLoginUrl` |  | `"/login"` |
| `express.preloadedStateFile` |  | `"/tmp/opensrpState.json"` |
| `express.sessionFileStorePath` |  | `"/tmp/express-sessions"` |
| `express.frontEndLoginUrl` |  | `"/fe/login"` |
| `express.sessionPath` |  | `"/"` |
| `express.reactBuildPath` |  | `"/usr/src/web"` |
| `express.nodeEnv` |  | `"development"` |
| `express.frontEndLogoutUrl` |  | `"/logout"` |

