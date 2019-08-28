# cl-gtk3-tutorial

## Preparation

### Install GTK3

```
$ sudo apt install libgtk-3-dev
```

### Install cl-cffi-gtk

```
$ ros install crategus/cl-cffi-gtk
```

## Usage

```
$ ros install
```

```
(ql:quickload :cl-gtk3-tutorial)
```

### 01 シンプルウィンドウ1

```
(cl-gtk3-tutorial:start :id 1)
```

![01](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/01.png)

※ デフォルトでは 200 x 200 pixel サイズのウィンドウ

### 02 シンプルウィンドウ2

```
(cl-gtk3-tutorial:start :id 2)
```

![02](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/02.png)

### 03 ボタン1

```
(cl-gtk3-tutorial:start :id 3)
```

![03](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/03.png)

### 04 ボタン2

```
(cl-gtk3-tutorial:start :id 4)
```

![04](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/04.png)

### 05 ボタン3

```
(cl-gtk3-tutorial:start :id 5)
```

![05](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/05.png)

※ ソースコードを改良しただけなので、見た目は変化なし

### 06 お絵かき

```
(cl-gtk3-tutorial:start :id 6)
```

![06](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/06.png)

### 07 パッキングボックス

```
(cl-gtk3-tutorial:start :id 7)
```

![07](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/07.png)

### 08 テーブルを使用したパッキング

```
(cl-gtk3-tutorial:start :id 8)
```

![08](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/08.png)

### 09 テーブルを使用したパッキング2

```
(cl-gtk3-tutorial:start :id 9)
```

![09](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/09.png)

### 10 グリッドを使用したパッキング

```
(cl-gtk3-tutorial:start :id 10)
```

![10](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/10.png)

### 11 グリッドを使用したパッキング2

![11](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/11.png)

### 12 画像とラベルが付いたボタン

![12](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/12.png)

### 13 ボタンを作成するその他の例

![13](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/13.png)

### 14 チェックボタンとラジオボタン

![14](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/14.png)

### 15 リンクボタン

![15](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/15.png)

### 16 スイッチ

![16](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/16.png)

### 17 色んなラベル

![17](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/17.png)

### 18 色んなラベル2

![18](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/18.png)

### 19 色んな画像

![19](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/19.png)

### 20 プログレスバー

![20](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/20.png)

### 21 ステータスバー

![21](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/21.png)

### 22 情報バー

![22](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/22.png)

### 23 範囲ウィジェット

![23](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/23.png)

### 24 アライメントウィジェット

![24](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/24.png)

### 25 固定コンテナ

![25](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/25.png)

### 26 フレーム

![26](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/26.png)

### 27 アスペクトフレームコンテナ

![27](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/27.png)

### 28 パンウィンドウウィジェット

![28](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/28.png)

### 29 スクロールウィンドウ

![29](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/29.png)

### 30 ボタンボックス

![30](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/30.png)

### 31 ノートブック

![31](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/31.png)

### 32 シンプルな複数行のテキストウィジェット

![32](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/32.png)

### 33 テキストビューのテキスト属性の変更

![33](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/33.png)

### 34 タグの適用

![34](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/34.png)

### 35 テキストビューでテキストを検索

![35](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/35.png)

### 36 テキストビューでテキストを検索2

![36](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/36.png)

### 37 テキストの読み込みと変更

![37](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/37.png)

### 38 テキストの読み込みと変更2

![38](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/38.png)

### 39 画像挿入

![39](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/39.png)

### 40 ウィジェット挿入

![40](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/40.png)

### 41 ツールチップをテキストビューで表示

![41](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/41.png)

### 42 ツリービュー

![42](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/42.png)

### 43 永続的なセルレンダラーのプロパティ

![43](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/43.png)

### 44 ダイアログ

![44](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/44.png)

### 45 カラーボタン

![45](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/45.png)

### 46 カラーセレクタダイアログ

![46](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/46.png)

### 47 ファイル選択ダイアログ

![47](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/47.png)

### 48 フォント選択ダイアログ

![48](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/48.png)

### 49 矢印付きボタン

![49](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/49.png)

### 50 カレンダー

![50](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/50.png)

### 51 イベントボックス

![51](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/51.png)

### 52 テキスト入力

![52](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/52.png)

### 53 スピンボタン

![53](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/53.png)

### 54 コンボボックス
![54](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/54.png)

### 55 コンボボックステキスト

![55](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/55.png)

### 56 メニュー

![56](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/56.png)

### 57 ポップアップメニューの作成

![57](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/57.png)

### 58 ツールバー

![58](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/58.png)

### 59 Demo Cairo Stroke

![59](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/59.png)

### 60 Demo Cairo Clock

![60](https://github.com/fireflower0/cl-gtk3-tutorial/blob/master/img/60.png)
