# CGROUPS V2

```
mkdir -p /etc/systemd/system/user-$(id -g username).slice.d
```

```
cat <<EOF > /etc/systemd/system/user-$(id -g username).slice.d/limits.conf
[Slice]
# Ограничение CPU до 30% одного ядра
CPUQuota=30%

# Мягкий предел оперативной памяти (допускается превышение)
MemoryHigh=256M

# Жёсткий предел оперативной памяти
MemoryMax=512M

# Приоритет I/O (1 = низкий, 10000 = высокий; default = 100)
IOWeight=100

# Ограничение на число процессов (включая потоки)
TasksMax=10
EOF
```

```
systemctl daemon-reload
```
