Date: Tue, 14 Oct 2003 13:23:42 +0200
From: Gergely Madarasz <gorgo@thunderchild.debian.net>
Subject: Re: [Bridge] hw checksum problems
Message-ID: <20031014112342.GQ8160@thunderchild.debian.net>
References: <20031013111647.GK8160@thunderchild.debian.net>
	<20031013121901.GM8160@thunderchild.debian.net>
	<20031013151454.GN8160@thunderchild.debian.net>
	<p05111b01bbb180787e47@[10.96.96.13]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p05111b01bbb180787e47@[10.96.96.13]>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Hannes Schulz <schulz@schwaar.com>
Cc: bridge@lists.osdl.org

On Tue, Oct 14, 2003 at 12:35:48PM +0200, Hannes Schulz wrote:
> >> Oh, I forgot :) The kernel is 2.4.22 with the execshield patch. The cards
> >> work nicely when there is no bridge. One more specific info: when 
> >> bridged,
> >> under normal circumstances the hme port is in blocking state (it should
> >> start forwarding only if the tg3 link is down).
> 
> 
> There are 2 patches regarding bridging:
> 
> shemminger	1.1109.2.4 
> 	[BRIDGE]: Clear hw checksum flags when bridging.
> karlis	1.1063.40.5	[BRIDGE]: kfree --> kfree_skb.
> [these are messages from the bitkeeper log]
> 
> Both of them are in 2.4.23pre4. Either retry with 2.4.23pre4 or apply 
> those patches manually. I think you mentioned that you have applied 
> the first patch. The second patch fixed a memory corruption problem. 
> I have a bridged environment and *no* problems with it.

Thanks, so far it seems my problem has been fixed (2.4.23pre7 installed
now). My machine survived a ping -s 2000 -f <broadcastaddr> ;). 2.4.22
crashed instantly from this command :).

-- 
Madarasz Gergely   gorgo@thunderchild.debian.net   gorgo@linux.rulez.org
    It's practically impossible to look at a penguin and feel angry.
        Egy pingvinre gyakorlatilag lehetetlen haragosan nezni.
