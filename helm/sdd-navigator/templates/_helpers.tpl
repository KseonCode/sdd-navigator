{{- /* @req REQ-INFRA-001 Helper templates for consistent labels */ -}}
{{- define "sdd-navigator.labels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
