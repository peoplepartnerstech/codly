use axum::{routing::get, Router};
use sqlx::PgPool;

pub mod health;

pub fn create_api_router(pool: PgPool) -> Router {
    Router::new()
        .route("/health", get(health::health_check))
        .with_state(pool)
}
