
## Redis
oc new-app --template=redis-ephemeral -p REDIS_PASSWORD=redis

## Client
oc new-app docker.io/ljhiyh/chat-client:v1

oc scale dc chat-client --replicas=1
oc expose svc chat-client


## Server
oc new-app docker.io/ljhiyh/chat-server:redis
oc expose svc chat-server --hostname="chat-server-example-chat.apps.toronto.openshiftworkshop.com"


## Auth
oc new-app docker.io/ljhiyh/auth-app
oc create service clusterip auth --tcp=8080:8080 
oc patch svc auth -p '{"spec": {"selector": {"app": "auth-app"}}}'
oc patch svc auth -p '{"spec": {"selector": {"deploymentconfig": "app-server"}}}'
