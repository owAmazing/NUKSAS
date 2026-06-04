<?php
header('Content-Type: application/json; charset=utf-8');

// 讀取 POST 資料
$input = json_decode(file_get_contents('php://input'), true);
$password = isset($input['password']) ? $input['password'] : '';

// 資料庫連線設定
$host = 'localhost';
$username = 'root';

try {
    // 建立 PDO 連線（不指定資料庫）
    $pdo = new PDO("mysql:host=$host;charset=utf8mb4", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $pdo->setAttribute(PDO::MYSQL_ATTR_USE_BUFFERED_QUERY, true);
    
    // 先刪除舊的資料庫（如果存在）
    $pdo->exec("DROP DATABASE IF EXISTS scholarship_system");
    $details[] = "✓ 清理舊資料庫";
    
    // 讀取 SQL 檔案
    $sqlFile = __DIR__ . '/create_database.sql';
    if (!file_exists($sqlFile)) {
        throw new Exception("找不到 create_database.sql 檔案");
    }
    
    $sql = file_get_contents($sqlFile);
    
    // 分割 SQL 語句（以分號分隔，但忽略註解中的分號）
    $statements = [];
    $current = '';
    $inComment = false;
    $lines = explode("\n", $sql);
    
    foreach ($lines as $line) {
        $line = trim($line);
        
        // 跳過註解行
        if (empty($line) || strpos($line, '--') === 0 || strpos($line, '/*') === 0) {
            continue;
        }
        
        $current .= $line . ' ';
        
        // 如果行尾有分號，則視為一個完整的語句
        if (substr($line, -1) === ';') {
            $statements[] = trim($current);
            $current = '';
        }
    }
    
    // 執行每個 SQL 語句
    $details = [];
    $executed = 0;
    
    foreach ($statements as $statement) {
        if (empty($statement)) continue;
        
        try {
            // 使用 prepare 和 execute 來避免緩衝問題
            $stmt = $pdo->prepare($statement);
            $stmt->execute();
            $stmt->closeCursor();
            $executed++;
            
            // 記錄重要操作
            if (stripos($statement, 'CREATE DATABASE') !== false) {
                $details[] = "✓ 資料庫建立成功";
            } elseif (stripos($statement, 'CREATE TABLE') !== false) {
                preg_match('/CREATE TABLE\s+`?(\w+)`?/i', $statement, $matches);
                if (isset($matches[1])) {
                    $details[] = "✓ 表格建立: {$matches[1]}";
                }
            } elseif (stripos($statement, 'CREATE VIEW') !== false) {
                preg_match('/CREATE VIEW\s+`?(\w+)`?/i', $statement, $matches);
                if (isset($matches[1])) {
                    $details[] = "✓ 視圖建立: {$matches[1]}";
                }
            }
        } catch (PDOException $e) {
            // 如果是 "database exists" 錯誤，可以忽略
            if (strpos($e->getMessage(), 'database exists') === false && 
                strpos($e->getMessage(), 'table exists') === false) {
                throw $e;
            }
        }
    }
    
    // 驗證資料庫是否建立成功
    $pdo->exec("USE scholarship_system");
    $stmt = $pdo->prepare("SELECT COUNT(*) as count FROM User");
    $stmt->execute();
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    $stmt->closeCursor();
    
    // 保存密碼配置到 config.php
    $configContent = "<?php\n// Database Configuration\ndefine('DB_HOST', 'localhost');\ndefine('DB_USER', 'root');\ndefine('DB_PASS', '" . addslashes($password) . "');\ndefine('DB_NAME', 'scholarship_system');\n?>";
    file_put_contents(__DIR__ . '/config.php', $configContent);
    
    echo json_encode([
        'success' => true,
        'message' => "資料庫安裝完成！共執行 {$executed} 個 SQL 語句，建立了 {$result['count']} 筆測試資料。",
        'details' => $details,
        'executed' => $executed,
        'testDataCount' => $result['count']
    ], JSON_UNESCAPED_UNICODE);
    
} catch (PDOException $e) {
    echo json_encode([
        'success' => false,
        'message' => '資料庫連線或建立失敗',
        'error' => $e->getMessage()
    ], JSON_UNESCAPED_UNICODE);
} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'message' => $e->getMessage(),
        'error' => ''
    ], JSON_UNESCAPED_UNICODE);
}
?>
