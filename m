Date: Thu, 5 Oct 2006 21:33:23 +0200
From: Gergely Madarasz <gorgo@broadband.hu>
Message-ID: <20061005193323.GK14590@broadband.hu>
References: <4c9f8dc30610042120o3089cbf6yaaa00728b271953f@mail.gmail.com>
	<20061005073953.4a8bdd6b@localhost.localdomain>
	<4c9f8dc30610051207p4b040d40r50fa82afa561de19@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c9f8dc30610051207p4b040d40r50fa82afa561de19@mail.gmail.com>
Subject: Re: [Bridge] Bridge Woes...
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Chris U <chris.uyehara@hawaii.edu>
Cc: bridge@lists.osdl.org

On Thu, Oct 05, 2006 at 09:07:14AM -1000, Chris U wrote:
> Hardware... neither are wireless devices.
> 04:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5721 Gigabit
> Ethernet PCI Express (rev 11)
> 05:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5721 Gigabit
> Ethernet PCI Express (rev 11)

If this a server with an ipmi bmc and the network card firmware supporting
ipmi, you might be experiencing the same problem as I did last year. 

The situation was that the broadcom firmware turned off promisc several
seconds after the card was set up. So if the driver set promisc right
after ifconfig up, it never noticed that the hardware actually cancelled
promisc mode. Small workaround to test this: ifconfig eth0 -promisc;
ifconfig eth0 promisc a minute after it has been brought up by ifconfig.

A more permanent workaround was to turn off IPMI support in the network
card using a utility downloaded from the vendor... 

-- 
Madarasz Gergely        gorgo@broadband.hu         gorgo@linux.rulez.org
    It's practically impossible to look at a penguin and feel angry.
        Egy pingvinre gyakorlatilag lehetetlen haragosan nezni.
