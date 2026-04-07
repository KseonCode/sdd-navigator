{{/* @req REQ-INFRA-005 Helm helper templates for parameterization */}}

{{/*
Развернутое имя приложения
*/}}
{{- define "sdd-navigator.fullname" -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Общие метки
*/}}
{{- define "sdd-navigator.labels" -}}
helm.sh/chart: {{ include "sdd-navigator.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Метки для PostgreSQL
*/}}
{{- define "postgres.labels" -}}
app: postgres
component: database
{{ include "sdd-navigator.labels" . }}
{{- end }}

{{/*
Метки для API
*/}}
{{- define "api.labels" -}}
app: sdd-api
component: backend
{{ include "sdd-navigator.labels" . }}
{{- end }}

{{/*
Метки для Web
*/}}
{{- define "web.labels" -}}
app: sdd-web
component: frontend
{{ include "sdd-navigator.labels" . }}
{{- end }}

{{/*
Selector метки
*/}}
{{- define "sdd-navigator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "sdd-navigator.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}