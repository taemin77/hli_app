PROFILE=$1
NATIVEAPP_NAME=$2
SUB_NAME=$3
DEPLOY_OPTION=$4

# helm패키지조회
if [ ${DEPLOY_OPTION} == "helm-list" ]; then
    helm list --kubeconfig ~/.kube/${PROFILE}-config -n ${PROFILE}-${NATIVEAPP_NAME}-${SUB_NAME}
fi

# helm패키지배포
if [ ${DEPLOY_OPTION} == "helm-deploy" ]; then
    helm upgrade --install --kubeconfig ~/.kube/${PROFILE}-config ${PROFILE}-${NATIVEAPP_NAME}-${SUB_NAME} ./helm-packages/${NATIVEAPP_NAME}/ -n ${PROFILE}-${NATIVEAPP_NAME} -f ./custom-yamls/${NATIVEAPP_NAME}/${PROFILE}-${SUB_NAME}-values.yaml
fi

# helm패키지삭제
if [ ${DEPLOY_OPTION} == "helm-remove" ]; then
    helm uninstall --kubeconfig ~/.kube/${PROFILE}-config ${PROFILE}-${NATIVEAPP_NAME}-${SUB_NAME} -n ${PROFILE}-${NATIVEAPP_NAME}
fi

# k8s리소스조회
if [ ${DEPLOY_OPTION} == "resource-list" ]; then
    kubectl get -f ./custom-yamls/${NATIVEAPP_NAME}/${PROFILE}-namespace.yaml --kubeconfig ~/.kube/${PROFILE}-config
    kubectl get -f ./custom-yamls/${NATIVEAPP_NAME}/${PROFILE}-${SUB_NAME}-service.yaml --kubeconfig ~/.kube/${PROFILE}-config
fi

# k8s리소스배포
if [ ${DEPLOY_OPTION} == "resource-deploy" ]; then
    kubectl apply -f ./custom-yamls/${NATIVEAPP_NAME}/${PROFILE}-namespace.yaml --kubeconfig ~/.kube/${PROFILE}-config
    kubectl apply -f ./custom-yamls/${NATIVEAPP_NAME}/${PROFILE}-${SUB_NAME}-service.yaml --kubeconfig ~/.kube/${PROFILE}-config
fi