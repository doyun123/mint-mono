# ini から VERSION を取得
$ini = Get-Content .\build.ini
$version = ($ini | Select-String -Pattern "VERSION").ToString().Split("=")[1].Trim()

# スクリプトファイルがある場所に移動する
Set-Location -Path $PSScriptRoot
# 各ファイルを置くフォルダを作成
New-Item -ItemType Directory -Force -Path ".\release_files\"
# ビルドフォルダを削除
Remove-Item -Path .\build -Recurse -Force

# 並列処理内で、処理が重いNerd Fontsのビルドを優先して処理する
$option_and_output_folder = @(
    # @("--console --nerd-font", "consoleNF-"), # ビルド コンソール Nerd Fonts版
    # @("--console --35 --nerd-font", "console35NF-"), # ビルド コンソール 3:5幅 Nerd Fonts版
    @("", "-"), # ビルド 通常版
    @("--35", "35-") # ビルド 3:5幅版
    # @("--console", "console-"), # ビルド コンソール版
    # @("--console --35", "console35-") # ビルド コンソール 3:5幅版
)

$option_and_output_folder | Foreach-Object -ThrottleLimit 4 -Parallel {
    Write-Host "fontforge script start. option: `"$($_[0])`""
    Invoke-Expression "& `"C:\Program Files (x86)\FontForgeBuilds\bin\ffpython.exe`" .\fontforge_script.py --do-not-delete-build-dir $($_[0])" `
        && Write-Host "fonttools script start. option: `"$($_[1])`"" `
        && python fonttools_script.py $_[1]
}

$move_file_src_dest = @(
    @("MintMono*NF*-*.ttf", "MintMonoNF_$version", "NF"),
    @("MintMono*-*.ttf", "MintMono_$version", "")
)

$timestamp = Get-Date -Format "yyyyMMddHHmmss"
$move_dir = ".\release_files\build_$timestamp"

$move_file_src_dest | Foreach-Object {
    # 要素数がゼロの場合スキップ
    if ($_.Count -eq 0) {
        return
    }

    $folder_path = "$move_dir\$($_[1])"
    New-Item -ItemType Directory -Force -Path $folder_path
    Move-Item -Path ".\build\$($_[0])" -Destination $folder_path -Force

    $variant = ""
    if ($_[2] -ne "") {
        $variant = "_$($_[2])"
    }
    @(
        @("*Console35*.ttf", "MintMonoConsole35$($variant)"),
        @("*Console*.ttf", "MintMonoConsole$($variant)"),
        @("*35*.ttf", "MintMono35$($variant)"),
        @("*.ttf", "MintMono$($variant)")
    ) | Foreach-Object {
        $individual_folder_path = "$folder_path\$($_[1])"
        # ファイル件数が0件の場合はフォルダを作成しない
        if ((Get-ChildItem -Path $folder_path\$($_[0])).Count -eq 0) {
            return
        }
        New-Item -ItemType Directory -Force -Path $individual_folder_path
        Move-Item -Path $folder_path\$($_[0]) -Destination $individual_folder_path -Force
    }
}

