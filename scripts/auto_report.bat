@echo off
setlocal
cd /d "%~dp0.."

echo ==========================================
echo      GREENTECH - BAO CAO SU CO HE THONG
echo ==========================================
echo Thoi diem chay: %date% %time%
echo.

REM AUDIT: chi doc data\log-he-thong.log va ghi noi backup\bao-cao-su-co.txt.
REM Khong co lenh xoa file. Kiem tra file dau vao truoc khi xu ly.
if not exist "data\log-he-thong.log" (
    echo [LOI] Khong tim thay data\log-he-thong.log
    echo Hay tao file log hoac kiem tra duong dan.
    exit /b 1
)

if not exist "backup" mkdir "backup"

echo.>> "backup\bao-cao-su-co.txt"
echo ==========================================>> "backup\bao-cao-su-co.txt"
echo BAO CAO SU CO - %date% %time%>> "backup\bao-cao-su-co.txt"
echo Nguon: data\log-he-thong.log>> "backup\bao-cao-su-co.txt"
echo ==========================================>> "backup\bao-cao-su-co.txt"

REM FINDSTR doc theo dong; /I khong phan biet hoa-thuong; /C tim chuoi chinh xac.
REM Pipe dua dau ra vao findstr, tranh nap ca file log vao mot bien.
type "data\log-he-thong.log" | findstr /I /C:"CRITICAL" /C:"ERROR" >> "backup\bao-cao-su-co.txt"

if errorlevel 2 (
    echo [CANH BAO] findstr gap loi khi doc log.
    exit /b 2
)

echo Da hoan tat. Ket qua duoc noi vao backup\bao-cao-su-co.txt
endlocal
