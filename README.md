<p align="center">
  <img src="screenshots/preview.png" alt="Termux Prompt Preview" width="700">
</p>

<h1 align="center">🚀 Termux Prompt Installer</h1>

<p align="center">
  <strong>Instalador automático de prompt personalizado para Termux</strong>
  <br>
  Banner ASCII + informações do sistema + frases hackers + PS1 customizado
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Shell-Zsh-brightgreen?style=flat&logo=gnu-bash">
  <img src="https://img.shields.io/badge/Plataforma-Termux-blue?style=flat&logo=android">
  <img src="https://img.shields.io/badge/Licença-MIT-green">
</p>

---

## 📦 Instalação

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/carlos46743/termux-prompt-installer/main/install.sh)"
```

---

## 🎨 Personalização

Durante a instalação você escolhe:

| Opção | Descrição |
|-------|-----------|
| **Nome do prompt** | Texto exibido no banner ASCII |
| **Cor do nome** | Cor do banner, bordas e destaque |
| **Cor dos textos** | Cor do caminho, seta e informações |

---

## ⚡ Funcionalidades

- **Banner FIGlet** — nome em ASCII art na abertura do terminal
- **Informações do sistema** — hostname, usuário, kernel, data, histórico
- **Frases hackers** — exibe frases aleatórias do arquivo `~/.frases_hacker`
- **PS2 moderno** — prompt de duas linhas com `┌──(user㉿host)-[path]` e `└─#`
- **Backup automático** — `~/.zshrc` original salvo como `~/.zshrc.bak`

---

## 🧩 Adicionar frases hackers

```bash
echo "root@192.168.0.1:~/ $ # access granted" >> ~/.frases_hacker
echo "Conexão estabelecida com servidor remoto" >> ~/.frases_hacker
echo "Tunnels: 3 ativos | Firewall bypassed" >> ~/.frases_hacker
```

---

## 📁 Estrutura

```
termux-prompt-installer/
├── install.sh
├── LICENSE
├── README.md
└── screenshots/
    └── preview.png
```

---

<p align="center">
  <sub>Feito com ❤️ para a comunidade Termux</sub>
</p>
