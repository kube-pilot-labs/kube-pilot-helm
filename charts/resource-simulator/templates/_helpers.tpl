{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "resource-simulator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "resource-simulator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "resource-simulator.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create Resource Monitor app version
*/}}
{{- define "resource-simulator.defaultTag" -}}
{{- default .Chart.AppVersion .Values.global.image.tag }}
{{- end -}}

{{/*
Return valid version label
*/}}
{{- define "resource-simulator.versionLabelValue" -}}
{{ regexReplaceAll "[^-A-Za-z0-9_.]" (include "resource-simulator.defaultTag" .) "-" | trunc 63 | trimAll "-" | trimAll "_" | trimAll "." | quote }}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "resource-simulator.labels" -}}
helm.sh/chart: {{ include "resource-simulator.chart" .context }}
{{ include "resource-simulator.selectorLabels" (dict "context" .context "component" .component "name" .name) }}
app.kubernetes.io/managed-by: {{ .context.Release.Service }}
app.kubernetes.io/part-of: resource-simulator
app.kubernetes.io/version: {{ include "resource-simulator.versionLabelValue" .context }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "resource-simulator.selectorLabels" -}}
{{- if .name -}}
app.kubernetes.io/name: {{ include "resource-simulator.name" .context }}-{{ .name }}
{{ end -}}
app.kubernetes.io/instance: {{ .context.Release.Name }}
{{- if .component }}
app.kubernetes.io/component: {{ .component }}
{{- end }}
{{- end }}

{{/*
Expand the namespace of the release.
Allows overriding it for multi-namespace deployments in combined charts.
*/}}
{{- define "resource-simulator.namespace" -}}
{{- default .Release.Namespace .Values.namespaceOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "resource-simulator.fullname" -}}
{{- printf "%s-%s" (include "resource-simulator.fullname" .) .Values.k8sPilotAgent.name | trunc 52 | trimSuffix "-" -}}
{{- end -}}
