-- 更新 Scholarship 表添加發放狀態欄位
USE scholarship_system;

-- 添加 is_published 欄位
ALTER TABLE Scholarship ADD COLUMN is_published TINYINT(1) DEFAULT 0 COMMENT '是否已發放';

-- 添加 published_by 欄位  
ALTER TABLE Scholarship ADD COLUMN published_by VARCHAR(50) NULL COMMENT '發放機構ID';

-- 添加 published_at 欄位
ALTER TABLE Scholarship ADD COLUMN published_at TIMESTAMP NULL DEFAULT NULL COMMENT '發放時間';

-- 將現有獎學金設為已發放
UPDATE Scholarship SET is_published = 1, published_at = NOW();

-- 查看更新後的表結構
DESCRIBE Scholarship;
