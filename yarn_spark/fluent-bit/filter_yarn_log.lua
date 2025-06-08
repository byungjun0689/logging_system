function filter_khc_yarn_log(tag, timestamp, record)
    local path = record["file_path"]
    local applicationid = string.match(path, "application_%d+_%d+")
    
    
    if applicationid then
        record["application_id"] = applicationid
    end

    local log_message = record["log"]

    -- 로그 메시지 필터링
    log_pattern = "^(%d%d/%d%d/%d%d)%s(%d%d:%d%d:%d%d)%s(%u+)%s(.+)"
    
    local date, time, level, message = string.match(log_message, log_pattern)

    local log_data = {
        date = date,
        time = time,
        level = level,
        message = message
    }

    -- Get current date and time
    local current_date = os.date("%Y-%m-%d")
    local current_time = os.date("%H:%M:%S")
    local current_datetime = current_date .. " " .. current_time

    
    record["log_datetime"] = current_datetime   
    record["log_date"] = current_date
    record["log_time"] = current_time

    if date and time and level and message then
        
        -- local year, month, day = string.match(log_data.date, "(%d%d)/(%d%d)/(%d%d)")
        -- formatted_date = string.format("20%s-%s-%s", year, month, day)

        log_time = log_data.time
        record["level_info"] = log_data.level
        record["message"] = log_message --log_data.message
        
        record["log"] = nil

        return 1, timestamp, record
    else
        record["message"] = log_message
        record["log"] = nil

        -- log_level 설정
        if string.match(log_message, "Traceback") then
            record["level_info"] = "ERROR"
            return 1, timestamp, record
        else
            record["level_info"] = "ETC"
            return -1, timestamp, record
        end
    end
end

function filter_khc_spark_application_info(tag, timestmap, record)
    -- 권한(예: lrwxrwxrwx)과 파일명 캡처
    -- lrwxrwxrwx 1 ubuntu ubuntu   75 May 16 05:48 llm_mart_transfer_data.py -> /hadoop/yarn/local/usercache/airflow/filecache/13/llm_mart_transfer_data.py

    local path = record["file_path"]
    local applicationid = string.match(path, "application_%d+_%d+")
    
    if applicationid then
        record["application_id"] = applicationid
    end

    local log_message = record["log"]
    local log_pattern = "([%w_]+%.py)%s+->"
    local file_name = string.match(log_message, log_pattern)

    -- Get current date and time
    local current_date = os.date("%Y-%m-%d")
    local current_time = os.date("%H:%M:%S")
    local current_datetime = current_date .. " " .. current_time
    
    record["log_datetime"] = current_datetime   
    record["log_date"] = current_date
    record["log_time"] = current_time

    record["date"] = timestmap  --timestmap

    if file_name then
        record["file_name"] = file_name
        record["log"] = nil
        record["message"] = log_message

        local sperator_pattern = "^(%a+)_([%w_]+)%.py$"
        local load_type, table_name = string.match(file_name, sperator_pattern)
        
        record["load_type"] = load_type
        record["table_name"] = table_name

        return 1, record.date, record
    else
        return -1, timestamp, record
    end
    
end

function filter_khc_hivemetastore_log(tag, timestamp, record)
    local log_message = record["log"]
    -- Pattern: 2025-05-30T05:09:39,773  INFO [pool-6-thread-1] metastore.ObjectStore: Initialized ObjectStore
    local log_pattern = "^(%d%d%d%d%-%d%d%-%d%d)T(%d%d:%d%d:%d%d),(%d+)%s+(%u+)%s+%[([^%]]+)%]%s+([%w%.]+):%s+(.+)"
    local date, time, ms, level, thread, logger, message = string.match(log_message, log_pattern)

    -- Get current date and time

    if date and time and level and thread and logger and message then
        record["log_date"] = date
        record["log_time"] = time
        record["log_datetime"] = date .. " " .. time

        record["level_info"] = level
        record["thread"] = thread
        record["logger"] = logger
        record["message"] = message
        record["log"] = nil
        
        return 1, timestamp, record
    else

        return -1, timestamp, record
    end
end