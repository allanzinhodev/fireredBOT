# 🤖 Pokémon FireRed Bot

Este é um projeto de automação criado para jogar **Pokémon FireRed** de forma totalmente autônoma — **sem necessidade de qualquer intervenção humana**. O bot é capaz de explorar mapas, batalhar, capturar Pokémon e se adaptar a diferentes situações no jogo, tomando decisões estratégicas em tempo real.

---

## 🎮 O que este bot faz?

- **Joga Pokémon FireRed sozinho**, do início ao fim, sem comandos diretos do jogador.
- **Interage via chat da Twitch**: espectadores podem enviar comandos que alteram o comportamento do bot em tempo real (como modo de exploração, batalha ou captura).
- **Captura automaticamente Pokémon que ainda não foram obtidos**, expandindo a Pokédex de forma autônoma.
- **Batalha estrategicamente**, priorizando habilidades mais eficazes com base em um sistema de pontuação e contexto de batalha.
- **Utiliza pathfinding avançado** para movimentar-se pelos mapas, reconhecendo entradas, saídas e limites de território.
- **Gerencia o inventário e retorna ao Centro Pokémon** automaticamente quando necessário.

---

## 🧠 Como funciona?

O bot é alimentado por uma combinação de técnicas e estratégias:

- **Mapeamento detalhado de offsets de memória** do emulador (VBA-RR ou mGBA):
  - Localização do personagem
  - HP dos Pokémon
  - ID dos Pokémon selvagens
  - Estado do jogo (batalha, overworld, etc)
- **Sistema de pathfinding personalizado**, com análise de tiles para identificar caminhos possíveis, evitar colisões e navegar entre mapas.
- **Engine de priorização de habilidades**, que avalia os ataques disponíveis considerando fatores como:
  - Efetividade do tipo
  - Dano base
  - PP restante
- **Contextualização dinâmica**, com leitura contínua da memória para adaptar o comportamento do bot de acordo com o ambiente atual (cidade, rota, caverna, batalha, etc).
- **Comandos via Twitch chat**, que permitem aos espectadores influenciar decisões como capturar tudo, evitar lutas, correr riscos ou explorar novas rotas.

---

## 🧪 Estado do projeto

Este bot foi desenvolvido como um **desafio pessoal**, com o objetivo de criar um sistema autônomo completo que jogasse Pokémon FireRed de forma eficiente e inteligente.

> ✅ **Objetivo alcançado**: o bot funciona como esperado, executa tarefas complexas, toma decisões baseadas em contexto e interage com espectadores.

**❌ O projeto está finalizado e não receberá mais atualizações.**  
A proposta era alcançar um sistema funcional e autônomo, e isso foi atingido com sucesso.

---

## 📦 Tecnologias e ferramentas

- 🐍 **Python**
- 🖥️ **Emulador VBA-RR / mGBA**
- 🧠 **Memory reading e manipulação de offsets**
- 📡 **Integração com API da Twitch**
- 🧭 **Sistema de pathfinding**
- 🧿 (Opcional) **OpenCV** para reconhecimento de tela (visão computacional)

---


1. Clone o repositório:
   ```bash
   git clone https://github.com/allanzinhodev/fireredBOT.git
