# vagrant-centos-lamp

A super-simple Vagrantfile to setup a LAMP stack inside Vagrant 100% automatically.

Requirements
-----------

* Virtualbox
* Vagrant >= 1.7.0

Installation:
-------------

Download and install [VirtualBox](http://www.virtualbox.org/)

Download and install [vagrant](http://vagrantup.com/)

Clone this repository

Go to the repository folder and launch the box

    $ cd [repo]
    $ vagrant up


What's inside:
--------------

Installed software:

* Centos 7.4 (boxes built using templates from the [Bento project](https://app.vagrantup.com/bento/boxes/centos-7.4))
* PHP 7.1
* MySQL Community Server 5.7
* Apache
* Xdebug
* Composer
* PhpMyAdmin 4.5.4.1
* Git

Notes
-----


### Accessing your hosts via your local web browser

In order to access vagrant hosts via your local browser you will need to edit your hosts file (`/private/etc/hosts` in Macs, `c:\Windows\System32\Drivers\etc\hosts` in Windows, `/etc/hosts` in Linux).
All hosts should be mapped to `192.168.33.10`:

    192.168.33.10 local.dev someyourotherhost.dev

### MySQL

Logging in can be done with username=root, password=mySQL@123

### phpMyAdmin

phpMyAdmin is available on every domain. For example:

    http://local.dev/phpmyadmin

### Composer

Composer binary is installed globally (to `/usr/local/bin`), so you can simply call `composer` from any directory.