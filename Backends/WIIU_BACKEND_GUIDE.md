# Wii U (GX2) Backend 実装ガイド

RmlUIのWii U向けバックエンド雛形を作成しました。以下のファイルを実装してください。

## ファイル構成

### 1. レンダラー (GX2)
- `RmlUi_Renderer_GX2.h` - GX2レンダラーのヘッダー
- `RmlUi_Renderer_GX2.cpp` - GX2レンダラーの実装

### 2. プラットフォーム (Wii U)
- `RmlUi_Platform_WiiU.h` - システムインターフェースのヘッダー
- `RmlUi_Platform_WiiU.cpp` - システムインターフェースの実装

### 3. バックエンド統合
- `RmlUi_Backend_WiiU_GX2.cpp` - 全体の統合

## 実装の優先順位

### Phase 1: 最小限の実装
1. **SystemInterface_WiiU::GetElapsedTime()** - OSGetTime()を使用
2. **SystemInterface_WiiU::LogMessage()** - OSReport()を使用
3. **RenderInterface_GX2::CompileGeometry()** - 頂点・インデックスバッファの作成
4. **RenderInterface_GX2::RenderGeometry()** - 基本的な描画
5. **RenderInterface_GX2::GenerateTexture()** - テクスチャ生成
6. **RenderInterface_GX2::SetScissorRegion()** - シザー領域設定

### Phase 2: 基本機能
7. **Backend::ProcessEvents()** - VPAD/KPAD入力処理
8. **Backend::BeginFrame()/PresentFrame()** - フレーム管理
9. **RenderInterface_GX2::LoadTexture()** - ファイルからテクスチャ読み込み

### Phase 3: 高度な機能
10. **ClipMask関連** - ステンシルバッファを使用したクリッピング
11. **Transform** - 変換行列のサポート

## 重要な実装ポイント

### GX2の頂点フォーマット
RmlUi::Vertexは以下の構造:
```cpp
struct Vertex {
    Vector2f position;  // x, y
    Colourb colour;     // r, g, b, a (各1バイト)
    Vector2f tex_coord; // u, v
};
```

GX2用に変換する必要があるかもしれません。

### エンディアン
- PowerPCはビッグエンディアン
- テクスチャデータのバイトスワップが必要な場合があります

### メモリアライメント
- GX2バッファは特定のアライメント要件があります
- MEM1/MEM2の適切な使用

### シェーダー
- 頂点シェーダー: 位置変換、カラー、テクスチャ座標のパススルー
- ピクセルシェーダー: テクスチャサンプリング + 頂点カラーの乗算

## 使用例

```cpp
#include <RmlUi/Core.h>
#include "Backends/RmlUi_Backend.h"

int main() {
    // バックエンドの初期化
    Backend::Initialize("RmlUi on Wii U", 1280, 720, false);
    
    // RmlUiにインターフェースを設定
    Rml::SetSystemInterface(Backend::GetSystemInterface());
    Rml::SetRenderInterface(Backend::GetRenderInterface());
    
    // RmlUi初期化
    Rml::Initialise();
    
    // コンテキスト作成
    Rml::Context* context = Rml::CreateContext("main", 
        Rml::Vector2i(1280, 720));
    
    // ドキュメント読み込み
    Rml::ElementDocument* document = context->LoadDocument("demo.rml");
    if (document) {
        document->Show();
    }
    
    // メインループ
    while (Backend::ProcessEvents(context)) {
        Backend::BeginFrame();
        
        context->Update();
        context->Render();
        
        Backend::PresentFrame();
    }
    
    // クリーンアップ
    Rml::Shutdown();
    Backend::Shutdown();
    
    return 0;
}
```

## 参考リンク

- [RmlUi Documentation](https://mikke89.github.io/RmlUiDoc/)
- Wii U SDK Documentation (devkitPPC)
- 既存のバックエンド実装: `RmlUi_Backend_SDL_GL2.cpp`

## トラブルシューティング

### 描画されない
1. GX2の初期化が正しいか確認
2. シェーダーが正しくコンパイルされているか
3. 頂点フォーマットが正しいか
4. ブレンドモードが有効か

### クラッシュ
1. メモリアライメントを確認
2. NULL pointerチェック
3. バッファサイズの検証

頑張ってください！
