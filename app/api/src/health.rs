// @req REQ-INFRA-002 Health check with database connectivity
use actix_web::{get, web, HttpResponse, Responder};
use sqlx::PgPool;

#[get("/health")]
async fn health_check(pool: web::Data<PgPool>) -> impl Responder {
    match sqlx::query("SELECT 1").execute(pool.get_ref()).await {
        Ok(_) => HttpResponse::Ok().json(serde_json::json!({"status": "healthy", "database": "connected"})),
        Err(e) => HttpResponse::InternalServerError().json(serde_json::json!({"status": "unhealthy", "database": "disconnected", "error": e.to_string()})),
    }
}

pub fn init(cfg: &mut web::ServiceConfig) {
    cfg.service(health_check);
}
