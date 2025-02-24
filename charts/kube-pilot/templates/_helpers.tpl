
{{- define "kube-pilot.k8sPilotAgent.fullname" -}}
{{- printf "%s-%s" (include "kube-pilot.fullname" .) .Values.k8sPilotAgent.name | trunc 52 | trimSuffix "-" -}}
{{- end -}}

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