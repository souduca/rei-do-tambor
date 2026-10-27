# O Rei do Tambor — como colocar o app no ar

Leva uns 20 minutos, uma vez só. Você vai precisar de uma conta no **Supabase** (onde ficam os dados e as fotos) e da sua conta no **GitHub** (onde o site fica no ar). Os dois são gratuitos.

Arquivos desta pasta:

| Arquivo | Para que serve |
|---|---|
| `index.html` | O app |
| `config.js` | Onde você cola os dados do Supabase (passo 4) |
| `manifest.webmanifest`, `sw.js`, `icons/` | Fazem o site virar app no celular |
| `supabase.sql` | Monta o banco de dados (passo 2) |

---

## 1. Criar o projeto no Supabase

1. Entre em **supabase.com** e crie uma conta (pode entrar com o GitHub).
2. Clique em **New project**.
3. Nome: `rei-do-tambor`. Região: **South America (São Paulo)**.
4. Crie uma senha do banco e guarde. Ela não é a senha do app, e você quase nunca vai usar.
5. Espere uns 2 minutos até o projeto ficar pronto.

## 2. Montar o banco de dados

1. No menu da esquerda, abra **SQL Editor** e clique em **New query**.
2. Abra o arquivo `supabase.sql`, copie tudo e cole lá.
3. Clique em **Run**. Deve aparecer "Success".

## 3. Criar o login da empresa

1. Abra **Authentication**, depois **Sign In / Providers**.
2. **Desligue** a opção **Allow new users to sign up** e salve.
   Esse passo é importante: ele impede que estranhos criem conta no app.
3. Abra **Authentication**, depois **Users**, e clique em **Add user** → **Create new user**.
   - **E-mail**: qualquer e-mail seu, por exemplo `reidotambor.app@gmail.com`. Ninguém vai digitar esse e-mail. Ele só fica guardado no app.
   - **Senha**: a senha que seu pai e a equipe vão digitar. Use algo fácil de lembrar e difícil de adivinhar.
   - Marque **Auto Confirm User**.

## 4. Ligar o app ao Supabase

1. Abra **Project Settings**, depois **API** (em alguns painéis o nome é **Data API** ou **API Keys**).
2. Abra o arquivo `config.js` num editor de texto (no Windows, use o Bloco de Notas) e troque:
   - `COLE_AQUI_A_PROJECT_URL` pelo **Project URL**, que é parecido com `https://abcd1234.supabase.co`
   - `COLE_AQUI_A_CHAVE_ANON_PUBLIC` pela chave **anon public**, um texto longo que começa com `eyJ…`
   - `COLE_AQUI_O_EMAIL_DA_EMPRESA` pelo e-mail que você criou no passo 3
3. Salve o arquivo. Mantenha as aspas como estão.

> A chave **anon public** foi feita para ficar no site. O que protege os dados é a senha da empresa, junto com o cadastro de novos usuários desligado. **Nunca** cole a chave `service_role`.

## 5. Colocar o site no ar (GitHub Pages)

1. No GitHub, clique em **New repository**. Nome: `rei-do-tambor`. Marque **Public** e crie.
2. Na página do repositório, clique em **Add file**, depois **Upload files**, e arraste **todo o conteúdo desta pasta**, incluindo a pasta `icons`. Clique em **Commit changes**.
3. Abra **Settings**, depois **Pages**. Em **Source**, escolha **Deploy from a branch**. Em **Branch**, escolha **main** e **/(root)**, e clique em **Save**.
4. Em 1 ou 2 minutos o endereço aparece no topo da página:
   **`https://SEU-USUARIO.github.io/rei-do-tambor/`**

Abra esse endereço, digite a senha e pronto. Esse mesmo link é o site para usar no computador.

## 6. Instalar no celular do seu pai

**Android (Chrome)**
1. Abra o endereço do site no Chrome.
2. Toque nos **três pontinhos ⋮**, depois em **Instalar app** (ou **Adicionar à tela inicial**).

**iPhone (Safari)**
1. Abra o endereço no **Safari** (precisa ser o Safari).
2. Toque no botão **Compartilhar** (o quadrado com a seta para cima), depois em **Adicionar à Tela de Início**.

O ícone verde com a coroa aparece na tela. Ele digita a senha uma vez e o app fica conectado.

---

## No dia a dia

- **Tudo atualiza sozinho.** O que alguém lança no celular aparece no computador e nos outros celulares na hora.
- **Para mudar o app** (quando eu fizer ajustes): no GitHub, envie o arquivo novo por cima do antigo com **Add file** e **Upload files**. Os celulares pegam a versão nova na próxima vez que abrirem o app.
- **Para trocar a senha:** no Supabase, abra **Authentication**, depois **Users**, apague o usuário e crie de novo com **o mesmo e-mail** e a senha nova. Os dados não se perdem. Cada aparelho vai pedir a senha nova uma vez.
- **Atenção ao plano grátis do Supabase:** se ninguém abrir o app por **7 dias seguidos**, o projeto é pausado. Para voltar, entre no supabase.com e clique em **Restore project**. Com uso diário, isso não acontece.
- **Fotos:** o app diminui a foto antes de enviar, então o espaço grátis (1 GB) aguenta milhares de fotos.
