# CineFavorite (Formativa)

## Briefing
Construir um Aplicativo do Zero - O CineFavorite permitirá criar uma conta e buscar filmes em uma API, montar uma galeria pessoal de filmes favoritos, com poster (capa) e nota avaliativa do usuário para o filme.

## Objetivos
- Criar uma Galeria Personalizada por Usuário de Filmes Favoritos
- Buscar  Filmes em uma API e Listar para selecionar filmes favoritos
- Criação de Contas por Usuários
- Listar Filmes por Palavra-Chave

## Levantamento de Requisitos
- ### Funcionais
- ### Não Funcionais

## Recursos do Projeto
- Linguagem de Programação: Flutter/Dart
- APi TMDB: Base de Dados para Filmes
- Figma: Prototipagem
- GitHub: Para Armazenamento e Versionamento do Código
- fireBase: Authentication / FireStore DB
- VsCode: Codificação / Teste

## Diagramas
1. ### Classe:
Demonstrar o Funcionamento de Entidades de Sistema
- Usuário (User): Classe já modelada pelo FireBaseAuth
    - Atributos: email, senha, uid
    - Métodos: Login, registrar, logout

- Filmes Favoritos (Movie): Classe Modelada pelo DEV - Baseada na API TMDB
    - Atributos: id, título, PosterPath, Nota
    - Métodos: Adicionar, remover, listar, atualizarNota (CRUD)

    ```mermaid

    classDiagram

        class User{
            +String uid,
            +String email,
            +String password
            +login()
            +logout()
            +register()
        }

        class Movie{
            +int id
            +String title
            +String posterPath
            +double rating
            +addFavorite()
            +removerFavorite()
            +updateMovieRating()
            +gteFavoriteMovies()
        }

        User "1"--"1+" Movie : "select"

    ```

    2. ### Uso
    Ação que os Atores podem Fazer
    - Usuários:
        - Regsiter
        - Login
        - Logout
        - Procurar filmes na API
        - Salvar Filmes aos Favoritos
        - Dar Nota aos Filmes Favoritos
        - Remover Filmes dos Favoritos

    ```mermaid
    graph TD
        subgraph "Ações"
            ac1([Registrar])
            ac2([Login])
            ac3([Logout])
            ac4([SearchMovie])
            ac5([AddFavoriteMovie])
            ac6([UpdateMovieRating])
            ac7([RemoveFavoriteMovie])
        end

        user([Usuário])

        user --> ac1
        user --> ac2

        ac1 --> ac2
        ac2 --> ac3
        ac2 --> ac4
        ac2 --> ac5
        ac2 --> ac6
        ac2 --> ac7

    ```

    3. ### Fluxo
    Determinar o caminho Percorrido pelo Ator para executar uma Ação

    - Fluxo da Ação de Login

    ```mermaid
    graph TD

        A[Início] --> B{Tela de Login}
        B --> C[Inserir Email e Senha]
        C --> D{Validar as Credenciais}
        D --> Sim --> G[Favorite View]
        D --> Não --> B
    
    ```

    ## Prototipagem

    Link dos Protótipos
    
    - https://www.figma.com/design/DMRmKiNgFMjKS5Nf38Ytcc/Untitled?node-id=0-1&t=k2tNWzZI33LfWfqv-1

    ## Codificação

    