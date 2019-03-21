# Keycloak Cluster based on Docker + JDBC_PING

Note: this demonstrates issues creating session on keycloak cluster

## Start the cluster

    docker-compose -f docker-compose.yml -f docker-compose.ports.yml up

## Create session on cluster (fails)

    open http://localhost:8000/auth/realms/example/account
    
    # Username `user`
    # Password `password`

    # => fails with the following error on the UI:
    # 1st try (or cleared cookies) => "An error occurred, please login again through your application."
    # 2nd try (with existing cookies) => "You are already logged in."

## Create session on single node

    open http://localhost:8081/auth/realms/example/account

    # Username `user`
    # Password `password`

    # => works, the "Edit Account" view is shown

## Resources

- https://www.keycloak.org/docs/latest/server_installation/index.html#_clustering