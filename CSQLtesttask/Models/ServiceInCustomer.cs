namespace CSQLtesttask.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("ServiceInCustomer")]
    public partial class ServiceInCustomer
    {
        public int Id { get; set; }

        public int? ServiceId { get; set; }

        public int CustomerId { get; set; }

        public virtual Customer Customer { get; set; }

        public virtual Service Service { get; set; }
    }
}
