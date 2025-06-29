# Script `remove-orfaos.sh`

### Obs
---
Pode ocorrer de remover um pacote que a pessoa usava, por exemplo o okular
Isso ocorre por que o pacote na verdade foi instalado como dependência e ficou órfão
Basta instalar explicitamente o pacote usando o `sudo pacman -S`

PS: Eu fui removendo todos os pacotes órfãos e alguns eu instalei explicitamente, usando o script dessa forma não houve quebra do sistema.


---

Usa o `pacman` para remover os **pacotes órfãos** usando o comando:

```bash
pacman -Qdt
````

Esse comando lista os pacotes **instalados como dependência** (`-Qd`) que **não são mais necessários por nenhum outro pacote** (`-t` de "unrequired").

---

1. Quando você instala um pacote com `pacman -S`, ele é marcado como **explicitamente instalado**.
2. Quando outro pacote é instalado como **dependência**, ele é marcado como **instalado como dependência**.
3. Se nenhum pacote **depende mais** de uma dependência instalada, ela **vira órfã**.


#### ✅ Pode confiar se:

* Você **nunca instala bibliotecas manualmente** (ex: `pacman -S libfoo` só porque quer).
* O sistema foi mantido de forma limpa, sem alterações manuais nos flags de instalação (`explicit` vs `dependency`).

#### ⚠️ Tome cuidado se:

* Você instalou algum **pacote como dependência** manualmente (por exemplo, `pacman -S ffmpeg-libs`), e ele agora aparece como órfão.
* Alguns pacotes são **usados por scripts ou softwares externos** que não são empacotados com dependências explícitas no `pacman`.

---

### 💡 Como verificar se um pacote tem dependentes?

Antes de remover um pacote órfão, você pode verificar com:

```bash
pactree -r <pacote>
```

Isso mostra **quem depende** daquele pacote. Se não retornar nada, ele é um candidato real à remoção.

Exemplo:

```bash
pactree -r libxcrypt
```


### Changelog

2025-06-29 - O script faz uma checagem adicional com o pactree, usar o -Rns para ver os pacotes com outras dependências e para avaliar se irá instalar explicitamente.



