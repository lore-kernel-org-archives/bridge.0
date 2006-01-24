Date: Tue, 24 Jan 2006 09:21:43 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20060124092143.21ff20eb@dxpl.pdx.osdl.net>
In-Reply-To: <43D55D37.23391.4DDFB40@spam.atomtrap.com>
References: <43D55D37.23391.4DDFB40@spam.atomtrap.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: Interface MAC address assignment
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Ashley Hatch <spam@atomtrap.com>
Cc: bridge@lists.osdl.org

On Mon, 23 Jan 2006 22:48:23 -0800
"Ashley Hatch" <spam@atomtrap.com> wrote:

> - SUMMARY - 
> 
> It seems like you should be able to assign your MAC on the bridging 
> interfaces for IP L2 -> L3 mappings, or at least choose which NIC 
> supplies the MAC.
> 
> Since my L2 mapping to my L3 address has nothing to do with my STP 
> bridge ID, why can't we decouple them and have MAC locking or setting 
> as an option to BRCTL and the kernel module so that brctl could 
> prefer a NIC or ifconfig could set it for the purposes of IP?
> 
> - END SUMMARY -
> 
> Presently the system choose the lowest MAC for the purposes of STP 
> and also assigns this MAC for the purposes of IP. This is fine for 
> STP but certainly unnecessary for IP. The bridge ID and the IP/MAC do 
> not need to be the same and in some cases certainly should not be 
> (unless I'm missing something obvious).
> 
> I have looked through the code of brctl and the ethernet bridging 
> code in the kernel and I have not found a way to resolve the 
> following issue short of recoding it, and I can't seem to get a 
> google search to help either.
> 
> When I create a bridging interface doing something like this:
> 
> brctl addbr br0
> brctl addif br0 eth0
> brctl addif br0 eth1
> 
> The resulting MAC address of the interface br0 is the lowest of all 
> MACs. From an STP standpoint, this makes sense. I am using VMWARE 
> virtual interfaces on a few machines, and these MACs are lower than 
> some of my real NICs. They are not unique however. So when I bridge 
> my virtual net and vmnet I sometimes get non-unique MACs on my real 
> L2 network and the machines with the non-unique MAC of course cannot 
> communicate. What I am doing to get around this is assign my REAL NIC 
> MACs from OUIs which make them lower than the vmnet OUI. That feels 
> tacky and wrong.
> 
> I thought to myself, "I'll just assign BR0 the MAC of my NIC (which 
> is higher than VMNET2)." Alas 
> 
> ifconfig br0 hw ether aa:bb:cc:dd:ee:ff
> 
> Gives an ioctl error, and indeed is insupported in the kernel as far 
> as I can tell. A buddy of mine and I are trying to hack it in, but it 
> seems like something that should be in the mainline of the kernel.
> 
> If noone in briding is willing to support it, will someone consider a 
> patch to do it?
> 
> Thanks,
> Ashley Hatch
> Senior Network Engineer - UNLV

In 2.6.15 or later it can be changed to any of the existing interfaces.
I allowed that because it won't break the forwarding tables, and only
slightly effects STP.  (There is a higher risk of STP cycles).




-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
