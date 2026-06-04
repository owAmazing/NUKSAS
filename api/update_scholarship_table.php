<?php
// 更新 Scholarship 表，添加發放狀態欄位

$host = 'localhost';
$dbname = 'scholarship_system';
$username = 'root';
$password = '';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8mb4", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    // 檢查欄位是否已存在
    $checkColumn = $pdo->query("SHOW COLUMNS FROM Scholarship LIKE 'is_published'");
    if ($checkColumn->rowCount() == 0) {
        // 添加發放狀態欄位
        $pdo->exec("ALTER TABLE Scholarship ADD COLUMN is_published BOOLEAN DEFAULT FALSE");
        $pdo->exec("ALTER TABLE Scholarship ADD COLUMN published_by VARCHAR(50) NULL");
        $pdo->exec("ALTER TABLE Scholarship ADD COLUMN published_at TIMESTAMP NULL");
        
        echo "✅ 成功添加欄位：is_published, published_by, published_at<br>";
        
        // 將現有獎學金設為已發放
        $pdo->exec("UPDATE Scholarship SET is_published = TRUE WHERE is_published IS NULL");
        echo "✅ 已將現有獎學金設為已發放狀態<br>";
    } else {
        echo "ℹ️ 欄位已存在，無需重複添加<br>";
    }
    
    echo "<br>資料庫更新完成！";
} catch(PDOException $e) {
    echo "❌ 錯誤: " . $e->getMessage();
}
?>
