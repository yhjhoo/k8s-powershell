New-Alias -Name k -Value kubectl

function kcurrent() {
    $myJson = k config view --minify -o json | ConvertFrom-Json
    $namespace = $myJson.contexts.context.namespace
    $cluster = $myJson.contexts.context.cluster
    Write-Output "namespace: $namespace"
    Write-Output "cluster: $cluster"
}

function kmini() {
    k config use-context minikube
}

function kns([string]$ns) {
    k config set-context --current --namespace=$ns
    Write-Output "Switched to namespace $ns"
}

function kgpa() {
    k get pod --all-namespaces
}

function kga() {
    k get all
}

function kgp() {
    k get pod $args
}

function kd([string]$resource) {
    k describe $resource $args
}

function kdp([string]$pod) {
    if (!$pod.StartsWith("pod/")) {
        $pod = "pod/$pod"
    }
    k delete $pod
}

function ktp([string]$pod) {
    if ($pod.StartsWith("pod/")) {
        $pod = $pod.replace("pod/", "")
    }

    k top pod $pod --containers --use-protocol-buffers $args
}

function kstop_deployment([string]$deployment) {
    if (!$deployment.StartsWith("deployment.apps")) {
        $deployment = "deployment/$deployment"
    }

    k scale $deployment --replicas=0
}

function kstart_deployment([string]$deployment) {
    if (!$deployment.StartsWith("deployment.apps")) {
        $deployment = "deployment/$deployment"
    }

    k scale $deployment --replicas=1
}

function ksh([string]$resource) {
    k exec --stdin --tty $resource -- /bin/bash
}