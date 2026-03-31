// @req REQ-INFRA-002 Health check with database connectivity
use actix_web::{web, HttpResponse, Responder};

pub fn init(cfg: &mut web::ServiceConfig) {
    cfg.service(
        web::scope("/health")
            .route("", web::get().to(health_check))
            .route("/ready", web::get().to(readiness_check))
            .route("/live", web::get().to(liveness_check)),
    );
}

async fn health_check() -> impl Responder {
    println!("📊 Health check requested");
    HttpResponse::Ok().json(serde_json::json!({
        "status": "ok",
        "service": "sdd-navigator-api"
    }))
}

async fn liveness_check() -> impl Responder {
    println!("💚 Liveness probe");
    HttpResponse::Ok().json(serde_json::json!({
        "status": "alive"
    }))
}

async fn readiness_check(pool: web::Data<sqlx::PgPool>) -> impl Responder {
    println!("🔍 Readiness check");
    match sqlx::query("SELECT 1").fetch_one(pool.get_ref()).await {
        Ok(_) => {
            println!("   ✅ Database ready");
            HttpResponse::Ok().json(serde_json::json!({
                "status": "ready",
                "database": "connected"
            }))
        }
        Err(e) => {
            println!("   ❌ Database not ready: {}", e);
            HttpResponse::ServiceUnavailable().json(serde_json::json!({
                "status": "not_ready",
                "database": "disconnected"
            }))
        }
    }
}
