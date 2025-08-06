# Errors Encountered and Solutions

This document lists common errors encountered during Patroni AutoFailover setup and their respective solutions.

---

## Error 1: Address Already in Use

![psql error](./images/psql-error.png)

```
could not bind IPv4 address "0.0.0.0": Address already in use
FATAL:  could not create any TCP/IP sockets
```

**Solution:**

Stop any running PostgreSQL service, re-execute the systemd manager, and restart Patroni:

```sh
sudo systemctl stop postgresql
sudo systemctl daemon-reexec
sudo systemctl restart patroni
sudo systemctl status patroni
sudo systemctl start postgresql
```

---

## Error 2: `initdb` Not Found

![initdb error](./images/initdb-error.png)

```
FileNotFoundError: [Errno 2] No such file or directory: 'initdb'
```

**Solution:**

1. Find the PostgreSQL binaries directory:

    ```sh
    pg_config --bindir
    ```

2. Add the output path to your Patroni YAML configuration:

    ```yaml
    data_dir: /var/lib/postgresql/data
    bin_dir: /usr/lib/postgresql/16/bin
    ```

---

## Error 3: Etcd API Version Mismatch

![etcd apiversion error](./images/etcd-apiversion-error.png)

```
ERROR: Failed to get list of machines from http://x.x.x.x:2379/v2: EtcdException('Bad response : 404 page not found\n')
```

**Solution:**

Ensure the etcd API version matches the version expected by Patroni.

---

## Error 4: Patroni Cannot Find Suitable Distributed Configuration Store

![patroni etcd error](./images/patroni-etcd-error.png)

```
patroni.exceptions.PatroniFatalException: Can not find suitable configuration of distributed configuration store
patroni[1111856]: Available implementations: consul, kubernetes
```

**Solution:**

1. Remove any incompatible etcd Python packages and install the correct ones:

    ```sh
    sudo pip uninstall python-etcd
    pip install etcd3
    sudo pip install etcd3gw
    pip list | grep etcd
    ```

2. Reinstall Patroni with etcd support:

    ```sh
    pip uninstall patroni
    sudo pip uninstall patroni
    pip install patroni[etcd]
    sudo pip install patroni[etcd]
    ```

> **Note:** Installing with `[etcd]` ensures Patroni has etcd3gw support.

---

## Error 5: PostgreSQL Verion conflict with ubuntu release version

```sh
$ sudo apt dist-upgrade -y
Reading package lists... Done
Building dependency tree       
Reading state information... Done
Calculating upgrade... Done
The following security updates require Ubuntu Pro with 'esm-infra' enabled:
  cloud-init linux-headers-generic linux-libc-dev libpython3.8-dev
  libblockdev-swap2 libpython3.8-minimal git-man libsystemd0
  linux-image-generic libsqlite3-0 python3-urllib3 sudo libpython3.8 python3.8
  git libblockdev-crypto2 udev libblockdev-loop2 libblockdev-fs2
  libblockdev-part2 python3-requests libudev1 libsoup2.4-1 systemd-timesyncd
  udisks2 python3.8-minimal systemd-sysv libblockdev2 libpam-systemd systemd
  libblockdev-utils2 libnss-systemd libblockdev-part-err2 libpython3.8-stdlib
  libudisks2-0 python3.8-dev linux-generic libxslt1.1
Learn more about Ubuntu Pro at https://ubuntu.com/pro
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded
```

**Solution:**

1.  Make sure the update-manager-core is installed:

    ```sh
    sudo apt install update-manager-core -y
    ```

2. Ensure this file says "Prompt=lts":

    ```sh
    sudo nano /etc/update-manager/release-upgrades
    ```
3. Run the release upgrade:

    ```sh
    sudo do-release-upgrade
    ```
4. After reboot verify ubuntu version:

    ```sh
    lsb_release -a
    ```
