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