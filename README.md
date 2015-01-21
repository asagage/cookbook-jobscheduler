JobScheduler Cookbook
=====================

Chef to install The [SOS JobScheduler](http://www.sos-berlin.com/modules/cjaycontent/).

* JobScheduler: 5.3.0
* Nginx: 1.1.19
* PostgreSQL: ... Not implemented yet
* MySQL: 5.5.31

## Requirements

* [Berkshelf](http://berkshelf.com/)
* [Vagrant](http://www.vagrantup.com/)

### Vagrant Plugin

* [vagrant-berkshelf](https://github.com/RiotGames/vagrant-berkshelf)
* [vagrant-aws](https://github.com/mitchellh/vagrant-aws)


### Platform:

* Ubuntu (12.04, 12.10)
* CentOS 6.5


## Attributes

* User
* Source
* Database
* Server


## Installation

### Vagrant

#### VirtualBox 

```bash
$ gem install berkshelf
$ vagrant plugin install vagrant-berkshelf
$ git clone git://github.com/ogom/cookbook-jobscheduler ./jobscheduler
$ cd ./jobscheduler/
$ vi ./Vagrantfile 
$ vagrant up
$ vagrant ssh
vagrant$ curl -L https://www.opscode.com/chef/install.sh | sudo bash
vagrant$ exit
$ vagrant provision
```

#### Amazon Web Services

```bash
$ gem install berkshelf
$ vagrant plugin install vagrant-berkshelf
$ vagrant plugin install vagrant-aws
$ vagrant box add dummy https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box
$ git clone git://github.com/ogom/cookbook-jobscheduler ./jobscheduler
$ cd ./jobscheduler/
$ cp ./example/Vagrantfile_aws ./Vagrantfile
$ vi ./Vagrantfile
$ vagrant up --provider=aws
$ vagrant ssh
vagrant$ curl -L https://www.opscode.com/chef/install.sh | sudo bash
vagrant$ exit
$ vagrant ssh-config | awk '/HostName/ {print $2}'
$ vi ./Vagrantfile
$ vagrant provision
```

### knife-solo

```bash
$ gem install berkshelf
$ gem install knife-solo
$ knife configure
$ knife solo init ./chef-repo
$ cd ./chef-repo/
$ echo 'cookbook "jobscheduler", github: "ogom/cookbook-jobscheduler"' >> ./Berksfile
$ berks install --path ./cookbooks
$ knife solo prepare vagrant@127.0.0.1 -p 2222 -i ~/.vagrant.d/insecure_private_key
$ vi ./nodes/127.0.0.1.json
$ knife solo cook vagrant@127.0.0.1 -p 2222 -i ~/.vagrant.d/insecure_private_key --no-chef-check
```


## Usage

Example of node config.

```json
{
  "mysql": {
    "server_root_password": "rootpass",
    "server_debian_password": "debpass",
    "server_repl_password": "replpass"
  },
  "jobscheduler": {
    "database_password": "datapass"
  },
  "run_list":[
    "jobscheduler::initial",
    "jobscheduler::install"
  ]
}
```

## Done!

`http://localhost:8080/` or your server for `JobScheduler Operations Center`.


## Links

* [jobscheduler Installation](http://www.sos-berlin.com/doc/en/scheduler_installation.pdf)


## License 

* MIT
