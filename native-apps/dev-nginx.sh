PROFILE=$1
NATIVEAPP_NAME=$2
SUB_NAME=$3
DEPLOY_OPTION=$4
FULL_NAME=${PROFILE}-${NATIVEAPP_NAME}-${SUB_NAME}

# helm패키지조회
if [ ${DEPLOY_OPTION} == "helm-list" ]; then
    helm list --kubeconfig ~/.kube/${PROFILE}-config -n ${PROFILE}-${NATIVEAPP_NAME}
fi

# helm패키지배포
if [ ${DEPLOY_OPTION} == "helm-deploy" ]; then
    helm upgrade --install --kubeconfig ~/.kube/${PROFILE}-config ${FULL_NAME} ./native-apps/helm-packages/${NATIVEAPP_NAME}/ -n ${PROFILE}-${NATIVEAPP_NAME} -f ./native-apps/custom-yamls/${NATIVEAPP_NAME}/${FULL_NAME}-values.yaml
fi

# helm패키지삭제
if [ ${DEPLOY_OPTION} == "helm-remove" ]; then
    helm uninstall --kubeconfig ~/.kube/${PROFILE}-config ${FULL_NAME} -n ${PROFILE}-${NATIVEAPP_NAME}
fi

# k8s리소스조회
if [ ${DEPLOY_OPTION} == "resource-list" ]; then
    kubectl get -o wide -f ./native-apps/custom-yamls/${NATIVEAPP_NAME}/${PROFILE}-${NATIVEAPP_NAME}-namespace.yaml --kubeconfig ~/.kube/${PROFILE}-config
    kubectl get -o wide -f ./native-apps/custom-yamls/${NATIVEAPP_NAME}/${PROFILE}-${NATIVEAPP_NAME}-ingressclass.yaml --kubeconfig ~/.kube/${PROFILE}-config
    kubectl get -o wide -f ./native-apps/custom-yamls/${NATIVEAPP_NAME}/${FULL_NAME}-service.yaml --kubeconfig ~/.kube/${PROFILE}-config
    
fi

# k8s리소스배포
if [ ${DEPLOY_OPTION} == "resource-deploy" ]; then
    kubectl apply -f ./native-apps/custom-yamls/${NATIVEAPP_NAME}/${PROFILE}-${NATIVEAPP_NAME}-namespace.yaml --kubeconfig ~/.kube/${PROFILE}-config
    kubectl apply -f ./native-apps/custom-yamls/${NATIVEAPP_NAME}/${PROFILE}-${NATIVEAPP_NAME}-ingressclass.yaml --kubeconfig ~/.kube/${PROFILE}-config
    kubectl apply -f ./native-apps/custom-yamls/${NATIVEAPP_NAME}/${FULL_NAME}-service.yaml --kubeconfig ~/.kube/${PROFILE}-config
fi