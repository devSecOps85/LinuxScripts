# 🐧 LinuxScripts

**LinuxScripts** é um repositório pessoal que reúne diversos scripts úteis para sistemas baseados em Linux, com foco em automação, manutenção, segurança e administração de sistemas.

Este projeto visa compartilhar ferramentas que utilizo em meu dia a dia como auditor de TI na área de infraestrutura e segurança, com foco especial em distribuições como Arch Linux, Debian, Red Hat e derivados.

---

## 📂 Sobre

Neste repositório você encontrará:

- Scripts de limpeza e manutenção do sistema
- Utilitários para administração de pacotes
- Automatizações simples para tarefas do terminal
- Ferramentas para análise de rede e segurança
- Scripts para backup e organização de arquivos


---

## 📜 Scripts disponíveis

| Script              | Descrição                                                                 |
|---------------------|---------------------------------------------------------------------------|
| `remove-orfaos.sh`  | Script interativo para remoção segura de pacotes órfãos no Arch Linux     |
| *(em breve)*        | Scripts de backup, hardening, redes e segurança                           |

---

## 📦 Requisitos

A maioria dos scripts depende apenas de ferramentas comuns disponíveis nos repositórios padrões das distribuições. Dependências específicas são mencionadas no início de cada script.

---

## 🚀 Como usar

### 1. Clone o repositório

```bash
git clone git@github.com:devSecOps85/LinuxScripts.git
cd LinuxScripts
```

# Script `remove-orfaos.sh`

O `pacman` **pacotes órfãos** usando o comando:

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

Se nada depender, é seguro remover (teoricamente).

---

### ✅ Dica final

Para listar e confirmar *antes de remover*, use:

```bash
pacman -Qdtq | while read pkg; do
  echo "----- $pkg -----"
  pactree -r "$pkg"
done
```



