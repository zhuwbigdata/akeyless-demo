# Install Postgres
Reference:
 (https://github.com/bitnami/charts/tree/master/bitnami/postgresql/#installing-the-chart)

```
APP_NAME="postgresql" # options include: mysql, mongodb, jenkins, wordpress, elasticsearch, grafana, etc..
AKEYLESS_NAMESPACE="waynez"

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm show values bitnami/"$APP_NAME" > values.yaml
helm upgrade --install -f values.yaml "$APP_NAME" bitnami/"$APP_NAME" --namespace "$AKEYLESS_NAMESPACE"

```

##
Helm Output
```
PostgreSQL can be accessed via port 5432 on the following DNS names from within your cluster:

    postgresql.waynez.svc.cluster.local - Read/Write connection

To get the password for "postgres" run:

    export POSTGRES_ADMIN_PASSWORD=$(kubectl get secret --namespace waynez postgresql -o jsonpath="{.data.postgres-password}" | base64 -d)

To get the password for "postgresadmin" run:

    export POSTGRES_PASSWORD=$(kubectl get secret --namespace waynez postgresql -o jsonpath="{.data.password}" | base64 -d)

To connect to your database run the following command:

    kubectl run postgresql-client --rm --tty -i --restart='Never' --namespace waynez --image docker.io/bitnami/postgresql:17.3.0-debian-12-r1 --env="PGPASSWORD=$POSTGRES_PASSWORD" \
      --command -- psql --host postgresql -U postgresadmin -d test -p 5432

    > NOTE: If you access the container using bash, make sure that you execute "/opt/bitnami/scripts/postgresql/entrypoint.sh /bin/bash" in order to avoid the error "psql: local user with ID 1001} does not exist"

To connect to your database from outside the cluster execute the following commands:

  NOTE: It may take a few minutes for the LoadBalancer IP to be available.
        Watch the status with: 'kubectl get svc --namespace waynez -w postgresql'

    SERVICE_IP=$(kubectl get svc --namespace waynez postgresql -o jsonpath='{.status.loadBalancer.
ingress[0].ip}')

    kubectl run postgresql-client --rm --tty -i --restart='Never' --namespace waynez \
       --image docker.io/bitnami/postgresql:17.3.0-debian-12-r1 --env="PGPASSWORD=$POSTGRES_PASSWORD" \
       --command -- psql --host $SERVICE_IP -U postgres -d test -p 5432
```