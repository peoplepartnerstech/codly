use axum::{
    http::Method,
    Router,
};
use tower_http::cors::{Any, CorsLayer};
use tower_http::trace::TraceLayer;
use tracing_subscriber::{layer::SubscriberExt, util::SubscriberInitExt};

mod config;
mod db;
mod error;
mod middleware;
mod routes;

use config::Config;
use db::create_pool;

#[tokio::main]
async fn main() -> anyhow::Result<()> {
    // Load environment variables
    dotenv::dotenv().ok();

    // Initialize tracing
    tracing_subscriber::registry()
        .with(
            tracing_subscriber::EnvFilter::try_from_default_env()
                .unwrap_or_else(|_| "codly_backend=debug,tower_http=debug".into()),
        )
        .with(tracing_subscriber::fmt::layer())
        .init();

    // Load configuration
    let config = Config::from_env()?;
    tracing::info!("Configuration loaded successfully");

    // Create database connection pool
    let pool = create_pool(&config.database_url).await?;
    tracing::info!("Database connection pool created");

    // Build application with routes
    let app = create_router(pool).await?;

    // Start server
    let listener = tokio::net::TcpListener::bind(&config.server_address).await?;
    tracing::info!("Server listening on {}", config.server_address);

    axum::serve(listener, app).await?;

    Ok(())
}

async fn create_router(pool: sqlx::PgPool) -> anyhow::Result<Router> {
    // Configure CORS
    let cors = CorsLayer::new()
        .allow_origin(Any)
        .allow_methods([Method::GET, Method::POST, Method::PUT, Method::DELETE, Method::PATCH])
        .allow_headers(Any);

    // Build router
    let router = Router::new()
        .nest("/api", routes::create_api_router(pool.clone()))
        .layer(cors)
        .layer(TraceLayer::new_for_http());

    Ok(router)
}
