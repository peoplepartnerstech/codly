use sqlx::postgres::{PgPool, PgPoolOptions};
use std::time::Duration;

pub async fn create_pool(database_url: &str) -> anyhow::Result<PgPool> {
    let pool = PgPoolOptions::new()
        .max_connections(10)
        .acquire_timeout(Duration::from_secs(30))
        .connect(database_url)
        .await?;

    // Test the connection
    sqlx::query("SELECT 1")
        .execute(&pool)
        .await?;

    Ok(pool)
}
