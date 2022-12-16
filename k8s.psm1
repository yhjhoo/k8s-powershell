New-Alias -Name k -Value kubectl

function kcurrent() {
    <#
    .SYNOPSIS

    kcurrent
    display current kubernets namespaces
    #>

    $myJson = k config view --minify -o json | ConvertFrom-Json
    $namespace = $myJson.contexts.context.namespace
    $cluster = $myJson.contexts.context.cluster
    Write-Output "namespace: $namespace"
    Write-Output "cluster: $cluster"
}

function kmini() {
    <#
    .SYNOPSIS

    kmini
    switch to mimikube context
    #>
    k config use-context minikube
}

function kns([string]$ns) {
    <#
    .SYNOPSIS

    kns
    switch kubernets namespaces
    #>

    k config set-context --current --namespace=$ns
    Write-Output "Switched to namespace $ns"
}

function kgpa() {
    <#
    .SYNOPSIS

    kgpa
    kubectl get pod in all namespaces
    #>
    k get pod --all-namespaces
}

function kga() {
    k get all
}

function kge() {
    <#
    .SYNOPSIS

    kge
    kubectl get event
    #>
    k get event $args
}

function kgp() {
    <#
    .SYNOPSIS

    kgp
    kubectl get pod
    #>
    k get pod $args
}

function kl() {
    <#
    .SYNOPSIS

    kl
    kubectl logs pod/app
    #>
    k logs $args
}

function klf() {
    <#
    .SYNOPSIS

    klf
    kubectl logs pod/app and follow
    #>
    k logs $args -f
}

function kap() {
    <#
    .SYNOPSIS

    kap
    kubectl apply

    .EXAMPLE
    kap -f app.yaml

    .EXAMPLE
    kap -k ./app

    #>
    k apply $args
}

function kd([string]$resource) {
    <#
    .SYNOPSIS

    kd
    describe kubernets resources
    #>
    k describe $resource $args
}

function ktp([string]$pod) {
    <#
    .SYNOPSIS

    ktp
    display pod's cpu and memory usage
    #>
    if ($pod.StartsWith("pod/")) {
        $pod = $pod.replace("pod/", "")
    }

    k top pod $pod --containers --use-protocol-buffers $args
}

function kstop_deployment([string]$deployment) {
    <#
    .SYNOPSIS

    kstop_deployment
    stop deployment by increase deployment replica to 0
    #>
    if (!$deployment.StartsWith("deployment.apps")) {
        $deployment = "deployment/$deployment"
    }

    k scale $deployment --replicas=0
}

function kstart_deployment([string]$deployment) {
    <#
    .SYNOPSIS

    kstart_deployment
    start deployment by increase deployment replica to 1
    #>
    
    if (!$deployment.StartsWith("deployment.apps")) {
        $deployment = "deployment/$deployment"
    }

    k scale $deployment --replicas=1
}

function kssh([string]$resource) {
    <#
    .SYNOPSIS

    kssh
    ssh login to kubernets containers with bash
    #>

    k exec --stdin --tty $resource -- /bin/bash
}

function kresource() {
    kubectl api-resources --verbs=list -o name
}
