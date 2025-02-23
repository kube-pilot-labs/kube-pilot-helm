
{{- define "kube-pilot.k8sPilotAgent.fullname" -}}
{{- printf "%s-%s" (include "kube-pilot.fullname" .) .Values.k8sPilotAgent.name | trunc 52 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kube-pilot.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Expand the namespace of the release.
Allows overriding it for multi-namespace deployments in combined charts.
*/}}
{{- define "kube-pilot.namespace" -}}
{{- default .Release.Namespace .Values.namespaceOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Create the name of the k8s-pilot-agent service account to use
*/}}
{{- define "kube-pilot.k8sPilotAgent.serviceAccountName" -}}
{{- if .Values.k8sPilotAgent.serviceAccount.create -}}
    {{ default (include "kube-pilot.k8sPilotAgent.fullname" .) .Values.k8sPilotAgent.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.k8sPilotAgent.serviceAccount.name }}
{{- end -}}
{{- end -}}