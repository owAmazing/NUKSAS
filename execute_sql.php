<?php
header('Content-Type: application/json');

$host = 'localhost';
$dbname = 'scholarship_system';
$username = 'root';
$password = '';

try {
    // 先嘗試 PDO 連接（與 API 一致）
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8mb4", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    $results = [];
    
    // 檢查欄位是否存在
    $stmt = $pdo->query("SHOW COLUMNS FROM Scholarship LIKE 'is_published'");
    $exists = $stmt->fetch();
    
    if ($exists) {
        echo json_encode([
            'success' => true,
            'message' => '欄位已存在，無需更新',
            'already_exists' => true
        ]);
        exit;
    }
    
    // 執行 ALTER TABLE 語句
    $pdo->exec("ALTER TABLE Scholarship ADD COLUMN is_published TINYINT(1) DEFAULT 0 COMMENT '是否已發放'");
    $results[] = "✓ is_published 欄位已添加";
    
    $pdo->exec("ALTER TABLE Scholarship ADD COLUMN published_by VARCHAR(50) NULL COMMENT '發放機構ID'");
    $results[] = "✓ published_by 欄位已添加";
    
    $pdo->exec("ALTER TABLE Scholarship ADD COLUMN published_at TIMESTAMP NULL DEFAULT NULL COMMENT '發放時間'");
    $results[] = "✓ published_at 欄位已添加";
    
    // 更新現有資料
    $stmt = $pdo->exec("UPDATE Scholarship SET is_published = 1, published_at = NOW()");
    $results[] = "✓ 已將現有獎學金設為已發放";
    
    echo json_encode([
        'success' => true,
        'message' => '資料庫更新完成',
        'results' => $results
    ]);
    
} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'message' => $e->getMessage()
    ]);
}
?>
