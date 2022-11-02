DEPLOY=$1
DEPLOY_OPTION=$2

# helm패키지조회
if [ ${DEPLOY_OPTION} == "helm-list" ]; then
    helm list --kubeconfig ~/.kube/dev-config -n ${DEPLOY}
fi

# helm패키지배포
if [ ${DEPLOY_OPTION} == "helm-deploy" ]; then
    helm upgrade --install --kubeconfig ~/.kube/dev-config ${DEPLOY} ./helm-packages/${DEPLOY}/ -n ${DEPLOY} -f ./custom-yamls/${DEPLOY}/dev-values.yaml
fi

# helm패키지삭제
if [ ${DEPLOY_OPTION} == "helm-remove" ]; then
    helm uninstall --kubeconfig ~/.kube/dev-config ${DEPLOY} -n ${DEPLOY}
fi

# k8s리소스조회
if [ ${DEPLOY_OPTION} == "resource-list" ]; then
    kubectl get -f ./custom-yamls/${DEPLOY}/dev-namespace.yaml --kubeconfig ~/.kube/dev-config

    if [ ${DEPLOY} == "ingress-nginx" ] || [ ${DEPLOY} == "prometheus" ] || [ ${DEPLOY} == "loki-stack" ]; then
        kubectl get -f ./custom-yamls/${DEPLOY}/dev-service.yaml --kubeconfig ~/.kube/dev-config
    fi
fi
# k8s리소스배포
if [ ${DEPLOY_OPTION} == "resource-deploy" ]; then
    kubectl apply -f ./custom-yamls/${DEPLOY}/dev-namespace.yaml --kubeconfig ~/.kube/dev-config

    if [ ${DEPLOY} == "ingress-nginx" ] || [ ${DEPLOY} == "prometheus" ] || [ ${DEPLOY} == "loki-stack" ]; then
        kubectl apply -f ./custom-yamls/${DEPLOY}/dev-service.yaml --kubeconfig ~/.kube/dev-config
    fi
fi