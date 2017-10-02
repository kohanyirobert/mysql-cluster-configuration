use information_schema
\G

select
  lock_wait.blocking_trx_id as lock_wait_blocking_trx_id,
  lock_wait.blocking_lock_id as lock_wait_blocking_lock_id,
  lock_wait.requesting_trx_id as lock_wait_requesting_trx_id,
  lock_wait.requested_lock_id as lock_wait_requested_lock_id,

  blocking_trx.trx_id as blocking_trx_id,
  blocking_trx.trx_mysql_thread_id as blocking_trx_mysql_thread_id,
  blocking_trx.trx_query as blocking_trx_query,
  blocking_trx.trx_state as blocking_trx_state,
  blocking_trx.trx_started as blocking_trx_started,
  blocking_trx.trx_wait_started as blocking_trx_wait_started,
/*!55250
  blocking_trx.trx_operation_state as blocking_trx_operation_state,
  blocking_trx.trx_tables_in_use as blocking_trx_tables_in_use,
  blocking_trx.trx_tables_locked as blocking_trx_tables_locked, 
  blocking_trx.trx_rows_modified as blocking_trx_rows_modified,
  blocking_trx.trx_isolation_level as blocking_trx_isolation_level,
  blocking_trx.trx_is_read_only as blocking_trx_is_read_only,
  requesting_trx.trx_autocommit_non_locking as requesting_trx_autocommit_non_locking,
*/

  blocking_lock.lock_id as blocking_lock_lock_id,
  blocking_lock.lock_trx_id as blocking_lock_lock_trx_id,
  blocking_lock.lock_mode as blocking_lock_lock_mode,
  blocking_lock.lock_type as blocking_lock_lock_type,
  blocking_lock.lock_table as blocking_lock_lock_table,
  blocking_lock.lock_data as blocking_lock_lock_data,

  blocking_process.id as blocking_process_id,
  blocking_process.user as blocking_process_user,
  blocking_process.host as blocking_process_host,
  blocking_process.db as blocking_process_db,
  blocking_process.command as blocking_process_command,
  blocking_process.time as blocking_process_time,
  blocking_process.state as blocking_process_state,
  blocking_process.info as blocking_process_info,

  requesting_trx.trx_id as requesting_trx_id,
  requesting_trx.trx_mysql_thread_id as requesting_trx_mysql_thread_id,
  requesting_trx.trx_query as requesting_trx_query,
  requesting_trx.trx_state as requesting_trx_state,
  requesting_trx.trx_started as requesting_trx_started,
  requesting_trx.trx_wait_started as requesting_trx_wait_started,
/*!55250 
  requesting_trx.trx_operation_state as requesting_trx_operation_state,
  requesting_trx.trx_tables_in_use as requesting_trx_tables_in_use,
  requesting_trx.trx_tables_locked as requesting_trx_tables_locked,
  requesting_trx.trx_rows_modified as requesting_trx_rows_modified,
  requesting_trx.trx_isolation_level as requesting_trx_isolation_level,
  requesting_trx.trx_is_read_only as requesting_trx_is_read_only,
  requesting_trx.trx_autocommit_non_locking as requesting_trx_autocommit_non_locking,
*/

  requested_lock.lock_id as requested_lock_lock_id,
  requested_lock.lock_trx_id as requested_lock_lock_trx_id,
  requested_lock.lock_mode as requested_lock_lock_mode,
  requested_lock.lock_type as requested_lock_lock_type,
  requested_lock.lock_table as requested_lock_lock_table,
  requested_lock.lock_data as requested_lock_lock_data,

  requesting_process.id as requesting_process_id,
  requesting_process.user as requesting_process_user,
  requesting_process.host as requesting_process_host,
  requesting_process.db as requesting_process_db,
  requesting_process.command as requesting_process_command,
  requesting_process.time as requesting_process_time,
  requesting_process.state as requesting_process_state,
  requesting_process.info as requesting_process_info

from
  innodb_lock_waits as lock_wait

  join innodb_trx as blocking_trx
    on blocking_trx.trx_id = lock_wait.blocking_trx_id

  join innodb_locks as blocking_lock
    on blocking_lock.lock_id = lock_wait.blocking_lock_id
      and blocking_lock.lock_trx_id = lock_wait.blocking_trx_id

  join processlist as blocking_process
    on blocking_process.id = blocking_trx.trx_mysql_thread_id

  join innodb_trx as requesting_trx
    on requesting_trx.trx_id = lock_wait.requesting_trx_id

  join innodb_locks as requested_lock
    on requested_lock.lock_id = lock_wait.requested_lock_id
      and requested_lock.lock_trx_id = lock_wait.requesting_trx_id

  join processlist as requesting_process
    on requesting_process.id = requesting_trx.trx_mysql_thread_id

order by
  blocking_trx_started
\G
