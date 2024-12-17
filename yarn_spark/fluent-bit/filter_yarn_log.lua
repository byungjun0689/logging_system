function filter_khc_yarn_log(tag, timestamp, record)
    
    local path = record["file_path"]
    local applicationid = string.match(path, "application_%d+_%d+")
    
    if applicationid then
        record["applicationid"] = applicationid
    end
    
    local log_message = record["log"]

    -- 로그 메시지 필터링
    --if string.match(message, "^%d%d/%d%d/%d%d %d%d:%d%d:%d%d INFO KHCLogger: Step %d+: %d+:%d+:%d+") then
    log_pattern = "^(%d%d/%d%d/%d%d)%s(%d%d:%d%d:%d%d)%s(%u+)%s(.+)"
    local date, time, level, message = string.match(log_message, log_pattern)

    local log_data = {
        date = date,
        time = time,
        level = level,
        message = message
    }

    if date and time and level and message then
        
        local day, month, year = string.match(log_data.date, "(%d%d)/(%d%d)/(%d%d)")
        local formatted_date = string.format("20%s-%s-%s", year, month, day)
        local formatted_date = string.format("20%s-%s-%s", year, month, day)

        record["log_date"] = formatted_date
        record["log_time"] = log_data.time
        record["level_info"] = log_data.level
        record["log_datetime"] = formatted_date .. " " .. log_data.time
        record["message"] = log_data.message
        
        record["log"] = nil

        return 1, timestamp, record
    else
        return -1, timestamp, record
    end
end