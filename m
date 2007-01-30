From: Daniele Palumbo <daniele.palumbo@mail.ing.unibo.it>
Date: Tue, 30 Jan 2007 18:07:59 +0100
References: <200701301408.22029.daniele@retaggio.net>
In-Reply-To: <200701301408.22029.daniele@retaggio.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701301807.59265.daniele.palumbo@mail.ing.unibo.it>
Subject: Re: [Bridge] tagged vlan + bridge: good with xen bad otherwise
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

On Tuesday 30 January 2007 14:08, Daniele Palumbo wrote:
> first of all, this is not xen-related, but i found the problem managing
> with xen.
> so, knowledge of xen is only suggested.

find out why:
xen do (not by its choise, it's a "bug"):
eth1 - xenbr1 - veth1 - ifconfig veth1 up
                      \ vconfig add veth1 600 - veth1.600 - xenbr1.600
                      \ vconfig add veth1 14 - veth1.14 - xenbr1.14

> i want two type of bridge:
> xenbr1 (with eth1 and other interfaces added later)
> xenbr1.14 (with eth1.14 and other interfaces added later)
>
> xenbr1 must have all the traffic tagged.
> xenbr1.14 must have untagged traffic for vlan 14.

so now:
how can i manage something like:

eth1 - xenbr1
     \ vconfig add eth1 600 - eth1.600 - xenbr1.600
     \ vconfig add eth1 14 - eth1.14 - xenbr1.14
?

in first (working) scenario, the problem is that ALL traffic goes through 
xenbr1... with one more step against second scenario.

thanks
d.
