<p align="center">
  <img src="https://user-images.githubusercontent.com/81548811/229256163-7dcc4dc1-ba27-47fb-924d-ea4b298e72bf.jpg" alt="Feature Graphic" width="90%">
</p> 

## このプロジェクトについて
勉強の極意は「勉強できない人を助けるアプリ」です。  
勉強法１０冊分の知識を学べたり、集中力を保って勉強がうまくできる機能が盛りだくさん!  
- 使用技術：Dart, Flutter, sqflite
- 開発期間：３ヶ月  
- 担当　　：全部  

<img src="https://user-images.githubusercontent.com/81548811/229256245-c3fde846-926c-4875-916c-b9fe3599e939.jpg" alt="Android 1" width="20%"><img src="https://user-images.githubusercontent.com/81548811/229256233-2eb87875-dcf6-4693-b3be-0bd278efcb41.jpg" alt="Android 2" width="20%"><img src="https://user-images.githubusercontent.com/81548811/229256259-a1aaacfe-b396-469b-99e2-e3d0b9d2dfbd.jpg" alt="Android 3" width="20%"><img src="https://user-images.githubusercontent.com/81548811/229256299-99af8cb7-caf4-4119-8c87-1d27ae841714.jpg" alt="Android 4" width="20%"><img src="https://user-images.githubusercontent.com/81548811/229256311-e9981873-50be-498e-bd5c-2ecbf3a7e1d6.jpg" alt="Android 5" width="20%">

## 使い方
### 方法1. ストアからインストール  
iOS: [https://apple.co/3iD88Zu](https://apple.co/3iD88Zu)  
Android: [https://play.google.com/store/apps/details?id=com.keiit596.ramp&pli=1](https://play.google.com/store/apps/details?id=com.keiit596.ramp&pli=1)  

### 方法2. ローカルで実行
```
git clone https://github.com/KeiIT11/benkyou-no-gokui.git
flutter clean
flutter packages get
flutter run
```

## 機能と使用技術（特徴を箇条書きなど）
### 1. 記事機能

<img src="https://user-images.githubusercontent.com/81548811/229256245-c3fde846-926c-4875-916c-b9fe3599e939.jpg" alt="Android 1" width="20%"><img src="https://user-images.githubusercontent.com/81548811/229256233-2eb87875-dcf6-4693-b3be-0bd278efcb41.jpg" alt="Android 2" width="20%">

記事機能は、１０冊以上の勉強法をまとめたものを学べる機能です。 記事一覧ページと記事詳細ページがあります。 記事は、アプリ内にmarkdownファイルで保存されています。

### 2. 計画機能

<img src="https://user-images.githubusercontent.com/81548811/229256259-a1aaacfe-b396-469b-99e2-e3d0b9d2dfbd.jpg" alt="Android 3" width="20%">

計画機能は、毎日の勉強計画を立てることができる機能です。データはアプリ内でSqfliteを使って保存されています。

### 3. タイマー機能

<img src="https://user-images.githubusercontent.com/81548811/229256299-99af8cb7-caf4-4119-8c87-1d27ae841714.jpg" alt="Android 4" width="20%"><img src="https://user-images.githubusercontent.com/81548811/229256311-e9981873-50be-498e-bd5c-2ecbf3a7e1d6.jpg" alt="Android 5" width="20%">

タイマー機能は、ポモドーロテクニックを使って、効率的に作業ができる機能です。 (ポモドーロ機能：２５分勉強、５分休憩を繰り返すことで１日の集中力を保つテクニック)

### 4. (記録機能）

（Flutter版では未実装）
記録機能は、タスクごとの勉強時間を記録し、確認できる機能です。
それにより毎日の勉強計画を変更できます。例えば、教科書１章やるのに３０分と見積もっていたのに、実際には１時間かかった場合など。 以前より勉強できるようになったという成長を確認できる機能です。

## こだわりと苦労した点

## 今後のアップデート予定
僕はこのアプリをポートフォリオの一つとしてではなく、プロダクトとしてグロースしていきたいと思っています。  
具体的な計画としては  
- 英語対応させる
- 記事を充実させ
