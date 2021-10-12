output "arquivo_saida_user1" {
  value = "Arquivo result-${module.user1.username}.txt criado com sucesso."
}

output "arquivo_saida_user2" {
  value = "Arquivo result-${module.user2.username}.txt criado com sucesso."
}
