# Mint Mono

Mint Mono は、開発者向けフォントの [Intel One Mono](https://github.com/intel/intel-one-mono) と日本語フォントの [Circle M+](https://itouhiro.github.io/mixfont-mplus-ipa/mplus/) 等を合成したプログラミング向けフォントです。

視認性が高く機能的な Intel One Mono と、同じく視認性・機能性に優れた日本語フォント Circle M+ (M+ FONTS の派生版) を組み合わせました。

[👉 ダウンロード](https://github.com/yuru7/mint-mono/releases/latest)  
※「Assets」内の zip ファイルをダウンロードしてご利用ください。

## 特徴

以下の特徴を備えています。

- Intel One Mono 由来の視認性が高く読みやすいラテン文字
- Circle M+ 由来のモダンで読み易い日本語文字
    - Circle M+ では元々読みやすい M+ FONTS をさらに発展させ、以下のような特徴を持っています
        - 半濁点が大きい
        - カ力 エ工 ロ口 ー一 ニ二 へヘ の区別
        - 〜～（波ダッシュ・全角チルダ）の区別
- 全角スペースの可視化
- [IBM Plex Sans JP](https://github.com/IBM/plex) を追加合成することで「Adobe-Japan1-7」文字コレクションに対応

### バリエーション

| 種類 | 説明 | 命名パターン |
| --- | --- | --- |
| 文字幅比率 半角1:全角2 | Intel One Mono を縮小することで、半角1:全角2の文字幅比率となるように合成したバリエーション。 | `MintMono-*.ttf`<br>※ファイル名に `35` が含まれて **いない** もの |
| 文字幅比率 半角3:全角5 | Intel One Mono を縮小せずに合成し、半角3:全角5の文字幅比率としたバリエーション。半角1:全角2と比べ、英数字などの半角文字がゆとりのある幅で表示される。| `MintMono35-*.ttf`<br>※ファイル名に `35` が含まれて **いる** もの |

## 表示サンプル

| 通常版 (幅比率 半角1:全角2) | 35版 (幅比率 半角3:全角5) |
| :---: | :---: |
| TODO | TODO |

## ビルド

### 環境

- [FontForge](https://fontforge.org/en-US/)
- Python 3.x

### 依存パッケージのインストール

```shell
pip install fonttools
```

### ビルドの実行 (PowerShell)

```powershell
./make.ps1
```

スクリプトが正常に完了すると、`build` ディレクトリにフォントファイルが生成されます。

### ビルドオプション

`make.ps1` を編集することで、`fontforge_script.py` に以下のオプションを渡して、生成するフォントをカスタマイズできます。

- `--35`: 半角3:全角5 の幅にする
- `--hidden-zenkaku-space`: 全角スペース可視化をしない

## ライセンス

SIL OPEN FONT LICENSE Version 1.1 が適用され、商用・非商用問わず利用可能です。

各合成元フォントのライセンスは [source](./source/) ディレクトリに格納されています。
