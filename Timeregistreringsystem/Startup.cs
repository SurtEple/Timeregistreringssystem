using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Timeregistreringssystem.Startup))]
namespace Timeregistreringssystem
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
