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
      - CASSANDRA_URL=cassandra:9042
      - CASSANDRA_HOST=cassandra
      - CASSANDRA_PORT=9042
      - POSTGRES_HOST=postgres
      - POSTGRES_PORT=5432
      - ADD_SCHEMA_AND_SYSTEM_DATA=${add_schema_and_system_data}
      - ADD_DEMO_DATA=${add_demo_data}
    volumes:
      - hsqldb_data_dir:/usr/share/thingsboard/data/sql
    depends_on:
      {{- if eq .Values.database_type "cassandra" }}
      - cassandra
      {{- else }}
      - postgres
      {{- end }} 
    external_links:
      - ${zookeeper_service}:zk    
    entrypoint: /run-application.sh
  {{- if eq .Values.database_type "cassandra" }}  
  cassandra:
    image: "cassandra:3"
    volumes:
      - cassandra_data_dir:/var/lib/cassandra
  {{- else }}   
  postgres:
    image: "postgres:9.6"
    environment:
      - POSTGRES_DB=${postgres_db}
    volumes:
      - postgres_data_dir:/var/lib/postgresql/data
  {{- end }}    
volumes:
  hsqldb_data_dir:
    driver: ${volume_driver}
  {{- if eq .Values.database_type "cassandra" }}  
  cassandra_data_dir:
    driver: ${volume_driver}
  {{- else }}  
  postgres_data_dir:
    driver: ${volume_driver}
  {{- end }}  