# Shellnux-v1

**Shellnux-v1** is a terminal-based Linux puzzle game inspired by [OverTheWire: Bandit](https://overthewire.org/wargames/bandit/).

It helps you learn Linux commands by solving fun, hands-on challenges — each level requires terminal skills to find a passkey that unlocks the next level.

---

## 🕹️ How to Play

1. Each level is a user account: `shellnux00`, `shellnux01`, `shellnux02`, etc.
2. Your goal: find the **passkey** hidden in the level and use it to log in to the next user.
3. You play by switching users using the `su` command.

---

### 🔑 Example Gameplay

```bash
su - shellnux00
# password: shellnux00

# Now you're inside the first level!
# Explore using Linux commands (ls, cat, find, grep, etc.)
# Find the password hidden somewhere
```

Once you find the password, use:

```bash
su - shellnux01
# password: (from previous level)
```

Repeat this process to advance through levels.

---

## 🛠️ Installation

### On Linux / WSL / Git Bash (with sudo):

```bash
git clone https://github.com/1ts-Gentleman/Shellnux-v1.git
cd Shellnux-v1
chmod +x install.sh
./install.sh
```

### ✅ Start the game:

```bash
su - shellnux00
# password: shellnux00
```

---

## 🧹 Uninstallation

To remove Shellnux-v1 and all users:

```bash
chmod +x uninstall.sh
./uninstall.sh
```

---

## 💡 Important Tip

> 📝 **Save each level's passkey in a Notepad or text file!**  
> If you forget it or close your terminal, you'll have to restart from **shellnux00**.

---

## 📦 Requirements

- Linux or WSL
- `bash` and `sudo` access (for setup)
- Basic knowledge of terminal commands

---

## 📚 Inspired By

- [OverTheWire: Bandit](https://overthewire.org/wargames/bandit/)
- Linux security and CTF-style learning

---

## 🧠 Future Plans

- More levels and harder puzzles
- Hints and walkthrough mode
- Score tracking

---

## 🛡️ License

This project is open-source. You may use and modify it freely.

---

## 🙌 Contributions

Want to create new levels or puzzles? Fork the repo and submit a pull request!

