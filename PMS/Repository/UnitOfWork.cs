using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PMS.Repository
{
    public class UnitOfWork : IUnitOfWork, IDisposable
    {
        private readonly DatabaseContext _dbContext;
        private readonly Dictionary<Type, object> _repositories = new Dictionary<Type, object>();

        private bool disposed;

        public UnitOfWork(DatabaseContext dbContext)
        {
            _dbContext = dbContext;
        }

        public Dictionary<Type, object> Repositories
        {
            get => _repositories;
            set { Repositories = value; }
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        public IGenericRepository<T> Repository<T>() where T : class
        {
            if (Repositories.Keys.Contains(typeof(T)))
            {
                return Repositories[typeof(T)] as IGenericRepository<T>;
            }

            IGenericRepository<T> repo = new GenericRepository<T>(_dbContext);
            Repositories.Add(typeof(T), repo);
            return repo;
        }

        public async Task<int> CommitAsync()
        {
            return await _dbContext.SaveChangesAsync();
        }

        void IUnitOfWork.Commit()
        {
            _dbContext.SaveChanges();
        }

        public void Rollback()
        {
            _dbContext.ChangeTracker.Entries().ToList().ForEach(x => x.Reload());
        }

        protected virtual void Dispose(bool disposing)
        {
            if (!disposed)
            {
                if (disposing)
                {
                    _dbContext.Dispose();
                }
            }

            disposed = true;
        }
    }
}