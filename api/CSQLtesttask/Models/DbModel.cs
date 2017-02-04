namespace CSQLtesttask.Models
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class DbModel : DbContext
    {
        public DbModel()
            : base("name=DbModel")
        {
        }

        public virtual DbSet<Company> Companies { get; set; }
        public virtual DbSet<Customer> Customers { get; set; }
        public virtual DbSet<Service> Services { get; set; }
        public virtual DbSet<ServiceInCustomer> ServiceInCustomers { get; set; }
        public virtual DbSet<vw_Task10> vw_Task10 { get; set; }
        public virtual DbSet<vw_Task11> vw_Task11 { get; set; }
        public virtual DbSet<vw_Task12> vw_Task12 { get; set; }
        public virtual DbSet<vw_Task4> vw_Task4 { get; set; }
        public virtual DbSet<vw_Task5> vw_Task5 { get; set; }
        public virtual DbSet<vw_Task6> vw_Task6 { get; set; }
        public virtual DbSet<vw_Task7> vw_Task7 { get; set; }
        public virtual DbSet<vw_Task8> vw_Task8 { get; set; }
        public virtual DbSet<vw_Task9> vw_Task9 { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Company>()
                .HasMany(e => e.Services)
                .WithRequired(e => e.Company)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Customer>()
                .HasMany(e => e.ServiceInCustomers)
                .WithRequired(e => e.Customer)
                .WillCascadeOnDelete(false);
        }
    }
}
