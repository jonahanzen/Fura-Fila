# Este projeto foi criado para o Bootcamp Java Fullstack @ENTRA21

Ao todo, a equipe era composta de três pessoas, Eu, [Fernando Delgado Bautista](https://www.linkedin.com/in/fernando-delgado-bautista/) e [Adriana Leal de França](https://www.linkedin.com/in/adriana-leal-de-fran%C3%A7a-764b3947/).

O link da apresentação deste trabalho está disponível aqui : [Youtube](https://www.youtube.com/watch?v=G3kiNFONe8w).

Resumidamente, o sistema lida com estoque, camadas de acesso, e consome uma API de pagamentos. A ideia era tirar a parte burocrática de quando, por exemplo vamos ao cinema e enfrentamos fila para comprar uma pipoca ou algo do gênero. Neste sistema o cliente apenas escolheria o seu produto, e ao pagar o funcionário já seria notificado, de forma que o cliente não enfrentaria filas e poderia facilmente assistir a algum filme, etc. Vulgo então o nome "Fura Fila".

### Dependências do projeto :
- Apache Tomcat 8.5 (em versões mais recentes, os pacotes alteram de javax para jakarta, o projeto deve rodar nas versões anteriores com javax.)

- Java 1.8 / 16 ( Não foi utilizado métodos mais complexos específicos de alguma versão, o projeto não apresentou problemas nas duas versões citadas ,e deve rodar tranquilamente em outras versões também.

- PostgreSQL
- O sistema de pagamentos funciona pelo GerenciaNet, então devido a esta natureza, é necessário possuir uma conta lá, e uma vez possuindo uma conta, habilitar a API de pagamento Pix.


### Instruções para rodar o projeto :

- Duas classes precisam ser alteradas, são elas: metodopix.CriarCobranca e metodopix.Autenticar. Nestas duas classes é necessário referenciar o client_id, client_secret, bem como nome e caminho do certificado .p12, para que assim, o sistema possa realizar os pagamentos. Estas informações são encontradas no GerenciaNet.

- Dentro do tomcat, na pasta conf/server.xml o certificado deve ser referenciado também.  Para isso, você pode seguir as instruções da Oracle para uso de certificados no Tomcat : [Instruções](https://docs.oracle.com/cd/E29585_01/PlatformServices.61x/security/src/tsec_ssl_jsp_pkcs12.html). Observação adicional: Caso haja algum problema com o certificado, ajuste a senha para "changeit". No momento de criação do projeto, o certificado veio sem senha, porém o mesmo funcionou apenas após eu mudar a senha para "changeit", encontrei algumas referências comentando que esta é uma senha "padrão", porém desconheço a causa original/oficial (visto o certificado não possuir senha).

- Visto o grupo ter usado o Apache Ant, tivemos as dependências manuais em .jar, é necessário referenciar elas também.

- Fazer o restore do banco de dados utilizado no projeto que está neste repositório também. 



 **Como primeiro sistema oficial e dinâmica de grupo, considerei uma excelente experiência. Tenho ciência que algumas coisas poderiam ter sido melhores, como o design do sistema ou das páginas, mas para um bootcamp e primeira interação com Java e o "Full-Stack", gostei do resultado final.** 
