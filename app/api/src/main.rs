// @req REQ-INFRA-002 API health endpoint
mod health;
use actix_web::{web, App, HttpResponse, HttpServer, Responder};
use sqlx::postgres::PgPoolOptions;

async fn root() -> impl Responder {
    HttpResponse::Ok().json(serde_json::json!({
        "name": "SDD Navigator API",
        "version": "0.1.0",
        "endpoints": [
            "/",
            "/health",
            "/health/ready",
            "/health/live"
        ]
    }))
}

#[actix_web::main]
async fn main() -> Result<(), anyhow::Error> {
    dotenvy::dotenv().ok();
    let database_url = std::env::var("DATABASE_URL").expect("DATABASE_URL must be set");
    let port = std::env::var("PORT")
        .unwrap_or_else(|_| "8080".to_string())
        .parse::<u16>()
        .expect("PORT must be a number");
    println!("\n========================================");
    println!("🚀 SDD NAVIGATOR API");
    println!("========================================");
    println!("🔌 Port: {}", port);
    println!("🗄️ Database: {}", database_url);
    println!("========================================\n");
    println!("📡 Connecting to database...");
    let pool = PgPoolOptions::new()
        .max_connections(5)
        .connect(&database_url)
        .await?;
    println!("✅ Connected to database!\n");
    println!("🌐 Starting server on 0.0.0.0:{}\n", port);
    HttpServer::new(move || {
        App::new()
            .app_data(actix_web::web::Data::new(pool.clone()))
            .route("/", web::get().to(root))
            .configure(health::init)
    })
    .bind(("0.0.0.0", port))?
    .run()
    .await?;

    Ok(())
}
