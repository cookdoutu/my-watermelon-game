# マイ・スイカゲーム 公開用サイト

## できること
- スマホ縦画面で遊べる公開ゲーム (`index.html`)
- 管理者ログイン付き編集画面 (`admin.html`)
- 管理者だけが画像・タイトルを変更
- 変更内容は同じ公開URLに反映

## 公開に必要な無料サービス
- Supabase: Auth / Database / Storage
- Netlify: 静的サイトのホスティング

## セットアップ手順

### 1. Supabaseを作る
1. https://supabase.com で無料プロジェクトを作成。
2. Authentication > Users から管理者ユーザーを作成（メールアドレスとパスワード）。
3. SQL Editorで `supabase-setup.sql` を開き、`YOUR_ADMIN_EMAIL` を管理者メールアドレスに置換して実行。
4. Project Settings > API から Project URL と anon/public key をコピー。
5. `config.js` の `SUPABASE_URL` と `SUPABASE_ANON_KEY` に貼り付ける。

**重要:** `service_role` / `secret` keyは絶対にフロントエンドへ入れないでください。anon/public keyだけを使います。

### 2. Netlifyで公開
1. https://app.netlify.com にログイン。
2. このフォルダ一式をNetlify DropまたはGit連携でデプロイ。
3. Netlifyが発行するURLが友達に送る公開URLです。
4. 管理画面は公開URLの末尾を `/admin.html` にして開きます。

### 3. 管理者として編集
1. `/admin.html` を開く。
2. Supabaseで作成した管理者メールアドレスとパスワードでログイン。
3. 8段階の画像を選び、「変更を公開URLに反映」を押す。
4. 公開ゲームを再読み込みすると画像とタイトルが更新されます。

## セキュリティ
- ゲーム画面は誰でも閲覧できます。
- 画像の読み取りは公開ですが、アップロード・更新・削除はSQLポリシーで管理者メールに制限しています。
- ゲーム設定の更新も管理者メールに制限しています。
- `config.js` のanon keyは公開用です。service_role keyは絶対に公開しないでください。
- 管理者メールアドレスはSQLポリシー内にも同じ値を設定してください。

## メモ
このフォルダは公開可能なサイトのソース一式です。Supabaseプロジェクト作成、管理者ユーザー作成、Netlifyデプロイはアカウント所有者が行う必要があります。こちらからアカウントを作成したり、ユーザーの代わりにログインしたりはできません。
