
{{- define "kube-pilot.k8sPilotAgent.fullname" -}}
{{- printf "%s-%s" (include "kube-pilot.fullname" .) .Values.k8sPilotAgent.name | trunc 52 | trimSuffix "-" -}}
{{- end -}}

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

{{/*
Create the name of the server service account to use
*/}}
{{- define "kube-pilot.server.serviceAccountName" -}}
{{- if .Values.server.serviceAccount.create -}}
    {{ default (include "kube-pilot.server.fullname" .) .Values.server.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.server.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{- define "kube-pilot.server.fullname" -}}
{{- printf "%s-%s" (include "kube-pilot.fullname" .) .Values.server.name | trunc 52 | trimSuffix "-" -}}
{{- end -}}
