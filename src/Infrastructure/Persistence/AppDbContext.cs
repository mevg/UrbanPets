namespace UrbanPets.Infrastructure.Persistence;

public sealed class AppDbContext(DbContextOptions options) : DbContext(options) {
    protected override void OnModelCreating(ModelBuilder modelBuilder) {
        base.OnModelCreating(modelBuilder);
    }
}