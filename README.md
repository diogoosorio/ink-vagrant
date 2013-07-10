#Ink-Vagrant

A quick'n'dirty development environment for Sapo's [Ink][1] / [Ink.js][2] projects.

##Getting Started

Its really simple to get started, just do the following:

    git clone git@github.com:diogoosorio/ink-vagrant.git
    vagrant up

Additionally add the following entry to your hosts file:

    192.168.50.8    ink.local ink.js.local

You'll have a machine with both repositories cloned and with Apache up and running.

##Customization

Open up the [manifests/default.pp][3]. The ink module receives three optional arguments:

    class {'ink':
        $ink_repository => 'git@github.com:sapo/Ink.git',
        $ink_js_repository => 'git@github.com:sapo/Ink.js.git',
        $user => 'vagrant'
    }

They are pretty self-explanatory. :)


  [1]: https://github.com/sapo/Ink
  [2]: https://github.com/sapo/Ink.js
  [3]: https://github.com/diogoosorio/ink-vagrant/blob/master/manifests/default.pp
