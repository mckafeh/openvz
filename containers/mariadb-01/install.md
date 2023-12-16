Setting up a MariaDB Galera Cluster on CentOS 7

### Prerequisites:

1. **Install CentOS 7:**
   Ensure that you have CentOS 7 installed on all the nodes that will be part of the Galera Cluster.

2. **Network Configuration:**
   Make sure that all nodes can communicate with each other over the network. Disable SELinux or configure it to allow the necessary ports.

3. **Firewall Configuration:**
   Open the necessary ports on the firewall. Galera Cluster uses ports 3306 for MySQL traffic and 4567, 4568, and 4444 for Galera Cluster communication.

### Steps:

#### Step 1: Install MariaDB on all Nodes

```bash
sudo yum install mariadb-server galera
```

#### Step 2: Configure MariaDB on all Nodes

Edit the MariaDB configuration file `/etc/my.cnf.d/server.cnf` on all nodes. Adjust the following settings:

```ini
[mysqld]
bind-address=0.0.0.0
binlog_format=ROW
default-storage-engine=innodb
innodb_autoinc_lock_mode=2
innodb_flush_log_at_trx_commit=0
innodb_buffer_pool_size=256M
innodb_log_file_size=64M
innodb_flush_method=O_DIRECT

[galera]
wsrep_on=ON
wsrep_provider=/usr/lib64/galera/libgalera_smm.so
wsrep_cluster_name="my_cluster"
wsrep_cluster_address="gcomm://node1_ip,node2_ip,node3_ip"

# Node-specific settings
wsrep_node_address="this_node_ip"
wsrep_node_name="this_node_name"
```

Replace `node1_ip`, `node2_ip`, etc., with the actual IP addresses of your nodes. Adjust other settings as needed.

#### Step 3: Start MariaDB on all Nodes

```bash
sudo systemctl start mariadb
```

#### Step 4: Initialize the First Node

On one of the nodes, run the following command to initialize the cluster:

```bash
sudo galera_new_cluster
```

#### Step 5: Start MariaDB on the Remaining Nodes

On the other nodes, start MariaDB:

```bash
sudo systemctl start mariadb
```

#### Step 6: Verify Cluster Status

Check the status of the Galera Cluster on any node:

```bash
mysql -u root -p -e "SHOW STATUS LIKE 'wsrep_cluster_size';"
```

This should return the number of nodes in the cluster.

### Additional Considerations:

- **Security:**
  - Set a secure password for the MariaDB root user.
  - Consider implementing a firewall to restrict access to the MySQL and Galera Cluster ports.

- **Monitoring:**
  - Implement monitoring tools like `Galera Cluster Control` or `MaxScale` for better cluster management.

- **Backup:**
  - Regularly backup your MariaDB databases to prevent data loss.

This guide provides a basic setup. Depending on your requirements, you might need additional configurations. Refer to the MariaDB and Galera Cluster documentation for more details: [MariaDB Galera Cluster Documentation](https://mariadb.com/kb/en/mariadb-galera-cluster/).