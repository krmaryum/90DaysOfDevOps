# Ansible Quick Commands Reference (Day 68 → Day 72)

| Day | Topic | Command | Purpose |
| --- | ----- | ------- | ------- |
| 68 | Verify Ansible Installation | `ansible --version` | Check installed Ansible version |
| 68 | Ping All Hosts | `ansible all -m ping` | Test SSH connectivity |
| 68 | Ping Specific Group | `ansible web -m ping` | Test specific inventory group |
| 68 | Inventory View | `ansible-inventory --list` | Show parsed inventory |
| 68 | Ad-hoc Command | `ansible all -a "hostname"` | Run command on all hosts |
| 68 | Use Become | `ansible all -b -a "whoami"` | Run command with sudo |
| 68 | Install Package | `ansible all -b -m package -a "name=git state=present"` | Install package |
| 68 | Copy File | `ansible all -m copy -a "src=test.txt dest=/tmp/test.txt"` | Copy file to remote host |
| 68 | Gather Facts | `ansible all -m setup` | Collect system information |
| 68 | Filter Facts | `ansible all -m setup -a "filter=ansible_os_family"` | Show selected facts |
| 68 | Inventory Pattern | `ansible web:&prod -m ping` | Match multiple inventory patterns |
| 69 | Run Playbook | `ansible-playbook site.yml` | Execute playbook |
| 69 | Dry Run | `ansible-playbook site.yml --check` | Preview changes |
| 69 | Show Differences | `ansible-playbook site.yml --diff` | Show config differences |
| 69 | Verbose Output | `ansible-playbook site.yml -vvv` | Debug execution |
| 69 | Syntax Check | `ansible-playbook site.yml --syntax-check` | Validate YAML syntax |
| 69 | Limit Hosts | `ansible-playbook site.yml --limit web` | Run only on selected hosts |
| 69 | Run Specific Task | `ansible-playbook site.yml --start-at-task="Install nginx"` | Resume from task |
| 69 | List Tasks | `ansible-playbook site.yml --list-tasks` | Show playbook tasks |
| 69 | List Hosts | `ansible-playbook site.yml --list-hosts` | Show targeted hosts |
| 70 | Extra Variables | `ansible-playbook site.yml -e "app_port=8080"` | Override variables |
| 70 | Multiple Extra Vars | `ansible-playbook site.yml -e "app_name=myapp app_port=9090"` | Override multiple variables |
| 70 | Debug Variable | `ansible all -m debug -a "var=inventory_hostname"` | Print variable |
| 70 | Check Facts | `ansible all -m setup -a "filter=ansible_distribution*"` | Show OS details |
| 70 | Run Conditional Playbook | `ansible-playbook site.yml` | Execute dynamic tasks |
| 70 | Loop Example | `loop:` inside playbook | Repeat tasks |
| 71 | Create Role | `ansible-galaxy init roles/webserver` | Generate role skeleton |
| 71 | Install Galaxy Role | `ansible-galaxy install geerlingguy.docker` | Install community role |
| 71 | Install Collection | `ansible-galaxy collection install community.docker` | Install collection |
| 71 | Encrypt Vault File | `ansible-vault create secrets.yml` | Create encrypted file |
| 71 | Edit Vault File | `ansible-vault edit secrets.yml` | Edit encrypted file |
| 71 | View Vault File | `ansible-vault view secrets.yml` | Read encrypted file |
| 71 | Encrypt Existing File | `ansible-vault encrypt secrets.yml` | Encrypt plaintext file |
| 71 | Decrypt File | `ansible-vault decrypt secrets.yml` | Decrypt vault file |
| 71 | Run with Vault | `ansible-playbook site.yml --ask-vault-pass` | Use vault password |
| 72 | Run Master Playbook | `ansible-playbook site.yml` | Full deployment |
| 72 | Sequential Deployment | `ansible-playbook site.yml -f 1` | Run playbook one host at a time for safer controlled deployment and easier debugging |
| 72 | Dry Run Deployment | `ansible-playbook site.yml --check --diff` | Safe deployment preview |
| 72 | Run Docker Role Only | `ansible-playbook site.yml --tags docker` | Execute only Docker tasks |
| 72 | Run Nginx Role Only | `ansible-playbook site.yml --tags nginx` | Execute only Nginx tasks |
| 72 | Skip Common Tasks | `ansible-playbook site.yml --skip-tags common` | Skip selected tasks |
| 72 | Deploy Different App | `ansible-playbook site.yml --tags docker -e "docker_app_image=httpd docker_app_tag=latest docker_app_name=apache-app"` | Deploy a different container image |
| 72 | Verify Docker Containers | `ansible web -m command -a "docker ps" --become` | Check running containers |
| 72 | Verify Nginx | `ansible web -m uri -a "url=http://localhost status_code=200"` | Verify Nginx reverse proxy response |
| 72 | Verify Container | `ansible web -m uri -a "url=http://localhost:8080 status_code=200"` | Check container directly |
| 72 | Test Nginx Config | `ansible web -m command -a "nginx -t" --become` | Validate Nginx config on managed host |
| 72 | Destroy Infrastructure | `terraform destroy` | Clean up cloud resources |
