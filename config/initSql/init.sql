CREATE DATABASE IF NOT EXISTS wvp DEFAULT CHARACTER SET utf8mb4;
USE wvp;

/*建表*/
CREATE TABLE wvp_device (
    id INT AUTO_INCREMENT PRIMARY KEY,
    device_id VARCHAR(50) NOT NULL,
    name VARCHAR(255),
    manufacturer VARCHAR(255),
    model VARCHAR(255),
    firmware VARCHAR(255),
    transport VARCHAR(50),
    stream_mode VARCHAR(50),
    on_line BOOLEAN DEFAULT FALSE,
    register_time VARCHAR(50),
    keepalive_time VARCHAR(50),
    ip VARCHAR(50),
    create_time VARCHAR(50),
    update_time VARCHAR(50),
    port INTEGER,
    expires INTEGER,
    subscribe_cycle_for_catalog INTEGER DEFAULT 0,
    subscribe_cycle_for_mobile_position INTEGER DEFAULT 0,
    mobile_position_submission_interval INTEGER DEFAULT 5,
    subscribe_cycle_for_alarm INTEGER DEFAULT 0,
    host_address VARCHAR(50),
    charset VARCHAR(50),
    ssrc_check BOOLEAN DEFAULT FALSE,
    geo_coord_sys VARCHAR(50),
    media_server_id VARCHAR(50),
    custom_name VARCHAR(255),
    sdp_ip VARCHAR(50),
    local_ip VARCHAR(50),
    password VARCHAR(255),
    as_message_channel BOOLEAN DEFAULT FALSE,
    keepalive_interval_time INTEGER,
    broadcast_push_after_ack BOOLEAN DEFAULT FALSE,
    CONSTRAINT uk_device_device UNIQUE (device_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE wvp_device_alarm (
    id INT AUTO_INCREMENT PRIMARY KEY,
    device_id VARCHAR(50) NOT NULL,
    channel_id VARCHAR(50) NOT NULL,
    alarm_priority VARCHAR(50),
    alarm_method VARCHAR(50),
    alarm_time VARCHAR(50),
    alarm_description VARCHAR(255),
    longitude DOUBLE,
    latitude DOUBLE,
    alarm_type VARCHAR(50),
    create_time VARCHAR(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE wvp_device_channel (
    id INT AUTO_INCREMENT PRIMARY KEY,
    channel_id VARCHAR(50) NOT NULL,
    name VARCHAR(255),
    custom_name VARCHAR(255),
    manufacture VARCHAR(50),
    model VARCHAR(50),
    owner VARCHAR(50),
    civil_code VARCHAR(50),
    block VARCHAR(50),
    address VARCHAR(50),
    parent_id VARCHAR(50),
    safety_way INTEGER,
    register_way INTEGER,
    cert_num VARCHAR(50),
    certifiable INTEGER,
    err_code INTEGER,
    end_time VARCHAR(50),
    secrecy VARCHAR(50),
    ip_address VARCHAR(50),
    port INTEGER,
    password VARCHAR(255),
    ptz_type INTEGER,
    custom_ptz_type INTEGER,
    status BOOLEAN DEFAULT FALSE,
    longitude DOUBLE,
    custom_longitude DOUBLE,
    latitude DOUBLE,
    custom_latitude DOUBLE,
    stream_id VARCHAR(255),
    device_id VARCHAR(50) NOT NULL,
    parental VARCHAR(50),
    has_audio BOOLEAN DEFAULT FALSE,
    create_time VARCHAR(50) NOT NULL,
    update_time VARCHAR(50) NOT NULL,
    sub_count INTEGER,
    longitude_gcj02 DOUBLE,
    latitude_gcj02 DOUBLE,
    longitude_wgs84 DOUBLE,
    latitude_wgs84 DOUBLE,
    business_group_id VARCHAR(50),
    gps_time VARCHAR(50),
    stream_identification VARCHAR(50),
    CONSTRAINT uk_wvp_device_channel_unique_device_channel UNIQUE (device_id, channel_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE wvp_device_mobile_position (
    id INT AUTO_INCREMENT PRIMARY KEY,
    device_id VARCHAR(50) NOT NULL,
    channel_id VARCHAR(50) NOT NULL,
    device_name VARCHAR(255),
    time VARCHAR(50),
    longitude DOUBLE,
    latitude DOUBLE,
    altitude DOUBLE,
    speed DOUBLE,
    direction DOUBLE,
    report_source VARCHAR(50),
    longitude_gcj02 DOUBLE,
    latitude_gcj02 DOUBLE,
    longitude_wgs84 DOUBLE,
    latitude_wgs84 DOUBLE,
    create_time VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE wvp_gb_stream (
    gb_stream_id INT AUTO_INCREMENT PRIMARY KEY,
    app VARCHAR(255) NOT NULL,
    stream VARCHAR(255) NOT NULL,
    gb_id VARCHAR(50) NOT NULL,
    name VARCHAR(255),
    longitude DOUBLE,
    latitude DOUBLE,
    stream_type VARCHAR(50),
    media_server_id VARCHAR(50),
    create_time VARCHAR(50),
    CONSTRAINT uk_gb_stream_unique_gb_id UNIQUE (gb_id),
    CONSTRAINT uk_gb_stream_unique_app_stream UNIQUE (app, stream)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE wvp_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    type VARCHAR(50),
    uri VARCHAR(200),
    address VARCHAR(50),
    result VARCHAR(50),
    timing BIGINT,
    username VARCHAR(50),
    create_time VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE wvp_media_server (
    id VARCHAR(255) PRIMARY KEY,
    ip VARCHAR(50),
    hook_ip VARCHAR(50),
    sdp_ip VARCHAR(50),
    stream_ip VARCHAR(50),
    http_port INTEGER,
    http_ssl_port INTEGER,
    rtmp_port INTEGER,
    rtmp_ssl_port INTEGER,
    rtp_proxy_port INTEGER,
    rtsp_port INTEGER,
    rtsp_ssl_port INTEGER,
    flv_port INTEGER,
    flv_ssl_port INTEGER,
    ws_flv_port INTEGER,
    ws_flv_ssl_port INTEGER,
    auto_config BOOLEAN DEFAULT FALSE,
    secret VARCHAR(50),
    type VARCHAR(50) DEFAULT 'zlm',
    rtp_enable BOOLEAN DEFAULT FALSE,
    rtp_port_range VARCHAR(50),
    send_rtp_port_range VARCHAR(50),
    record_assist_port INTEGER,
    default_server BOOLEAN DEFAULT FALSE,
    create_time VARCHAR(50),
    update_time VARCHAR(50),
    hook_alive_interval INTEGER,
    record_path VARCHAR(255),
    record_day INTEGER DEFAULT 7,
    transcode_suffix VARCHAR(255),
    CONSTRAINT uk_media_server_unique_ip_http_port UNIQUE (ip, http_port)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE wvp_platform (
    id INT AUTO_INCREMENT PRIMARY KEY,
    enable BOOLEAN DEFAULT FALSE,
    name VARCHAR(255),
    server_gb_id VARCHAR(50),
    server_gb_domain VARCHAR(50),
    server_ip VARCHAR(50),
    server_port INTEGER,
    device_gb_id VARCHAR(50),
    device_ip VARCHAR(50),
    device_port VARCHAR(50),
    username VARCHAR(255),
    password VARCHAR(50),
    expires VARCHAR(50),
    keep_timeout VARCHAR(50),
    transport VARCHAR(50),
    character_set VARCHAR(50),
    catalog_id VARCHAR(50),
    ptz BOOLEAN DEFAULT FALSE,
    rtcp BOOLEAN DEFAULT FALSE,
    status BOOLEAN DEFAULT FALSE,
    start_offline_push BOOLEAN DEFAULT FALSE,
    administrative_division VARCHAR(50),
    catalog_group INTEGER,
    create_time VARCHAR(50),
    update_time VARCHAR(50),
    as_message_channel BOOLEAN DEFAULT FALSE,
    auto_push_channel BOOLEAN DEFAULT FALSE,
    send_stream_ip VARCHAR(50),
    CONSTRAINT uk_platform_unique_server_gb_id UNIQUE (server_gb_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE wvp_platform_catalog (
    id VARCHAR(50),
    platform_id VARCHAR(50),
    name VARCHAR(255),
    parent_id VARCHAR(50),
    civil_code VARCHAR(50),
    business_group_id VARCHAR(50),
    CONSTRAINT uk_platform_catalog_id_platform_id UNIQUE (id, platform_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE wvp_platform_gb_channel (
    id INT AUTO_INCREMENT PRIMARY KEY,
    platform_id VARCHAR(50),
    catalog_id VARCHAR(50),
    device_channel_id INTEGER,
    CONSTRAINT uk_platform_gb_channel_platform_id_catalog_id_device_channel_id UNIQUE (platform_id, catalog_id, device_channel_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE wvp_platform_gb_stream (
    id INT AUTO_INCREMENT PRIMARY KEY,
    platform_id VARCHAR(50),
    catalog_id VARCHAR(50),
    gb_stream_id INTEGER,
    CONSTRAINT uk_platform_gb_stream_platform_id_catalog_id_gb_stream_id UNIQUE (platform_id, catalog_id, gb_stream_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE wvp_stream_proxy (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(50),
    app VARCHAR(255),
    stream VARCHAR(255),
    url VARCHAR(255),
    src_url VARCHAR(255),
    dst_url VARCHAR(255),
    timeout_ms INTEGER,
    ffmpeg_cmd_key VARCHAR(255),
    rtp_type VARCHAR(50),
    media_server_id VARCHAR(50),
    enable_audio BOOLEAN DEFAULT FALSE,
    enable_mp4 BOOLEAN DEFAULT FALSE,
    enable BOOLEAN DEFAULT FALSE,
    status BOOLEAN,
    enable_remove_none_reader BOOLEAN DEFAULT FALSE,
    create_time VARCHAR(50),
    name VARCHAR(255),
    update_time VARCHAR(50),
    stream_key VARCHAR(255),
    enable_disable_none_reader BOOLEAN DEFAULT FALSE,
    CONSTRAINT uk_stream_proxy_app_stream UNIQUE (app, stream)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE wvp_stream_push (
    id INT AUTO_INCREMENT PRIMARY KEY,
    app VARCHAR(255),
    stream VARCHAR(255),
    total_reader_count VARCHAR(50),
    origin_type INTEGER,
    origin_type_str VARCHAR(50),
    create_time VARCHAR(50),
    alive_second INTEGER,
    media_server_id VARCHAR(50),
    server_id VARCHAR(50),
    push_time VARCHAR(50),
    status BOOLEAN DEFAULT FALSE,
    update_time VARCHAR(50),
    push_ing BOOLEAN DEFAULT FALSE,
    self BOOLEAN DEFAULT FALSE,
    CONSTRAINT uk_stream_push_app_stream UNIQUE (app, stream)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE wvp_cloud_record (
    id INT AUTO_INCREMENT PRIMARY KEY,
    app VARCHAR(255),
    stream VARCHAR(255),
    call_id VARCHAR(255),
    start_time BIGINT,
    end_time BIGINT,
    media_server_id VARCHAR(50),
    file_name VARCHAR(255),
    folder VARCHAR(255),
    file_path VARCHAR(255),
    collect BOOLEAN DEFAULT FALSE,
    file_size BIGINT,
    time_len BIGINT,
    CONSTRAINT uk_stream_push_app_stream_path UNIQUE (app, stream, file_path)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE wvp_user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255),
    password VARCHAR(255),
    role_id INTEGER,
    create_time VARCHAR(50),
    update_time VARCHAR(50),
    push_key VARCHAR(50),
    CONSTRAINT uk_user_username UNIQUE (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE wvp_user_role (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    authority VARCHAR(50),
    create_time VARCHAR(50),
    update_time VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE wvp_resources_tree (
    id INT AUTO_INCREMENT PRIMARY KEY,
    is_catalog BOOLEAN DEFAULT TRUE,
    device_channel_id INTEGER,
    gb_stream_id INTEGER,
    name VARCHAR(255),
    parentId INTEGER,
    path VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE wvp_user_api_key (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT,
    app VARCHAR(255),
    api_key TEXT,
    expired_at BIGINT,
    remark VARCHAR(255),
    enable BOOLEAN DEFAULT TRUE,
    create_time VARCHAR(50),
    update_time VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*初始数据*/
INSERT INTO wvp_user VALUES (1, 'admin','21232f297a57a5a743894a0e4a801fc3',1,'2021-04-13 14:14:57','2021-04-13 14:14:57','3e80d1762a324d5b0ff636e0bd16f1e3');
INSERT INTO wvp_user_role VALUES (1, 'admin','0','2021-04-13 14:14:57','2021-04-13 14:14:57');