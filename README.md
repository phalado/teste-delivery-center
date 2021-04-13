# Teste Delivery Center

Algumas considerações sobre este teste:

- Gostaria de trabalhar mais nesse projeto mas, no momento, não posso gastar mais tempo no mesmo. Com isso ficam alguns problemas que vejo no código e que poderiam ter uma atenção maior.

- Este projeto me parece ser um m micro serviço intermediário entre um serviço de venda e um de envio. Acho que seria interessante um graphql nele. Como para este teste foi usado rest tanto para receber os dados quanto para os enviar não utilizei a gerramenta.

- Não validei todas as colunas como obrigatórias pois, no começo, não tinha visto que todas do payload de retorno são obrigatórias.

- Algumas colunas recebidas pelo payload são inúteis (como "total com envio" que poderia simplesmente ser calculado). Por outro lado, me parece que falta dado, como o complemento no endereço.

- Algumas colunas poderiam ser enumeráveis(enums) mas seria necessário mais dados sobre as possibilidades de conteúdo das mesmas.

- Acabei não testando o método que envia o request e nem o separando da model de Order. Mais uma vez, é algo que eu gostaria de ter feito mas não posso passar muito mais tempo neste projeto.

- Encontrei uma forma melhor de fazer as serializações, mas além de ter que refazer uma boa parte do código eu teria que utilizar um classe inteira de outro repositório para este mesmo teste. Deixei desta forma pois programei cada linha mas, para um projeto para um cliente teria usado a outra classe.

- Have fun.