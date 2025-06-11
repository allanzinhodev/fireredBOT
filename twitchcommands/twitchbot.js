const tmi = require('tmi.js');
const fs = require('fs');

// CONFIGURAÇÕES DO BOT
const client = new tmi.Client({
  identity: {
    username: '',
    password: ''
  },
  channels: ['allaorodrigues']
});

client.connect();

client.on('message', (channel, tags, message, self) => {
    if (self) return;
  
    // Comando personalizado
    if (message.startsWith('!walk ')) {
      const texto = message.replace('!walk ', '');
  
      // Substitui o conteúdo do arquivo com o novo texto
      fs.writeFile('../walkmode.txt', `${texto}\n`, err => {
        if (err) {
          console.error('Erro ao salvar:', err);
        } else {
          console.log(`Conteúdo substituído: ${texto}`);
        }
      });
    }
  });
