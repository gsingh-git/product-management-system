using System.ComponentModel.DataAnnotations;

namespace PMS.EntityModel
{
    public class BaseNameCodeEntity
    {
        [Key] public int Id { get; set; }

        public string Name { get; set; }
        public string Code { get; set; }
    }
}