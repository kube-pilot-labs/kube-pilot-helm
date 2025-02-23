{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kube-pilot.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "kube-pilot.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create Kube Pilot app version
*/}}
{{- define "kube-pilot.defaultTag" -}}
{{- default .Chart.AppVersion .Values.global.image.tag }}
{{- end -}}

{{/*
Return valid version label
*/}}
{{- define "kube-pilot.versionLabelValue" -}}
{{ regexReplaceAll "[^-A-Za-z0-9_.]" (include "kube-pilot.defaultTag" .) "-" | trunc 63 | trimAll "-" | trimAll "_" | trimAll "." | quote }}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kube-pilot.labels" -}}
helm.sh/chart: {{ include "kube-pilot.chart" .context }}
{{ include "kube-pilot.selectorLabels" (dict "context" .context "component" .component "name" .name) }}
app.kubernetes.io/managed-by: {{ .context.Release.Service }}
app.kubernetes.io/part-of: kube-pilot
app.kubernetes.io/version: {{ include "kube-pilot.versionLabelValue" .context }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "kube-pilot.selectorLabels" -}}
{{- if .name -}}
app.kubernetes.io/name: {{ include "kube-pilot.name" .context }}-{{ .name }}
{{ end -}}
app.kubernetes.io/instance: {{ .context.Release.Name }}
{{- if .component }}
app.kubernetes.io/component: {{ .component }}
{{- end }}
{{- end }}
