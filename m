Return-Path: <arnd@arndb.de>
MIME-Version: 1.0
References: <20211222191320.17662-1-repk@triplefau.lt>
In-Reply-To: <20211222191320.17662-1-repk@triplefau.lt>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 22 Dec 2021 22:52:20 +0100
Message-ID: <CAK8P3a18b63GoPKiTey8KpEusyffbN97gxP+NM3fyZnOYXv5zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [PATCH net] net: bridge: fix ioctl old_deviceless
	bridge argument
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Remi Pommarel <repk@triplefau.lt>
Cc: Arnd Bergmann <arnd@arndb.de>, Networking <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

On Wed, Dec 22, 2021 at 8:13 PM Remi Pommarel <repk@triplefau.lt> wrote:
>
> Commit 561d8352818f ("bridge: use ndo_siocdevprivate") changed the
> source and destination arguments of copy_{to,from}_user in bridge's
> old_deviceless() from args[1] to uarg breaking SIOC{G,S}IFBR ioctls.
>
> Commit cbd7ad29a507 ("net: bridge: fix ioctl old_deviceless bridge
> argument") fixed only BRCTL_{ADD,DEL}_BRIDGES commands leaving
> BRCTL_GET_BRIDGES one untouched.
>
> The fixes BRCTL_GET_BRIDGES as well
>
> Fixes: 561d8352818f ("bridge: use ndo_siocdevprivate")
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>

Thanks for fixing the regression,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

> ---
>  net/bridge/br_ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
> index db4ab2c2ce18..891cfcf45644 100644
> --- a/net/bridge/br_ioctl.c
> +++ b/net/bridge/br_ioctl.c
> @@ -337,7 +337,7 @@ static int old_deviceless(struct net *net, void __user *uarg)
>
>                 args[2] = get_bridge_ifindices(net, indices, args[2]);
>
> -               ret = copy_to_user(uarg, indices,
> +               ret = copy_to_user((void __user *)args[1], indices,
>                                    array_size(args[2], sizeof(int)))
>                         ? -EFAULT : args[2];

The intention of my broken patch was to make it work for compat mode as I did
in br_dev_siocdevprivate(), as this is now the only bit that remains broken.

This could be done along the lines of the patch below, if you see any value in
it. (not tested, probably not quite right).

       Arnd

diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
index db4ab2c2ce18..138aa96d73f9 100644
--- a/net/bridge/br_ioctl.c
+++ b/net/bridge/br_ioctl.c
@@ -102,19 +102,9 @@ static int add_del_if(struct net_bridge *br, int
ifindex, int isadd)
        return ret;
 }

-/*
- * Legacy ioctl's through SIOCDEVPRIVATE
- * This interface is deprecated because it was too difficult
- * to do the translation for 32/64bit ioctl compatibility.
- */
-int br_dev_siocdevprivate(struct net_device *dev, struct ifreq *rq,
void __user *data, int cmd)
+static int br_dev_read_uargs(unsigned long *args, void __user *argp,
+                            void __user *data)
 {
-       struct net_bridge *br = netdev_priv(dev);
-       struct net_bridge_port *p = NULL;
-       unsigned long args[4];
-       void __user *argp;
-       int ret = -EOPNOTSUPP;
-
        if (in_compat_syscall()) {
                unsigned int cargs[4];

@@ -126,13 +116,29 @@ int br_dev_siocdevprivate(struct net_device
*dev, struct ifreq *rq, void __user
                args[2] = cargs[2];
                args[3] = cargs[3];

-               argp = compat_ptr(args[1]);
+               *argp = compat_ptr(args[1]);
        } else {
                if (copy_from_user(args, data, sizeof(args)))
                        return -EFAULT;

-               argp = (void __user *)args[1];
+               *argp = (void __user *)args[1];
        }
+}
+
+/*
+ * Legacy ioctl's through SIOCDEVPRIVATE
+ * This interface is deprecated because it was too difficult
+ * to do the translation for 32/64bit ioctl compatibility.
+ */
+int br_dev_siocdevprivate(struct net_device *dev, struct ifreq *rq,
void __user *data, int cmd)
+{
+       struct net_bridge *br = netdev_priv(dev);
+       struct net_bridge_port *p = NULL;
+       unsigned long args[4];
+       void __user *argp;
+       int ret;
+
+       ret = br_dev_read_uargs(args, &argp, data);

        switch (args[0]) {
        case BRCTL_ADD_IF:
@@ -301,6 +307,9 @@ int br_dev_siocdevprivate(struct net_device *dev,
struct ifreq *rq, void __user

        case BRCTL_GET_FDB_ENTRIES:
                return get_fdb_entries(br, argp, args[2], args[3]);
+
+       default:
+               ret = -EOPNOTSUPP;
        }

        if (!ret) {
@@ -315,10 +324,13 @@ int br_dev_siocdevprivate(struct net_device
*dev, struct ifreq *rq, void __user

 static int old_deviceless(struct net *net, void __user *uarg)
 {
-       unsigned long args[3];
+       unsigned long args[4];
+       void __user *argp;
+       int ret;

-       if (copy_from_user(args, uarg, sizeof(args)))
-               return -EFAULT;
+       ret = br_dev_read_uargs(args, &argp, data);
+       if (ret)
+               return ret;

        switch (args[0]) {
        case BRCTL_GET_VERSION:
@@ -337,7 +349,7 @@ static int old_deviceless(struct net *net, void
__user *uarg)

                args[2] = get_bridge_ifindices(net, indices, args[2]);

-               ret = copy_to_user(uarg, indices,
+               ret = copy_to_user(argp, indices,
                                   array_size(args[2], sizeof(int)))
                        ? -EFAULT : args[2];

@@ -353,7 +365,7 @@ static int old_deviceless(struct net *net, void
__user *uarg)
                if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
                        return -EPERM;

-               if (copy_from_user(buf, (void __user *)args[1], IFNAMSIZ))
+               if (copy_from_user(buf, argp, IFNAMSIZ))
                        return -EFAULT;

                buf[IFNAMSIZ-1] = 0;
