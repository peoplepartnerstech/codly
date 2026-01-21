use std::env;

#[derive(Debug, Clone)]
pub struct Config {
    pub database_url: String,
    pub server_address: String,
    #[allow(dead_code)]
    pub jwt_secret: String,
    #[allow(dead_code)]
    pub jwt_expiration_hours: u64,
}

impl Config {
    pub fn from_env() -> anyhow::Result<Self> {
        Ok(Self {
            database_url: env::var("DATABASE_URL")
                .expect("DATABASE_URL must be set"),
            server_address: env::var("SERVER_ADDRESS")
                .unwrap_or_else(|_| "0.0.0.0:3000".to_string()),
            jwt_secret: env::var("JWT_SECRET")
                .expect("JWT_SECRET must be set"),
            jwt_expiration_hours: env::var("JWT_EXPIRATION_HOURS")
                .unwrap_or_else(|_| "24".to_string())
                .parse()
                .unwrap_or(24),
        })
    }
}
