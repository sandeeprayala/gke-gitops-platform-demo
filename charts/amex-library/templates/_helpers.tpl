{{/*
AMEX standard labels applied to every resource.
*/}}
{{- define "amex.labels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: argocd
amex.com/environment: {{ .Values.environment | default "dev" }}
{{- end -}}

{{/*
AMEX standard selector labels (immutable subset used for matchLabels).
*/}}
{{- define "amex.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
AMEX standard pod-level security context.
*/}}
{{- define "amex.podSecurityContext" -}}
runAsNonRoot: true
runAsUser: 1000
fsGroup: 2000
seccompProfile:
  type: RuntimeDefault
{{- end -}}

{{/*
AMEX standard container-level security context.
*/}}
{{- define "amex.containerSecurityContext" -}}
allowPrivilegeEscalation: false
readOnlyRootFilesystem: true
capabilities:
  drop:
    - ALL
{{- end -}}

{{/*
AMEX standard liveness probe (HTTP GET, overridable path/port via values).
*/}}
{{- define "amex.livenessProbe" -}}
httpGet:
  path: {{ .Values.probes.liveness.path | default "/healthz" }}
  port: {{ .Values.probes.liveness.port | default .Values.service.port }}
initialDelaySeconds: {{ .Values.probes.liveness.initialDelaySeconds | default 15 }}
periodSeconds: {{ .Values.probes.liveness.periodSeconds | default 20 }}
{{- end -}}

{{/*
AMEX standard readiness probe.
*/}}
{{- define "amex.readinessProbe" -}}
httpGet:
  path: {{ .Values.probes.readiness.path | default "/ready" }}
  port: {{ .Values.probes.readiness.port | default .Values.service.port }}
initialDelaySeconds: {{ .Values.probes.readiness.initialDelaySeconds | default 5 }}
periodSeconds: {{ .Values.probes.readiness.periodSeconds | default 10 }}
{{- end -}}

{{/*
AMEX standard resource requests/limits block.
*/}}
{{- define "amex.resources" -}}
requests:
  cpu: {{ .Values.resources.requests.cpu | default "100m" }}
  memory: {{ .Values.resources.requests.memory | default "128Mi" }}
limits:
  cpu: {{ .Values.resources.limits.cpu | default "500m" }}
  memory: {{ .Values.resources.limits.memory | default "512Mi" }}
{{- end -}}
