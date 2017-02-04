namespace CSQLtesttask.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class vw_Task6
    {
        [Key]
        [StringLength(100)]
        public string Customer { get; set; }
    }
}
