Date: Mon, 13 Oct 2003 19:00:39 +0200
From: Gergely Madarasz <gorgo@thunderchild.debian.net>
Subject: Re: [Bridge] hw checksum problems
Message-ID: <20031013170039.GO8160@thunderchild.debian.net>
References: <20031013111647.GK8160@thunderchild.debian.net>
	<20031013121901.GM8160@thunderchild.debian.net>
	<20031013091533.20296086.shemminger@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031013091533.20296086.shemminger@osdl.org>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org

On Mon, Oct 13, 2003 at 09:15:33AM -0700, Stephen Hemminger wrote:
> On Mon, 13 Oct 2003 14:19:01 +0200
> Gergely Madarasz <gorgo@thunderchild.debian.net> wrote:
> 
> > On Mon, Oct 13, 2003 at 01:16:47PM +0200, Gergely Madarasz wrote:
> > > checksums (and cannot be turned off in the driver). I applied the patch
                                                          ^^^^^^^^^^^^^^^^^^^
> > > (to set CHECKSUM_NONE on forwarded packets), but I still get kernel oopses
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Fixed in 2.6.0-test6 or 2.4.23 or use this patch posted earlier to the list...
> --------------

So my problem is actually not fixed. And in my third mail I sent in some
oopses that were caused by locally generated packets.

-- 
Madarasz Gergely   gorgo@thunderchild.debian.net   gorgo@linux.rulez.org
    It's practically impossible to look at a penguin and feel angry.
        Egy pingvinre gyakorlatilag lehetetlen haragosan nezni.
