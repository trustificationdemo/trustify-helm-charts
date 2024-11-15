{{/*
Environment variables required to configure the S3 storage

Arguments (dict):
  * root - .
  * module - module object
*/}}
{{ define "trustification.storage.envVars" -}}
{{- if .module.storage}}
{{- include "_trustification.storage.envVars" ( set (deepCopy .) "storage" .module.storage ) }}
{{- else }}
{{- include "_trustification.storage.envVars" ( set (deepCopy .) "storage" .root.Values.storage ) }}
{{- end }}
{{- end }}

{{ define "_trustification.storage.envVars"}}
{{- if .storage.filessytem }}
{{- include "_trustification.storage.filesystem.envVars" ( set (deepCopy .) "storage" .storage.filesystem ) }}
{{- else if .storage.s3 }}
{{- include "_trustification.storage.s3.envVars" ( set (deepCopy .) "storage" .storage.s3 ) }}
{{- end }}
{{- end }}


{{/* filesystem storage configuration */}}
{{- define "_trustification.storage.s3.envVars" -}}
{{- end }}

{{/* S3 storage configuration */}}
{{- define "_trustification.storage.s3.envVars" -}}

- name: STORAGE_ACCESS_KEY
  {{- include "trustification.common.envVarValue" .storage.accessKey | nindent 2 }}

- name: STORAGE_SECRET_KEY
  {{- include "trustification.common.envVarValue" .storage.secretKey | nindent 2 }}

{{ if .storage.endpoint }}
- name: STORAGE_ENDPOINT
  value: {{ .storage.endpoint | quote }}
- name: STORAGE_REGION
  value: "eu-west-1" # just a dummy value
{{ else }}
- name: STORAGE_REGION
  value: "{{ .storage.region }}"
{{ end }}

- name: STORAGE_BUCKET
  value: {{ .storage.bucket | quote }}

{{- end }}
