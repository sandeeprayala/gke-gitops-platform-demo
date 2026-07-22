{{- define "amex-library.labels" -}}
app.kubernetes.io/managed-by: Helm
app.kubernetes.io/part-of: gitops-platform
{{- end -}}

{{- define "amex-library.name" -}}
{{ default .Chart.Name .Values.nameOverride }}
{{- end -}}

