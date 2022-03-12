# Recursos para o portal de notícias
#### Criamos 3 tipos de recursos do k8s para gerenciar o nosso portal de notícias:
- [Pod](#pod)
- [ConfigMap](#configmap)
- [Service](#service)

## Pod
 Vamos descrever o que esse arquivo está fazendo pra gente:

  ```yaml
  apiVersion: v1
  kind: Pod
  metadata:
    name: portal-noticias-pod
    labels:
      app: portal-noticias-pod
  ```
  Primeiro definimos a versão da api do k8s que iremos usar, geralmente usamos a v1 que hoje é a versão estavel para trabalharmos.<br/>
  O **kind** define o tipo de recurso que vamos usar, nesse caso queremos criar um pod.
  
  Informamos o nome e sua label. A **label** é usada para que os outros recusos possam identificar esse pod.

  -----------------
  ```yaml
  spec:
    containers:
      - name: portal-noticias
        image: aluracursos/portal-noticias:1
        resources:
          limits:
            memory: "128Mi"
            cpu: "500m"
  ```
  Logo abaixo definimos as especificações do nosso recurso.

  Esse pod terá um container que vai utilizar a imagem do portal de notícias da Alura. Você pode ficar a vontade para criar suas próprias imagens e utiliza-lás dentro do kubernetes.
  Na parte de **resources** definimos uma limite de recursos para nosso container, assim ele não ira consumir todo o recurso do Node.

  -------------------

<span id="definir-configmap"></span>

  ```yaml
    ports:
      - containerPort: 80
    envFrom:
      - configMapRef:
          name: portal-configmap
  ```

  Para finalizar definimos qual será a porta de entrada do container.
  
  Para as variáveis de ambiente utilizaremos um recurso chamado **configMap**, e será atravéz dele que nosso container terá acesso as váriaveis. 

  -----------------
  Ao final nosso arquivo estará assim:

  ```yaml
  apiVersion: v1
  kind: Pod
  metadata:
    name: portal-noticias-pod
    labels:
      app: portal-noticias-pod
  spec:
    containers:
      - name: portal-noticias
        image: aluracursos/portal-noticias:1
        resources:
          limits:
            memory: "128Mi"
            cpu: "500m"
        ports:
          - containerPort: 80
        envFrom:
          - configMapRef:
              name: portal-configmap
  ```

Para criar esse recurso vamos utilizar o seguinte comando:
```bash
$ kubectl apply -f [caminho-desse-arquivo]
```
<br/>

## ConfigMap
  segundo a documentação oficial do k8s, _"Um ConfigMap é um objeto da API usado para armazenar dados **não-confidenciais** em pares chave-valor."_
  Nesse exemplo o nosso configmap estará armazenando dados sensiveis do nosso banco de dados, o que não é indicado, mas como se trata apenas de um exemplo para endendermos como ele funciona, vamos seguir assim.

  ```yaml
  apiVersion: v1
  kind: ConfigMap
  metadata:
    name: portal-configmap
  data:
    IP_SISTEMA: http://172.19.0.2:30001
  ```
  Definir um configmap é bem simple, basta definir seu kind e ao invés de um **spec** temos um **data** para definirmos os dados em key:value.

  Esses dados seram consumidos pelo nosso Pod como foi explicado a [acima](#definir-configmap)


  Para criar esse recurso vamos utilizar o seguinte comando:
  ```bash
  $ kubectl apply -f [caminho-desse-arquivo]
  ```
<br/>

  ## Service
  Como todas as vezes que um pod é criado um novo IP é atribuido a ele, precisamos de uma forma consistente de ter acesso ao nosso pod. É pra isso que criaremos o nosso Service.

  Ele tem várias utilidades, mas não vamos entra a fundo nisso agora. Para o nosso caso caso queremos ter um IP fixo para acessar os nosso pods e que esse IP possa ser acessado atrávez do navegado. É como se o service fosse uma camada na frente do nosso pod, assim para acessar o pod batemos primeiro no service desse pod.


  ```yaml
  apiVersion: v1
  kind: Service
  metadata:
    name: svc-portal-noticias
  spec:
    type: NodePort
    selector:
      app: portal-noticias-pod
    ports:
    - port: 80
      targetPort: 80
      nodePort: 30000
  ```
  Como foi realizado nos outros arquivos, sempre definimos o kind e o name do nosso recurso.
  Dentro de spec temos o type do nosso service, que pode ser de 3 tipos: ClusteIP, NodePort e Loadbalance.
  Aqui vamos utilizar o **NodePort** que além de criar um IP fixo para que possamos acessar qualquer pod que esteja vinculado a esse service,
  podemos utilizar o navegador para acessar o Node que redireciona para o service e então para o pod (Node -> Service -> Pod).
  
  E como nosso sevice sabe quais pods ele deve encaminha as requisições? 
  Fazemos isso atravéz do **selector**, passando como value a label dos pods que eu quero vincular ao service.

  Depois disso temos as configurações de porta.<br/>
  O **port** define qual a porta de entrada no service, o **targetPort** indica qual é a porta do pod que ele deve encaminha a request e 
  o **nodePort** é a porta por onde podemos acessar atravéz do navegador.
  
  Se eu não definir o targetPort, ele será o mesmo do port.

  Para criar esse recurso vamos utilizar o seguinte comando:
  ```bash
  $ kubectl apply -f [caminho-desse-arquivo]
  ```