use axum::{extract::State, response::Json};
use serde_json::json;
use sqlx::PgPool;

pub async fn health_check(State(pool): State<PgPool>) -> Json<serde_json::Value> {
    // Test database connection
    let db_status = sqlx::query("SELECT 1")
        .execute(&pool)
        .await
        .map(|_| "connected")
        .unwrap_or_else(|_| "disconnected");

    Json(json!({
        "status": "ok",
        "service": "codly-backend",
        "database": db_status
    }))
}
