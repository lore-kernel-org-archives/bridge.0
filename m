Message-ID: <414057B1.1020902@siennax.com>
Date: Thu, 09 Sep 2004 15:16:33 +0200
From: Mark Ruijter <bridge@siennax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Problem in changed VLAN code can cause systems to hang.
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>, bridge@lists.osdl.org
Cc: "David S. Miller" <davem@redhat.com>


Stephen,

I noticed that the VLAN code of kernels >=2.6.8 contain the patch needed 
to mirror link state information from the real device to the vlan device.

This however causes the system to hang in combination with net-snmpd.
The last thing that I see is an ioctl(0x8947...

 From the net-snmp code:
---

         if (ioctl(fd, 0x8947, &ifr) >= 0) {
                 new_ioctl_nums = 1;
         } else if (ioctl(fd, SIOCDEVPRIVATE, &ifr) >= 0) {
                 new_ioctl_nums = 0;
         } else {
                 DEBUGMSGTL(("mibII/interfaces", "SIOCGMIIPHY on %s 
failed\n", ifr.ifr_name));
                 return retspeed;
         }

---

I suspected the code below so I commented out the SIOCGMIIPHY line:


  int vlan_dev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
{
         struct net_device *real_dev = VLAN_DEV_INFO(dev)->real_dev;
         struct ifreq ifrr;
         int err = -EOPNOTSUPP;

         strncpy(ifrr.ifr_name, real_dev->name, IFNAMSIZ);
         ifrr.ifr_ifru = ifr->ifr_ifru;

         switch(cmd) {
         //case SIOCGMIIPHY:
         case SIOCGMIIREG:
         case SIOCSMIIREG:
                 if (real_dev->do_ioctl && netif_device_present(real_dev))
                         err = real_dev->do_ioctl(dev, &ifrr, cmd);
                 break;

         case SIOCETHTOOL:
                 err = dev_ethtool(&ifrr);
         }

         if (!err)
                 ifr->ifr_ifru = ifrr.ifr_ifru;

         return err;
}

This fixes the problem. I didn't bother to check what this call actually 
does and why it doesn't work.

Mark.



