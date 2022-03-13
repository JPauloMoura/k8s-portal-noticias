
# K8s | Kind - Portal de notícias alura

Esse projeto tem como objetivo ajudar na fixação de alguns conceitos sobre kubernetes.<br/>
Criamos um cluster Kubernetes local utilizando o kind e realizamos a implatação de sistema Portal de Noticias desenvolvida pela Alura.

Para entender as etapas de desencolvimento basta acessa os diretórios de manifesto:
- [database](/manifestos/database/README.md)
- [sistema](/manifestos/sistema/README.md)
- [portal](/manifestos/portal/README.md)

## Documentação
Para entender as etapas de desencolvimento basta acessa os diretórios de manifesto:
- [database](/manifestos/database/README.md)
- [sistema](/manifestos/sistema/README.md)
- [portal](/manifestos/portal/README.md)

## Instalação

### Pré requisitos para o projeto
  - [Docker](https://docs.docker.com/engine/install/) 
  - [Kind](https://kind.sigs.k8s.io/docs/user/quick-start/#:~:text=Exporting%20Cluster%20Logs-,Installation%20%F0%9F%94%97%EF%B8%8E,-NOTE%3A%20kind%20does)

  #### 1) Realize a criação do cluster.
  ```shell
   $ kind create cluster --name cluste-portal-noticias
   $ kind get clusters
   $ kubectl get nodes 
  ```

  #### 2) Altere para o novo contexto do cluster criado.
  ```shell
    $ kubectl config use-context kind-cluste-portal-noticias
    $ kubectl config current-context
  ```
  #### 3) Entre na raiz do projeto e suba todos os recursos.
  ```shell
    $ make start
  ```

  ## Acessando o projeto
  O projeto está dividido em duas partes:
  - Portal de notícias: onde temos o feed de notícias.
  - Sistema de notícias: onde podemos criar as notícias.

  Para Windows podemos acessa-lós pelas portas `localhots:30000` e `localhost:30001` espectivamente.

  Já para que usa linux temos que descobrir qual o IP do nosso Node,
  pois é atravéz dele que vamos tera acesso aos nossos serviços
  
 [<img src="https://user-images.githubusercontent.com/77674803/158042588-5cc5bf3d-d63a-4bc6-b706-3190a5806d4e.png" width="1000"/>](image.png)

  Use o `INTERNAL-IP:30001` e `INTERNAL-IP:30001` para acessar as páginas.


## Demonstração

#### Portal de notícias
[<img src="https://user-images.githubusercontent.com/62079201/158041299-81684265-5c0e-412b-9659-2faeeeeeca55.png" width="750"/>](image.png)

#### Login Sistema de notícias
[<img src="https://user-images.githubusercontent.com/62079201/158041343-8c382fb4-ad05-48b9-b1f0-7d65fbe7f54e.png" width="600"/>](image.png)

#### Sistema de notícias
[<img src="https://user-images.githubusercontent.com/62079201/158041376-411dd03c-4cda-4f6f-a11e-8e4d479bf8b1.png" width="750"/>](image.png)



## Contato

Se você tiver algum feedback, dúvida ou sugestão de melhoria. Pode me manda uma mensagem no [LinkedIn](https://www.linkedin.com/in/jpaulomouradev/) ou Criar uma issue nesse projeto.

---

<p align="center">Desenvolvido por João Paulo</p>