Date: Thu, 9 Sep 2004 08:21:29 -0700
From: "David S. Miller" <davem@davemloft.net>
Message-Id: <20040909082129.62059694.davem@davemloft.net>
In-Reply-To: <414057B1.1020902@siennax.com>
References: <414057B1.1020902@siennax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: Problem in changed VLAN code can cause systems to hang.
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Mark Ruijter <bridge@siennax.com>
Cc: davem@redhat.com, bridge@lists.osdl.org, shemminger@osdl.org

On Thu, 09 Sep 2004 15:16:33 +0200
Mark Ruijter <bridge@siennax.com> wrote:

> I noticed that the VLAN code of kernels >=2.6.8 contain the patch needed 
> to mirror link state information from the real device to the vlan device.
> 
> This however causes the system to hang in combination with net-snmpd.
> The last thing that I see is an ioctl(0x8947...

What kind of ethernet devices do you have making use of VLAN?
