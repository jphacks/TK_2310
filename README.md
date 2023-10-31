# SAFA

[![IMAGE ALT TEXT HERE](https://jphacks.com/wp-content/uploads/2023/07/JPHACKS2023_ogp.png)](https://www.youtube.com/watch?v=yYRQEdfGjEg)

## 製品概要

### 背景(製品開発のきっかけ、課題等）

都内各所でゴミ拾いボランティアイベントが開催されています。

しかし、そもそもゴミ拾いボランティアの維持が難しいことに加え、企業が社会貢献をしたいが規模が大きすぎたり、
貢献したことによる効果が見えないという問題が存在します。

### 製品説明（具体的な製品の説明）

私たちはボランティアさんとボランティア支援をしたい企業さんとをマッチングするプラットフォームを作りました

ボランティア参観者は企業からの支援を受けてゴミ拾い活動を持続させ、
インセンティブを参加者に与えることで多くの人を巻き込むことができます。

そして企業は社会貢献としてゴミ拾いを支援し、同
時に自身のイメージ向上とプロモーション効果を高めることが可能になっています。

### デモ動画


https://github.com/jphacks/TK_2310/assets/51395778/7a79afe8-3c6b-4ac7-9be0-9ea04e74067a



### 特長

#### 1. ゴミ拾いボランティアにインセンティブ(お金)を付与する

#### 2. 企業側は社会貢献に対してお金を払うことでイメージアップに繋げることができる

#### 3. ボランティア参加者が獲得するお金が最大になるアルゴリズムの実装

### 解決出来ること

ゴミ拾いをはじめとする社会貢献活動のボランティアの継続性を高めることができます。

### 今後の展望
- 遺伝的アルゴリズムへの乗り換え
  - 区間スケジューリングと動的計画法によるお金が最大になるようなプラン提案は規模が大きくなるつれて、動的計画法の空間計算量が無視できなくなる
  - そのため、区間スケジューリングと動的計画法が遺伝的アルゴリムのI/Oと同等の速度になったタイミングで遺伝的アルゴリズムによる最大値の近似に移行したいと考える。
### 注力したこと（こだわり等）

- 一眼見ただけで何をしているのかわかる UI にしています。
- ユーザーの負担を減らし、最適なイベントを提案することでイベント参加率の増加と企業が出す広告に対する費用対効果を最大限高めます。

## 開発技術

### 活用した技術
  - 

#### API・データ

- Google Map API
- Firebase

#### フレームワーク・ライブラリ・モジュール

- Nextjs
- Flutter
- Flutter Hook & Riverpod
- echo

### 独自技術

#### ハッカソンで開発した独自機能・技術

- お金が最大になるようなイベントプランの計算(バックエンド)

  - 指定した日のお金が一番多くなるようなイベントプランを提案する。イベント同士の区間は被らない、
  - 区間スケジューリング問題 + 動的計画法による高速化
  - これにより O(2^n \* nlogn)が O(nlogn)に高速化

  ```
  Aは区間の集合であり、A={1,2,3...n}があるとき、各タスクiについて開始時刻s[i]と終了時刻f[i]をもつとする。
  Aはf(1) <= f(2) <= f(3) <= ... <= f(n)の集合とする。
  p(i) = max{i|f(i) <= s(i)}とする
  i番目の最大値をdp[i]とすると
  dp[i] = max{dp[p[i]] + a[i] | dp[i-1]}
  これにより最大値が求められる
  ```

  - https://github.com/jphacks/TK_2310_1/blob/main/algo/dp.go

- imos法による重複区間の高速判定
  - imos法を用いることでO(n^2)をO(n+m)にし、高速化
  - https://github.com/jphacks/TK_2310_1/blob/main/algo/imos.go

- Makefile による自作コマンド作成
- 特に力を入れた部分をファイルリンク、または commit_id を記載してください。
  - https://github.com/jphacks/TK_2310/blob/2d90796d10fe7bbedf520b04944322bd1bfb4c74/lib/presentation/screen/home/component/trash_activity_contribution_card.dart#L19-L31
  - https://github.com/jphacks/TK_2310/blob/2d90796d10fe7bbedf520b04944322bd1bfb4c74/lib/domain/repository/event_repository.dart#L12-L18

- protocol bufferによるスキーマとバリデーションの自動生成
  - スキーマ駆動開発を快適に行うためにコマンド一つでprotoから構造体とバリデーションの作成を行う
  - docker内で行うことでローカル管渠を汚さない
  - dockerとshによって移植を高める
  - https://github.com/jphacks/TK_2310_1/blob/main/scripts/gen_proto.sh



#### レポジトリ一覧
- [バックエンド](https://github.com/jphacks/TK_2310_1)
- [Webフロント](https://github.com/jphacks/TK_2310_2)
- モバイルはこのリポジトリです！！
