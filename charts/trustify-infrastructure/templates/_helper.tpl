{{ define "trustification-infrastructure.keycloakPostInstall.url" -}}
http://{{ .Release.Name }}-keycloak.{{ .Release.Namespace }}.svc.cluster.local:80
{{- end }}

{{- define "trustification-infrastructure.keycloakPostInstall.defaultRedirectUrls" }}
{{- if $.Capabilities.APIVersions.Has "route.openshift.io/v1/Route" }}
- https://server{{ .Values.appDomain }}
- https://server{{ .Values.appDomain }}/*
{{- else }}
- http://localhost:*
- http://server{{ .Values.appDomain }}
- http://server{{ .Values.appDomain }}/*
{{- end }}
{{- end }}
