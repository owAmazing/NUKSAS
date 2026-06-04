<?php
// 添加 file_path 欄位到 Recommendation 表
try {
    // 嘗試連接到 MySQL
    $pdo = new PDO("mysql:host=127.0.0.1;dbname=scholarship_system;charset=utf8mb4", "root", "", [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
    ]);
    
    $pdo->exec("ALTER TABLE Recommendation ADD COLUMN file_path VARCHAR(255) NULL");
    echo json_encode(['success' => true, 'message' => '已添加 file_path 欄位']);
} catch(PDOException $e) {
    if(strpos($e->getMessage(), 'Duplicate column') !== false) {
        echo json_encode(['success' => true, 'message' => '欄位已存在']);
    } else {
        echo json_encode(['success' => false, 'message' => $e->getMessage()]);
    }
}
?>
