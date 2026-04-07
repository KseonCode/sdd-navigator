{{/* @req REQ-INFRA-005 Helm helper templates for parameterization */}}

{{/*
Имя чарта
*/}}
{{- define "sdd-navigator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

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
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}

{{/*
Selector метки
*/}}
{{- define "sdd-navigator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "sdd-navigator.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/* @req REQ-INFRA-003 Database labels */}}
{{- define "postgres.labels" -}}
app: postgres
component: database
{{ include "sdd-navigator.labels" . }}
{{- end }}

{{/* @req REQ-INFRA-002 API labels */}}
{{- define "api.labels" -}}
app: sdd-api
component: backend
{{ include "sdd-navigator.labels" . }}
{{- end }}

{{/* @req REQ-INFRA-004 Frontend labels */}}
{{- define "web.labels" -}}
app: sdd-web
component: frontend
{{ include "sdd-navigator.labels" . }}
{{- end }}