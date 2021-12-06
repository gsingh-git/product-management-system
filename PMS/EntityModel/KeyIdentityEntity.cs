using System.ComponentModel.DataAnnotations;

namespace PMS.EntityModel
{
    public class KeyIdentityEntity
    {
        [Key] public long Id { get; set; }
    }
}