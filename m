Date: Thu, 18 May 2006 08:40:23 +0200
From: Gergely Madarasz <gorgo@broadband.hu>
Subject: Re: [Bridge] VLAN translation + PVST+
Message-ID: <20060518064022.GF20794@broadband.hu>
References: <446BC951.2050803@us.checkpoint.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <446BC951.2050803@us.checkpoint.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Ian Schwimmer <ischwimm@us.checkpoint.com>
Cc: bridge@lists.osdl.org

On Wed, May 17, 2006 at 06:09:37PM -0700, Ian Schwimmer wrote:
> Hello, I am creating a configuration where a Redhat server running 
> bridge-tools 0.9.5 will be bridging between different VLANs on the same 
> physical interface (for example: a bridge consisting of eth1.100 and 
> eth1.110). This physical interface is being connected to modern Cisco 
> switches running PVST+.
> 
> The Cisco switch does not like this configuration as the tags on its 
> BPDUs are being changed but the contents of the BPDUs are left unchanged.
> 
> I need to be running PVST+ because there will be multiple Linux servers 
> performing this VLAN translation/remapping (so there are going to be 
> some loops that I will need blocked).
> 
> Has anyone succeeded in getting VLAN translation/remapping (bridging 
> between two different VLAN tags) working with Cisco PVST+? (not simply 
> disabling spanning tree). Thank you!

Actually I have just written a patch for 2.6.16 the other day which
supports PVST+ packet format. It adds a pvst_vlan attribute to each port
in a bridge, which, if not 0, causes the bpdu's sent on that port to use
the pvst+ llc header and add the vlan tlv at the end of the packet. 

For example you can bridge two vlan interfaces like eth0.4 and eth1.7,
with setting pvst_vlan to 4 on eth0.4 and to 7 on eth1.7 (no automatic
voodoo). Your example can be done too, briding two vlans on the same
trunk.

Should I send the patch to the list or just in private?

-- 
Madarasz Gergely        gorgo@broadband.hu         gorgo@linux.rulez.org
    It's practically impossible to look at a penguin and feel angry.
        Egy pingvinre gyakorlatilag lehetetlen haragosan nezni.
