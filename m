Date: Mon, 13 Oct 2003 14:19:01 +0200
From: Gergely Madarasz <gorgo@thunderchild.debian.net>
Subject: Re: [Bridge] hw checksum problems
Message-ID: <20031013121901.GM8160@thunderchild.debian.net>
References: <20031013111647.GK8160@thunderchild.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031013111647.GK8160@thunderchild.debian.net>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

On Mon, Oct 13, 2003 at 01:16:47PM +0200, Gergely Madarasz wrote:
> Hello,
> 
> I'm trying to make a bridge between a Broadcom BCM5703 gigabit ethernet
> and a sun happy meal fastethernet interface. The sunhme card supports hw
> checksums (and cannot be turned off in the driver). I applied the patch
> (to set CHECKSUM_NONE on forwarded packets), but I still get kernel oopses
> (though it seems less often than before). I cannot tell exactly what
> triggers it, sometimes it seems a large ping, sometimes a broadcast ping,
> sometimes just normal network traffic. Any ideas?

Oh, I forgot :) The kernel is 2.4.22 with the execshield patch. The cards
work nicely when there is no bridge. One more specific info: when bridged,
under normal circumstances the hme port is in blocking state (it should
start forwarding only if the tg3 link is down). 

-- 
Madarasz Gergely   gorgo@thunderchild.debian.net   gorgo@linux.rulez.org
    It's practically impossible to look at a penguin and feel angry.
        Egy pingvinre gyakorlatilag lehetetlen haragosan nezni.
