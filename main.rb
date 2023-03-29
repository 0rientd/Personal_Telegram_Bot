# frozen_string_literal: true

require 'rubygems'
require 'telegram/bot'

token = File.read('token.txt').strip

Telegram::Bot::Client.run(token) do |bot|
	puts 'Bot iniciado com sucesso!'
	puts 'Aguardando mensagens...'
	puts "Mensagem recebida: #{message.text}" if message.text?

  bot.listen do |message|
		case message.text
		when '/start'
			# See more: https://core.telegram.org/bots/api#replykeyboardmarkup
			opcoes =
					Telegram::Bot::Types::ReplyKeyboardMarkup.new(
						keyboard: [
							[{ text: 'Quero entrar em contato.' }, { text: 'Quem é o 0rientd?' }],
							[{ text: 'Quais projetos ele já fez?' }, { text: 'Nada mais. Obrigado!' }]
						],
						one_time_keyboard: false
					)
			bot.api.send_message(chat_id: message.chat.id, text: "Olá! Seja bem vindo. Eu sou o bot do 0rientd. Como posso te ajudar?", reply_markup: opcoes)

		when 'Quero entrar em contato.'
			mensagem = 'Que bom! Você pode entrar em contato pelo seguinte email: carlos.henrique@0rientd.dev.br'

			bot.api.send_message(chat_id: message.chat.id, text: mensagem)

		when 'Quem é o 0rientd?'
			mensagem = "O 0rientd é um desenvolvedor de software que está sempre em busca de novos conhecimentos. Ele é apaixonado por tecnologia e por ajudar as pessoas a alcançarem seus objetivos. Atualmente ele trabalha criando ferramentas web para maximizar e automatizar rotinas e hoje em dia, ele se dedica ao desenvolvimento de aplicações web com Ruby on Rails."
		
			bot.api.send_message(chat_id: message.chat.id, text: mensagem)
		
		when 'Quais projetos ele já fez?'
			mensagem1 = 'Alguns projetos são de código privado e outros são de código aberto. Você pode ver alguns deles no GitHub: https://github.com/0rientd'
			mensagem2 = 'Um projeto feito recentemente foi o 0rientd Bot. Ele é um bot de Telegram que eu criei para ajudar as pessoas a conhecerem um pouco mais sobre mim.'
			mensagem3 = 'Há um projeto em andamento que é um bot para Telegram onde um web scrapper coleta informações do site da Nintendo, XBox e PlayStation e envia para o usuário. O projeto encontra-se já em produção e você pode ver neste link: https://t.me/promobytenintendo'

			bot.api.send_message(chat_id: message.chat.id, text: mensagem1)
			bot.api.send_message(chat_id: message.chat.id, text: mensagem2)
			bot.api.send_message(chat_id: message.chat.id, text: mensagem3)

		when '/stop' || 'Nada mais. Obrigado!'
			# See more: https://core.telegram.org/bots/api#replykeyboardremove
			kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)

			bot.api.send_message(chat_id: message.chat.id, text: 'Tudo bem. Foi bom ter você por aqui!', reply_markup: kb)

		else
			bot.api.send_message(chat_id: message.chat.id, text: 'Desculpe, não entendi o que você quis dizer.')
			bot.api.send_message(chat_id: message.chat.id, text: 'Acesse o menu e escolha uma das opções.')

		end
	end
end