# Stl-ldap

## Sobre

Esse cookbook foi feito para centralizarmos as propriedades de conexao do ldap do tabajara.corp

---

### Como usar

No arquivo metadata.rb do cookbook da sua aplicaçao, insira:

```
depends "stl-ldap"
```

E em sua receita inclua o cookbook **stl-ldap**
```
include_recipe 'stl-ldap'
```

Lembre se alterar o atributo **default['stl']['ldap']['groupsearchbase']** para a OU de seu SEU_PROJETO
Para isso vode pode inserir na sua receita:

```
node.default['stl']['ldap']['groupsearchbase'] = 'OU=**ALTERE_AQUI**,OU=Acesso_Sistemas,OU=Grupos,DC=tabajara,DC=corp'
```
