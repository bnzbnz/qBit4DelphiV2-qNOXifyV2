(*****************************************************************************
The MIT License (MIT)

Copyright (c) 2020-2025 Laurent Meyer qBit@lmeyer.fr

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
******************************************************************************)
unit uqBit.API.Types;

interface
uses
    Classes
  , RTTI
  , uJX4Object
  , uJX4List
  , uJX4Dict
  ;

const

    CqBitAPI_WebAPIVersion = $020B03;

type

  TqBitBuildInfoType = class(TJX4Object)
    bitness : TValue; // Num
    boost : TValue; // Str
    libtorrent : TValue; // Str
    openssl : TValue; // Str
    qt : TValue; // Str
    zlib: TValue; // Str
  end;

  TqBitPreferencesType = class(TJX4Object)
  public
    add_stopped_enabled: TValue; // Bool
    add_to_top_of_queue: TValue; // Bool
    add_trackers: TValue; // TValue; // Str
    add_trackers_enabled: TValue; // Bool
    alt_dl_limit: TValue; // Num
    alt_up_limit: TValue; // Num
    alternative_webui_enabled: TValue; // Bool
    announce_ip: TValue; // Str
    announce_to_all_tiers: TValue; // Bool
    announce_to_all_trackers: TValue; // Bool
    anonymous_mode: TValue; // Bool
    app_instance_name: TValue; // Str
    async_io_threads: TValue; // Num
    auto_delete_mode: TValue; // Bool
    auto_tmm_enabled: TValue; // Bool
    autorun_enabled: TValue; // Bool
    autorun_on_torrent_added_enabled: TValue; // Bool
    autorun_on_torrent_added_program: TValue; // Str
    autorun_program: TValue; // Str
    banned_IPs: TValue; // Str
    bdecode_depth_limit: TValue; // Num
    bdecode_token_limit: TValue; // Num
    bittorrent_protocol: TValue; // Num
    block_peers_on_privileged_ports: TValue; // Bool
    bypass_auth_subnet_whitelist: TValue; // Str
    bypass_auth_subnet_whitelist_enabled: TValue; // Bool
    bypass_local_auth: TValue; // Bool
    category_changed_tmm_enabled: TValue; // Bool
    checking_memory_use: TValue; // Num
    connection_speed: TValue; // Num
    current_interface_address: TValue; // Str
    current_interface_name: TValue; // Str
    current_network_interface: TValue; // Str
    delete_torrent_content_files: TValue; // Bool
    dht: TValue; // Bool
    dht_bootstrap_nodes: TValue; // Str
    disk_cache: TValue; // Num
    disk_cache_ttl: TValue; // Num
    disk_io_read_mode: TValue; // Num
    disk_io_type: TValue; // Num
    disk_io_write_mode: TValue; // Num
    disk_queue_size: TValue; // Num
    dl_limit: TValue; // Num
    dont_count_slow_torrents: TValue; // Bool
    dyndns_domain: TValue; // Str
    dyndns_enabled: TValue; // Bool
    dyndns_password: TValue; // Str
    dyndns_service: TValue; // Num
    dyndns_username: TValue; // Str
    embedded_tracker_port: TValue; // Num
    embedded_tracker_port_forwarding: TValue; // Bool
    enable_coalesce_read_write: TValue; // Bool
    enable_embedded_tracker: TValue; // Bool
    enable_multi_connections_from_same_ip: TValue; // Bool
    enable_piece_extent_affinity: TValue; // Bool
    enable_upload_suggestions: TValue; // Bool
    encryption: TValue; // Num
    excluded_file_names: TValue; // Str
    excluded_file_names_enabled: TValue; // Bool
    export_dir: TValue; // Str
    export_dir_fin: TValue; // Str
    file_log_age: TValue; // Num
    file_log_age_type: TValue; // Num
    file_log_backup_enabled: TValue; // Bool
    file_log_delete_old: TValue; // Bool
    file_log_enabled: TValue; // Bool
    file_log_max_size: TValue; // Num
    file_log_path: TValue; // Str
    file_pool_size: TValue; // Num
    hashing_threads: TValue; // Num
    i2p_address: TValue; // Str
    i2p_enabled: TValue; // Bool
    i2p_inbound_length: TValue; // Num
    i2p_inbound_quantity: TValue; // Num
    i2p_mixed_mode: TValue; // Bool
    i2p_outbound_length: TValue; // Num
    i2p_outbound_quantity: TValue; // Num
    i2p_port: TValue; // Num
    idn_support_enabled: TValue; // Bool
    ignore_ssl_errors: TValue; // Bool
    incomplete_files_ext: TValue; // Bool
    ip_filter_enabled: TValue; // Bool
    ip_filter_path: TValue; // Str
    ip_filter_trackers: TValue; // Bool
    limit_lan_peers: TValue; // Bool
    limit_tcp_overhead: TValue; // Bool
    limit_utp_rate: TValue; // Bool
    listen_port: TValue; // Num
    locale: TValue; // Str
    lsd: TValue; // Bool
    mail_notification_auth_enabled: TValue; // Bool
    mail_notification_email: TValue; // Str
    mail_notification_enabled: TValue; // Bool
    mail_notification_password: TValue; // Str
    mail_notification_sender: TValue; // Str
    mail_notification_smtp: TValue; // Str
    mail_notification_ssl_enabled: TValue; // Bool
    mail_notification_username: TValue; // Str
    mark_of_the_web: TValue; // Bool
    max_active_checking_torrents: TValue; // Num
    max_active_downloads: TValue; // Num
    max_active_torrents: TValue; // Num
    max_active_uploads: TValue; // Num
    max_concurrent_http_announces: TValue; // Num
    max_connec: TValue; // Num
    max_connec_per_torrent: TValue; // Num
    max_inactive_seeding_time: TValue; // Num
    max_inactive_seeding_time_enabled: TValue; // Bool
    max_ratio: TValue; // Num
    max_ratio_act: TValue; // Num
    max_ratio_enabled: TValue; // Bool
    max_seeding_time: TValue; // Num
    max_seeding_time_enabled: TValue; // Bool
    max_uploads: TValue; // Num
    max_uploads_per_torrent: TValue; // Num
    memory_working_set_limit: TValue; // Num
    merge_trackers: TValue; // Bool
    outgoing_ports_max: TValue; // Num
    outgoing_ports_min: TValue; // Num
    peer_tos: TValue; // Num
    peer_turnover: TValue; // Num
    peer_turnover_cutoff: TValue; // Num
    peer_turnover_interval: TValue; // Num
    performance_warning: TValue; // Bool
    pex: TValue; // Bool
    preallocate_all: TValue; // Bool
    proxy_auth_enabled: TValue; // Bool
    proxy_bittorrent: TValue; // Bool
    proxy_hostname_lookup: TValue; // Bool
    proxy_ip: TValue; // Str
    proxy_misc: TValue; // Bool
    proxy_password: TValue; // Str
    proxy_peer_connections: TValue; // Bool
    proxy_port: TValue; // Num
    proxy_rss:  TValue; // Bool
    proxy_type: TValue; // Str
    proxy_username: TValue; // Str
    python_executable_path: TValue; // Str
    queueing_enabled: TValue; // Bool
    random_port: TValue; // Bool
    reannounce_when_address_changed: TValue; // Bool
    recheck_completed_torrents: TValue; // Bool
    refresh_interval: TValue; // Num
    request_queue_size: TValue; // Num
    resolve_peer_countries: TValue; // Bool
    resume_data_storage_type: TValue; // Str
    rss_auto_downloading_enabled: TValue; // Bool
    rss_download_repack_proper_episodes: TValue; // Bool
    rss_fetch_delay: TValue; // Num
    rss_max_articles_per_feed: TValue; // Num
    rss_processing_enabled: TValue; // Bool
    rss_refresh_interval: TValue; // Num
    rss_smart_episode_filters: TValue; // Str
    save_path: TValue; // Str
    save_path_changed_tmm_enabled: TValue; // Bool
    save_resume_data_interval: TValue; // Num
    scan_dirs: TJX4ValDict; // Num
    schedule_from_hour: TValue; // Num
    schedule_from_min: TValue; // Num
    scheduler_days: TValue; // Num
    scheduler_enabled: TValue; // Bool
    schedule_to_hour: TValue; // Num
    schedule_to_min: TValue; // Num
    send_buffer_watermark: TValue; // Num
    send_buffer_watermark_factor: TValue; // Num
    slow_torrent_dl_rate_threshold: TValue; // Num
    slow_torrent_inactive_timer: TValue; // Num
    slow_torrent_ul_rate_threshold: TValue; // Num
    socket_backlog_size: TValue; // Num
    socket_receive_buffer_size: TValue; // Num
    socket_send_buffer_size: TValue; // Num
    ssl_enabled: TValue; // Bool
    ssl_listen_port: TValue; // Bool
    ssrf_mitigation: TValue; // Bool
    stop_tracker_timeou: TValue; // Num
    temp_path: TValue; // Str
    temp_path_enabled: TValue; // Bool
    torrent_changed_tmm_enabled: TValue; // Bool
    torrent_content_layout: TValue; // Str
    torrent_content_remove_option: TValue; // Str
    torrent_file_size_limit: TValue; // Str
    torrent_stop_condition: TValue; // Str
    up_limit: TValue; // Num
    upload_choking_algorithm: TValue; // Num
    upload_slots_behavior: TValue; // Num
    upnp: TValue; // Bool
    upnp_lease_duration: TValue; // Num
    use_category_paths_in_manual_mode: TValue; // Bool
    use_https: TValue; // Bool
    use_subcategories: TValue; // Bool
    use_unwanted_folder: TValue; // Bool
    utp_tcp_mixed_mode: TValue; // Num
    validate_https_tracker_certificate: TValue; // Bool
    web_ui_address: TValue; // Str
    web_ui_ban_duration: TValue; // Num
    web_ui_clickjacking_protection_enabled: TValue; // Bool
    web_ui_csrf_protection_enabled: TValue; // Bool
    web_ui_custom_http_headers: TValue; // Str
    web_ui_domain_list: TValue; // Str
    web_ui_host_header_validation_enabled: TValue; // Bool
    web_ui_https_cert_path: TValue; // Str
    web_ui_https_key_path: TValue; // Str
    web_ui_max_auth_fail_count: TValue; // Num
    web_ui_port: TValue; // Num
    web_ui_reverse_proxies_list: TValue; // Str
    web_ui_reverse_proxy_enabled: TValue; // Bool
    web_ui_secure_cookie_enabled: TValue; // Bool
    web_ui_session_timeout: TValue; // Num
    web_ui_upnp: TValue; // Bool
    web_ui_use_custom_http_headers_enabled: TValue; // Bool
    web_ui_username: TValue; // Str
  end;

  TqBitLogType = class(TJX4Object)
    id: TValue; // Num
    &message: TValue; // Str
    timestamp: TValue; // Num
    &type: TValue; // Num
  end;

  TqBitLogsType = class(TJX4Object)
    logs: TJX4List<TqBitLogType>;
  end;

  TqBitPeerLogType = class(TJX4Object)
    blocked: variant;
    id: variant;
    ip: variant;
    reason: variant;
    timestamp: variant;
  end;

  TqBitPeerLogsType = class(TJX4Object)
    logs: TJX4List<TqBitPeerLogType>;
  end;

  TqBitTrackerType = class(TJX4Object)
    msg: TValue; // Str
    num_downloaded: TValue; // Num
    num_leeches: TValue; // Num
    num_peers: TValue; // Num
    num_seeds: TValue; // Num
    status: TValue; // Num
    tier: TValue; // Num
    url: TValue; // Str
    // Custom Fields:
    hash: TValue;
  end;

  TqBitTrackersType  = class(TJX4Object)
    trackers: TJX4List<TqBitTrackerType>;
  end;

  TqBitTorrentType = class(TJX4Object)
    added_on: TValue; // Num
    amount_left: TValue; // Num
    auto_tmm: TValue; // Bool
    availability: TValue; // Num
    category: TValue; // Str
    comment: TValue; // Str
    completed: TValue; // Num
    completion_on: TValue; // Num
    content_path: TValue; // Str
    dl_limit: TValue; // Num
    dlspeed: TValue; // Num
    download_path: TValue; // Str
    downloaded: TValue; // Num
    downloaded_session: TValue; // Num
    eta: TValue; // Num
    f_l_piece_prio: TValue; // Bool
    force_start: TValue; // Bool
    has_metadata: TValue; // Bool
    inactive_seeding_time_limit: TValue; // Num
    infohash_v1: TValue; // Str
    infohash_v2: TValue; // Str
    last_activity: TValue; // Num
    magnet_uri: TValue; // Str
    max_inactive_seeding_time: TValue; // Num
    max_ratio: TValue; // Num
    max_seeding_time: TValue; // Num
    name: TValue; // Str
    num_complete: TValue; // Num
    num_incomplete: TValue; // Num
    num_leechs: TValue; // Num
    num_seeds: TValue; // Num
    popularity: TValue; // Num
    priority: TValue; // Num
    &private: TValue; // Bool
    progress: TValue; // Num
    ratio: TValue; // Num
    ratio_limit: TValue; // Num
    reannounce: TValue; // Num
    root_path: TValue; // Str
    save_path: TValue; // Str
    seeding_time: TValue; // Num
    seeding_time_limit: TValue; // Num
    seen_complete: TValue; // Num
    seq_dl: TValue; // Bool
    size: TValue; // Num
    state: TValue; // Str
    super_seeding: TValue; // Bool
    tags: TValue; // Str
    time_active: TValue; // Num
    total_size: TValue; // Num
    tracker: TValue; // Str
    trackers_count: TValue; // Num
    up_limit: TValue; // Num
    uploaded: TValue; // Num
    uploaded_session: TValue; // Num
    upspeed: TValue; // Num
    // Custom Fields:
    hash: TValue; // Str
  end;

  TqBitserver_stateType = class(TJX4Object)
    alltime_dl: TValue; // Num
    alltime_ul: TValue; // Num
    average_time_queue: TValue; // Num
    connection_status: TValue; // Str
    dht_nodes: TValue; // Num
    dl_info_data: TValue; // Num
    dl_info_speed: TValue; // Num
    dl_rate_limit: TValue; // Num
    free_space_on_disk: TValue; // Num
    global_ratio: TValue; // Num
    queued_io_jobs: TValue; // Num
    queueing: TValue; // Bool
    read_cache_hits: TValue; // Num  // Libtorrent 1x Only
    read_cache_overload: TValue; // Num
    refresh_interval: TValue; // Num
    total_buffers_size: TValue; // Num
    total_peer_connections: TValue; // Num
    total_queued_size: TValue; // Num
    total_wasted_session: TValue; // Num
    up_info_data: TValue; // Num
    up_info_speed: TValue; // Num
    up_rate_limit: TValue; // Num
    use_alt_speed_limits: TValue; // Num
    use_subcategories: TValue; // Bool
    write_cache_overload: TValue; // Num
  end;

  TqBitCategoryType = class(TJX4Object)
    download_path: TValue; // Str // Default = null, No = false, Yes = TValue; // String value
    name: TValue; // Str
    savePath: TValue; // Str
  end;

  TqBitMainDataType = class(TJX4Object)
  public
    categories: TJX4Dict<TqBitCategoryType>;
    categories_removed: TJX4ValList; // Str>;
    full_update: TValue; // Bool
    rid: TValue; // Num
    server_state: TqBitserver_stateType;
    tags: TJX4ValList; // Str>;
    tags_removed: TJX4ValList; // Str>;
    torrents: TJX4Dict<TqBitTorrentType>;
    torrents_removed: TJX4ValList; // Str>;
    trackers: TJX4Dict<TJX4ValList>; // Str
    trackers_removed: TJX4ValList; // Str;
    procedure Merge(From: TqBitMainDataType);
  end;

  TqBitNetworkInterfaceType = class(TJX4Object)
    name: TValue; // Str
    value: TValue; // Str
  end;

  TqBitNetworkInterfacesType = class(TJX4Object)
    ifaces: TJX4List<TqBitNetworkInterfaceType>;
  end;

  TqBitNetworkInterfaceAddressesType = class(TJX4Object)
    adresses: TJX4ValList; // Str>;
  end;

  TqBitTorrentPeerDataType = class(TJX4Object)
    client: TValue; // Str
    connection: TValue; // Str
    country: TValue; // Str
    country_code: TValue; // Str
    dl_speed: TValue; // Num
    downloaded: TValue; // Num
    files: TValue; // Str
    flags: TValue; // Str
    flags_desc: TValue; // Str
    ip: TValue; // Str
    peer_id_client: TValue; // Num
    port: TValue; // Num
    progress:TValue; // Num
    relevance: TValue; // Num
    up_speed: TValue; // Num
    uploaded: TValue; // Num
    // Custom Fields
    hash: TValue;
  end;

  TqBitTorrentPeersDataType = class(TJX4Object)
    full_update: TValue; // Bool
    peers: TJX4Dict<TqBitTorrentPeerDataType>;
    rid: TValue; // Num
    show_flags: TValue; // Bool
    peers_removed: TJX4ValList;
    // Custom Fields
    procedure Merge(From: TqBitTorrentPeersDataType);
  end;

  TqBitGlobalTransferInfoType = class(TJX4Object)
    connection_status: TValue; // Str
    dht_nodes: TValue; // Num
    dl_info_data	: TValue; // Num
    dl_info_speed: TValue; // Num
    dl_rate_limit: TValue; // Num
    queueing: TValue; // Bool
    refresh_interval: TValue; // Num
    up_info_data: TValue; // Num
    up_info_speed: TValue; // Num
    up_rate_limit: TValue; // Num
    use_alt_speed_limits: TValue; // Bool
  end;

  TqBitTorrentsListType = class(TJX4Object)
    torrents: TJX4List<TqBitTorrentType>
  end;

 TqBitTorrentListRequestType = class(TJX4Object)
    category: string; // Str
    filter: string; // Str
    hashes: TStringList; // Str
    limit: Integer; // Num
    offset: Integer; // Num
    reverse: Boolean; // Bool
    sort: string; // Str
    tag: string; // Str
    constructor Create;
  end;

  TqBitTorrentInfoType = class(TJX4Object)
    &private: TValue; // Bool
    addition_date: TValue; // Num
    comment: TValue; // Str
    completion_date: TValue; // Num
    created_by: TValue; // Str
    creation_date: TValue; // Num
    dl_limit: TValue; // Num
    dl_speed_avg:  TValue; // Num
    dl_speed:  TValue; // Num
    download_path: TValue; // Str
    eta: TValue; // Num
    has_metadata: TValue; // Bool
    hash: TValue; // Str
    infohash_v1: TValue; // Str
    infohash_v2: TValue; // Str
    is_private: TValue; // Bool
    last_seen: TValue; // Num
    name: TValue; // Str
    nb_connections_limit: TValue; // Num
    nb_connections: TValue; // Num
    peers_total: TValue; // Num
    peers: TValue; // Num
    piece_size: TValue; // Num
    pieces_have: TValue; // Num
    pieces_num: TValue; // Num
    popularity: TValue; // Num
    reannounce: TValue; // Num
    save_path: TValue; // Str
    seeding_time: TValue; // Num
    seeds_total: TValue; // Num
    seeds: TValue; // Num
    share_ratio: TValue; // Num
    time_elapsed: TValue; // Num
    total_downloaded_session: TValue; // Num
    total_downloaded: TValue; // Num
    total_size: TValue; // Num
    total_uploaded_session: TValue; // Num
    total_uploaded: TValue; // Num
    total_wasted: TValue; // Num
    up_limit: TValue; // Num
    up_speed_avg: TValue; // Num
    up_speed: TValue; // Num
  end;

  TqBitWebSeedType  = class(TJX4Object)
    url: TValue; // Str
  end;

  TqBitWebSeedsType  = class(TJX4Object)
    urls: TJX4List<TqBitWebSeedType>;
  end;

  TqBitContentType = class(TJX4Object)
    availability: TValue; // Num
    index: TValue; // Num
    is_seed: TValue; // Bool
    name: TValue; // Str
    piece_range: TJX4ValList; // Num
    priority: TValue; // Num
    progress: TValue; // Num
    size: TValue; // Num
  end;

  TqBitContentsType = class(TJX4Object)
    contents: TJX4List<TqBitContentType>;
  end;

  TqBitPiecesStatesType = class(TJX4Object)
    states: TJX4ValList; // Str>;
  end;

  TqBitNewTorrentUrlsType = class
    autoTMM: TValue; // Bool
    category: TValue; // Str
    contentLayout: TValue; // Str
    cookie: TValue; // Str
    dlLimit: TValue;
    firstLastPiecePrio: TValue; // Bool
    rename: TValue; // Str
    savePath : TValue; // Str
    sequentialDownload: TValue; // Bool
    skip_Checking: TValue; // Bool
    stopCondition: TValue; // Str
    stopped: TValue; // Bool
    upLimit: TValue;
    urls: TStringList; // Str
    constructor Create; overload;
  end;

  TqBitNewTorrentFileType = class
    addToTopOfQueue: TValue; // Bool
    autoTMM: TValue; // Bool
    category: TValue; // Str
    contentLayout: TValue; // Str
    dlLimit: TValue;
    filename: TValue; // Str
    firstLastPiecePrio: TValue; // Bool
    rename: TValue; // Str
    savePath : TValue; // Str
    sequentialDownload: TValue; // Bool
    skip_Checking: TValue; // Bool
    stopCondition: TValue; //Str
    stopped: TValue; // Bool
    upLimit: TValue;
    constructor Create; overload;
  end;

  TqBitTorrentSpeedsLimitType = class(TJX4Object)
    speeds: TJX4ValDic; // Num
  end;

  TqBitCategoriesType  = class(TJX4Object)
    categories: TJX4Dic<TqBitCategoryType>;
  end;

  TqBitTagsType = class(TJX4Object)
    tags: TJX4ValList; // Str
  end;

  TqBitRSSArticleType = class(TJX4Object)
    category: TValue;
    data: TValue;
    description: TValue;
    id: TValue;
    link: TValue;
    title: TValue;
    torrentURL: TValue;
  end;

  TqBitRSSItemType = class(TJX4Object)
    articles: TJX4List<TqBitRSSArticleType>;
    isLoading: TValue;
    lastBuildDate: TValue;
    title: TValue;
    uid: TValue;
    url: TValue;
  end;

  TqBitRSSAllItemsType = class(TJX4Object)
    Fitems: TJX4Dic<TqBitRSSItemType>;
  end;

  TqBitRSSRuleType  = class(TJX4Object)
    addPaused: TValue;
    assignedCategory: TValue;
    enabled: TValue;
    episodeFilter: TValue;
    FaffectedFeeds: TJX4ValList;
    ignoreDays: TValue;
    lastMatch : TValue;
    mustContain: TValue;
    mustNotContain: TValue;
    previouslyMatchedEpisodes: TValue;
    savePath: TValue;
    smartFilter: TValue;
    useRegex: TValue;
  end;

  TqBitRSSAllRulesType = class(TJX4Object)
    rules: TJX4Dic<TqBitRSSRuleType>;
  end;

  TqBitAutoDownloadingRulesType = class(TJX4Object)
    rules: TJX4Dic<TqBitRSSRuleType>;
  end;

  TqBitRSSArticlesType = class(TJX4Object)
    articles: TJX4Dic<TStringList>;
  end;

