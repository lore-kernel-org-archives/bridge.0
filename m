Message-ID: <fed120860803130011x252ac57ej8e1c544b8dec8d61@mail.gmail.com>
Date: Thu, 13 Mar 2008 12:41:57 +0530
From: "Srinivas M.A." <srinivas.aji@gmail.com>
In-Reply-To: <47D8B01A.4030501@redfish-solutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <47D57881.2020503@redfish-solutions.com>
	<20080311082347.0140c4d2@extreme>
	<47D74E0C.7060209@redfish-solutions.com>
	<bdfc5d6e0803120746u416403a7vedb821805a6412e6@mail.gmail.com>
	<20080312081445.5f4c138f@extreme>
	<47D824E3.2030001@redfish-solutions.com>
	<bdfc5d6e0803121211g132cd5depebd3dee48f8480fa@mail.gmail.com>
	<47D8B01A.4030501@redfish-solutions.com>
Subject: Re: [Bridge] Question about using brctl and changing MAC addresses
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Philip Prindeville <philipp_subx@redfish-solutions.com>
Cc: bridge@linux-foundation.org

Philip, sorry for the duplicate email. Forgot to CC the list the first time.

Perhaps the needed patch is the following, which allows setting the
bridge hardware address to anything rather than just one of the port
interface addresses. Seems to have got in after Linux  2.6.21, so
should be in 2.6.22.

[~/git/linux-2.6] git-describe ffe1d49cc300f3dff990093aa952a2fbb371c1b6
v2.6.21-324-gffe1d49

[~/git/linux-2.6] git-diff-tree -p --pretty=fuller
ffe1d49cc300f3dff990093aa952a2fbb371c1b6
commit ffe1d49cc300f3dff990093aa952a2fbb371c1b6
Author:     Stephen Hemminger <shemminger@linux-foundation.org>
AuthorDate: Mon Apr 9 11:49:58 2007 -0700
Commit:     David S. Miller <davem@sunset.davemloft.net>
CommitDate: Wed Apr 25 22:28:50 2007 -0700

   bridge: allow changing hardware address to any valid address

   For case of bridging pseudo devices, the get created/destroyed (Xen)
   need to allow setting address to any valid value.

   Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index b22ada5..39b87da 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -83,27 +83,22 @@ static int br_change_mtu(struct net_device *dev,
int new_mtu)
       return 0;
 }

-/* Allow setting mac address of pseudo-bridge to be same as
- * any of the bound interfaces
- */
+/* Allow setting mac address to any valid ethernet address. */
 static int br_set_mac_address(struct net_device *dev, void *p)
 {
       struct net_bridge *br = netdev_priv(dev);
       struct sockaddr *addr = p;
       struct net_bridge_port *port;
-       int err = -EADDRNOTAVAIL;
+
+       if (!is_valid_ether_addr(addr->sa_data))
+               return -EINVAL;

       spin_lock_bh(&br->lock);
-       list_for_each_entry(port, &br->port_list, list) {
-               if (!compare_ether_addr(port->dev->dev_addr, addr->sa_data)) {
-                       br_stp_change_bridge_id(br, addr->sa_data);
-                       err = 0;
-                       break;
-               }
-       }
+       memcpy(dev->dev_addr, addr->sa_data, ETH_ALEN);
+       br_stp_change_bridge_id(br, addr->sa_data);
       spin_unlock_bh(&br->lock);

-       return err;
+       return 0;
 }

 static void br_getinfo(struct net_device *dev, struct ethtool_drvinfo *info)


On Thu, Mar 13, 2008 at 10:09 AM, Philip Prindeville
<philipp_subx@redfish-solutions.com> wrote:
>
>  Well, I don't get it then.
>
>  I'm running Linux 2.6.20, with bridge-utils-1.2, and I'm still seeing it.
>
>  Can you send me the link to the patch, and I'll make sure it's in my
>  sources?
>
>  Thanks,
>
>  -Philip
