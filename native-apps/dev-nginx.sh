PROFILE=$1
DEPLOY=$2
DEPLOY_OPTION=$3

# helm패키지조회
if [ ${DEPLOY_OPTION} == "helm-list" ]; then
    helm list --kubeconfig ~/.kube/${PROFILE}-config -n ${DEPLOY}
fi

# helm패키지배포
if [ ${DEPLOY_OPTION} == "helm-deploy" ]; then
    helm upgrade --install --kubeconfig ~/.kube/${PROFILE}-config ${DEPLOY} ./helm-packages/${DEPLOY}/ -n ${DEPLOY} -f ./custom-yamls/${DEPLOY}/${PROFILE}-values.yaml
fi

# helm패키지삭제
if [ ${DEPLOY_OPTION} == "helm-remove" ]; then
    helm uninstall --kubeconfig ~/.kube/${PROFILE}-config ${DEPLOY} -n ${DEPLOY}
fi

# k8s리소스조회
if [ ${DEPLOY_OPTION} == "resource-list" ]; then
    kubectl get -f ./custom-yamls/${DEPLOY}/${PROFILE}-namespace.yaml --kubeconfig ~/.kube/${PROFILE}-config
    kubectl get -f ./custom-yamls/${DEPLOY}/${PROFILE}-service.yaml --kubeconfig ~/.kube/${PROFILE}-config
fi

# k8s리소스배포
if [ ${DEPLOY_OPTION} == "resource-deploy" ]; then
    kubectl apply -f ./custom-yamls/${DEPLOY}/${PROFILE}-namespace.yaml --kubeconfig ~/.kube/${PROFILE}-config
    kubectl apply -f ./custom-yamls/${DEPLOY}/${PROFILE}-service.yaml --kubeconfig ~/.kube/${PROFILE}-config
fi