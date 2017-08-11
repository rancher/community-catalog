version: '2'
services:
  tb:
    image: "thingsboard/application:1.2.4"
    ports:
      - "${http_public_port}:8080"
      - "${mqtt_public_port}:1883"
      - "${coap_public_port}:5683/udp"
    environment:
      - MQTT_BIND_ADDRESS=0.0.0.0
      - MQTT_BIND_PORT=1883
      - COAP_BIND_ADDRESS=0.0.0.0
      - COAP_BIND_PORT=5683
      - ZOOKEEPER_URL=zk:2181
      - DATABASE_TYPE=${database_type}
      {{- if eq .Values.database_type "cassandra" }}
      - CASSANDRA_URL=db:9042
      - CASSANDRA_HOST=db
      - CASSANDRA_PORT=9042
      {{- else }}
      - POSTGRES_HOST=db
      - POSTGRES_PORT=5432
      {{- end }}
      - ADD_SCHEMA_AND_SYSTEM_DATA=${add_schema_and_system_data}
      - ADD_DEMO_DATA=${add_demo_data}
    volumes:
      - hsqldb_data_dir:/usr/share/thingsboard/data/sql
    links:
      - db:db
    external_links:
      - ${zookeeper_service}:zk    
    entrypoint: /run-application.sh
  db:  
    {{- if eq .Values.database_type "cassandra" }}  
    image: "cassandra:3"
    volumes:
      - db_data_dir:/var/lib/cassandra
    {{- else }}   
    image: "postgres:9.6"
    environment:
      - POSTGRES_DB=${postgres_db}
    volumes:
      - db_data_dir:/var/lib/postgresql/data
    {{- end }}    
volumes:
  hsqldb_data_dir:
    driver: ${volume_driver}
  db_data_dir:
    driver: ${volume_driver}