implementation

constructor TqBitTorrentListRequestType.Create;
begin
  inherited;
  Hashes.StrictDelimiter := True;
  Hashes.QuoteChar := #0;
  Hashes.Delimiter:='|';
end;

constructor TqBitNewTorrentUrlsType.Create;
begin
  inherited;
  upLimit := -1;
  dlLimit := -1;
  contentLayout := 'Original';
  stopCondition := 'None';
end;

constructor TqBitNewTorrentFileType.Create;
begin
  inherited;
  upLimit := -1;
  dlLimit := -1;
  contentLayout := 'Original';
  stopCondition := 'None';
end;

////////////////////////////////////////////////////////////////////////////////

procedure TqBitMainDataType.Merge(From: TqBitMainDataType);
begin
  rid := From.rid;
  server_state.Merge(From.server_state, [jmoAdd, jmoUpdate]);

  tags.Merge(From.tags, [jmoAdd, jmoUpdate, jmoDelete]);
  tags_removed.Merge(From.tags_removed, [jmoAdd, jmoDelete]);

  categories.Merge(From.categories, [jmoAdd, jmoUpdate, jmoDelete]);
  categories_removed.Merge(From.categories_removed, [jmoAdd, jmoDelete]);

  torrents.Merge(From.torrents, [jmoAdd, jmoUpdate]);
  torrents.Merge(From.torrents_removed, [jmoDelete]);
end;

procedure TqBitTorrentPeersDataType.Merge(From: TqBitTorrentPeersDataType);
begin
  Self.full_update := From.full_update;
  Self.rid := From.rid;
  Self.show_flags := From.show_flags;
  Self.peers.Merge(From.peers, [jmoUpdate,  jmoAdd]);
  Self.peers.Merge(From.peers_removed, [jmoDelete]);
end;

end.
