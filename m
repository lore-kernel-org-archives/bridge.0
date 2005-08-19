Date: Fri, 19 Aug 2005 07:35:24 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Problem of lock when deleting a bridge
Message-ID: <20050819073524.3ffbf0d2@localhost.localdomain>
In-Reply-To: <34d8b2fe05081823522b9bc5b6@mail.gmail.com>
References: <34d8b2fe05081823522b9bc5b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Louis Croisez <louis.croisez@gmail.com>
Cc: bridge@lists.osdl.org

On Fri, 19 Aug 2005 08:52:21 +0200
Louis Croisez <louis.croisez@gmail.com> wrote:

> When i want to delete my test bridge, using:
> ifconfig eth0 down
> ifconfig eth1 down
> ifconfig br0 down
> brctl delif br0 eth0
> brctl delif br0 eth1
> brctl delbr br0
> 
> i get this error message from the kernel on the console:
> unregister_netdevice: waiting for br0 to become free. Usage count = 2
> The brctl user-level command is blocked.
> 
> Could you explain me what could likely be the cause of this error?

IPV6 is usually the culprit.  All protocols have to keep reference
counts for devices, and there have been several ref count bugs
in ipv6.  If you don't need it build your kernel without it.

Also, which kernel version.  The bug should be fixed in the latest
2.6 kernels.
