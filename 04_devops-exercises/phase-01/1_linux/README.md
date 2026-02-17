# Phase 01 – Linux Basics (Operating Systems & Bash)

This directory contains my solutions for the Linux exercises from Nana’s DevOps Bootcamp.

Tested Environment:

- Ubuntu (DigitalOcean Droplet)
- Non-root user with sudo privileges
- Bash shell

---

# 📁 Project Structure

```
04_devops-exercises/
  phase-01/
    1_linux/
      README.md
      scripts/
      evidence/
```

- `scripts/` → Bash scripts for exercises 2–9  
- `evidence/` → Output files proving successful execution  
- `README.md` → Instructions to run all exercises  

---

# 🚀 How To Run These Exercises

## 1️⃣ Clone the Repository

```bash
git clone git@gitlab.com:younghadiz/devops-and-cloud-projects-lab.git
cd devops-and-cloud-projects-lab/04_devops-exercises/phase-01/1_linux
```

---

## 2️⃣ Make All Scripts Executable

```bash
chmod +x scripts/*.sh
```

---

# 🧪 Exercise Execution Guide

---

## 🔹 Exercise 1 – Linux System Information

Run the following commands:

```bash
cat /etc/os-release
command -v apt
command -v apt-get
command -v yum
command -v dnf
echo $SHELL
getent passwd "$USER" | cut -d: -f7
update-alternatives --display editor 2>/dev/null
```

---

## 🔹 Exercise 2 – Install Java (>= 11)

```bash
./scripts/ex2-install-java.sh
```

Expected Result:
- Displays detected Java version
- Confirms version is 11 or higher

---

## 🔹 Exercise 3 – List Current User Processes

```bash
./scripts/ex3-user-processes.sh
```

---

## 🔹 Exercise 4 – Sort Processes by CPU or MEM

```bash
./scripts/ex4-user-processes-sorted.sh
```

When prompted, enter:

```
cpu
```

or

```
mem
```

---

## 🔹 Exercise 5 – Sort + Limit Number of Processes

```bash
./scripts/ex5-user-processes-sorted-limit.sh
```

Example input:

```
cpu
5
```

---

# 🌐 Node Application Section (Exercises 6–9)

---

## 🔹 Exercise 6 – Install Node & Run App in Background

```bash
./scripts/ex6-start-node-app.sh
```

Verify application is running:

```bash
ps aux | grep "node server.js" | grep -v grep
```

Check application log:

```bash
tail -n 50 package/node-app.out
```

---

## 🔹 Exercise 7 – Check Application Status (PID + Port)

```bash
./scripts/ex7-start-node-app-check-status.sh
```

If port detection does not display automatically:

```bash
ss -ltnp | grep node
```

---

## 🔹 Exercise 8 – Run Application with LOG_DIR Parameter

```bash
./scripts/ex8-start-node-app-with-logdir.sh logs
```

Verify logs directory:

```bash
ls -la logs
cat logs/app.log 2>/dev/null
```

---

## 🔹 Exercise 9 – Run Application as Service User `myapp`

```bash
sudo ./scripts/ex9-start-node-app-service-user.sh logs
```

Verify it is running under `myapp`:

```bash
pgrep -u myapp -f "node server.js"
ps -u myapp -f
```

---

# 📁 Evidence Files

Execution outputs are saved in:

```
evidence/
```

To generate evidence automatically for all exercises:

```bash
mkdir -p evidence

printf "cpu\n" | ./scripts/ex4-user-processes-sorted.sh | tee evidence/ex4-cpu.txt
printf "mem\n" | ./scripts/ex4-user-processes-sorted.sh | tee evidence/ex4-mem.txt
printf "cpu\n5\n" | ./scripts/ex5-user-processes-sorted-limit.sh | tee evidence/ex5-top5-cpu.txt
printf "mem\n5\n" | ./scripts/ex5-user-processes-sorted-limit.sh | tee evidence/ex5-top5-mem.txt
```

---

# 🛡 Notes

- Always use a non-root user with sudo privileges.
- Node app runs in background using `nohup`.
- Service user `myapp` is created in Exercise 9.
- Logs are written to `node-app.out` or LOG_DIR.

---


