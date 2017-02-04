using CSQLtesttask.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace CSQLtesttask.Controllers
{
    [RoutePrefix("api/tasks")]
    public class TasksController : ApiController
    {
        private readonly DbModel _db;

        public TasksController()
        {
            _db = new DbModel();
        }

        /// <summary>
        /// Find clients that do not consume any service.
        /// </summary>
        /// <returns></returns>
        [Route("task4")] 
        public IEnumerable<vw_Task4> GetTask4()
        {
            return _db.vw_Task4.AsEnumerable();
        }

        /// <summary>
        /// Find all clients that consume S1​ or S2​ services.
        /// </summary>
        /// <returns></returns>
        [Route("task5")]
        public IEnumerable<vw_Task5> GetTask5()
        {
            return _db.vw_Task5.AsEnumerable();
        }

        /// <summary>
        /// Find all clients that consume S​1​ ​and​ ​S​2​ services. 
        /// </summary>
        /// <returns></returns>
        [Route("task6")]
        public IEnumerable<vw_Task6> GetTask6()
        {
            return _db.vw_Task6.AsEnumerable();
        }

        /// <summary>
        /// Find all clients that consume only S​1​ ​and​ ​S​2​ services.
        /// </summary>
        /// <returns></returns>
        [Route("task7")]
        public IEnumerable<vw_Task7> GetTask7()
        {
            return _db.vw_Task7.AsEnumerable();
        }

        /// <summary>
        /// Find all clients that do not consume S​1 ​service.
        /// </summary>
        /// <returns></returns>
        [Route("task8")]
        public IEnumerable<vw_Task8> GetTask8()
        {
            return _db.vw_Task8.AsEnumerable();
        }

        /// <summary>
        /// Find all clients that consume S​1​ service but do not consume S​2 ​service.
        /// </summary>
        /// <returns></returns>
        [Route("task9")]
        public IEnumerable<vw_Task9> GetTask9()
        {
            return _db.vw_Task9.AsEnumerable();
        }

        protected override void Dispose(bool disposing)
        {
            base.Dispose(disposing);

            _db.Dispose();

            GC.SuppressFinalize(this);
        }
    }
}
