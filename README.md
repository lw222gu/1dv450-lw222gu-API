# Laboration 2, Webbramverk, Linnaeus University
* Lisa Westlund, lw222gu
* [Commit history from Laboration 1](https://github.com/lw222gu/1dv450_lw222gu).

## Instructions
* Download, or fork and clone repository.
* Run:
  * `> vagrant up`
  * `> vagrant ssh` - if the terminal asks for a password it is `vagrant`
  * `$ bundle install`
  * `$ rake db:schema:load`
  * `$ rake db:seed`
  * `$ rails s -b 0.0.0.0`

## Existing user accounts
Test the application using the following accounts:

1. Admin
   * Username: `admin`
   * Password: `pass123`
2. Developer
   * Username: `developer`
   * Password: `123456`

You can create your own user accounts (resource owner and developer).

---
Many thanks to [Oskar](https://github.com/OskarKlintrot) for contributing with a working vagrant setup.
