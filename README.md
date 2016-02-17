# Laboration 1, Webbramverk
Lisa Westlund, lw222gu

## Körinstruktioner
Applikationen körs via [Cloud9](https://dv450-lw222gu-lw222gu.c9users.io).
Vill du testa den lokalt, kör följande i terminalen:

1. cd apiKeyRegistration
2. bundle install
2. rake db:migrate
3. rake db:seed
4. rails server (eller rails s -b $IP -p $PORT via Cloud9:s terminal)


## Inloggningsuppgifter
Efter att du kört db:seed, eller om du hellre testar via Cloud9-länken finns nedanstående konton genererade:

1. Admin
   * Användarnamn: admin
   * Lösenord: pass123
2. En användare
   * Användarnamn: user
   * Lösenord: 123456

Du kan givetvis också skapa egna användarkonton, men inte adminkonton.
