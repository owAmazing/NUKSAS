<?php
// 更新資料庫結構 - 添加獎學金發放欄位

$host = 'localhost';
$dbname = 'scholarship_system';
$username = 'root';
$password = '';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8mb4", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    echo "<h2>開始更新資料庫結構...</h2>";
    
    // 檢查欄位是否存在
    $stmt = $pdo->query("SHOW COLUMNS FROM Scholarship LIKE 'is_published'");
    $columnExists = $stmt->fetch();
    
    if (!$columnExists) {
        // 添加 is_published 欄位（使用 TINYINT 代替 BOOLEAN）
        $pdo->exec("ALTER TABLE Scholarship ADD COLUMN is_published TINYINT(1) DEFAULT 0 COMMENT '是否已發放'");
        echo "<p>✓ 已添加 is_published 欄位</p>";
        
        // 添加 published_by 欄位
        $pdo->exec("ALTER TABLE Scholarship ADD COLUMN published_by VARCHAR(50) NULL COMMENT '發放機構ID'");
        echo "<p>✓ 已添加 published_by 欄位</p>";
        
        // 添加 published_at 欄位
        $pdo->exec("ALTER TABLE Scholarship ADD COLUMN published_at TIMESTAMP NULL DEFAULT NULL COMMENT '發放時間'");
        echo "<p>✓ 已添加 published_at 欄位</p>";
        
        // 將現有獎學金設為已發放
        $pdo->exec("UPDATE Scholarship SET is_published = 1, published_at = NOW()");
        echo "<p>✓ 已將現有獎學金設為已發放狀態</p>";
    } else {
        echo "<p>⚠ 欄位已存在，跳過更新</p>";
    }
    
    // 顯示表結構
    echo "<h3>當前 Scholarship 表結構：</h3>";
    $stmt = $pdo->query("DESCRIBE Scholarship");
    echo "<table border='1' cellpadding='5'>";
    echo "<tr><th>Field</th><th>Type</th><th>Null</th><th>Key</th><th>Default</th><th>Extra</th></tr>";
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        echo "<tr>";
        echo "<td>{$row['Field']}</td>";
        echo "<td>{$row['Type']}</td>";
        echo "<td>{$row['Null']}</td>";
        echo "<td>{$row['Key']}</td>";
        echo "<td>" . ($row['Default'] ?? 'NULL') . "</td>";
        echo "<td>{$row['Extra']}</td>";
        echo "</tr>";
    }
    echo "</table>";
    
    echo "<h3>✅ 資料庫更新完成！</h3>";
    echo "<p><a href='admin_scholarships.html'>返回獎學金管理</a></p>";
    
} catch (PDOException $e) {
    echo "<h2>❌ 錯誤：</h2>";
    echo "<p>" . $e->getMessage() . "</p>";
}
?>
