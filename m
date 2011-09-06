Date: Tue, 6 Sep 2011 14:20:40 +0200
From: Ralf Baechle <ralf@linux-mips.org>
Message-ID: <20110906122040.GA25774@linux-mips.org>
References: <1314905304-16485-1-git-send-email-jpirko@redhat.com>
	<20110902122630.GC1991@minipsycho>
	<1314989161.3419.5.camel@bwh-desktop>
	<20110903133428.GA2821@minipsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110903133428.GA2821@minipsycho>
Subject: Re: [Bridge] [patch net-next-2.6 v3] net: consolidate and fix
 ethtool_ops->get_settings calling
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jiri Pirko <jpirko@redhat.com>, tg@linux-mips.org
Cc: amit.salecha@qlogic.com, bridge@lists.linux-foundation.org, linux-mips@linux-mips.org, devel@open-fcoe.org, linux-scsi@vger.kernel.org, decot@google.com, therbert@google.com, robert.w.love@intel.com, eric.dumazet@gmail.com, fubar@us.ibm.com, JBottomley@parallels.com, xiaosuo@gmail.com, paulmck@linux.vnet.ibm.com, alexander.h.duyck@intel.com, mirq-linux@rere.qmqm.pl, Ben Hutchings <bhutchings@solarflare.com>, greearb@candelatech.com, bprakash@broadcom.com, laijs@cn.fujitsu.com, netdev@vger.kernel.org, davem@davemloft.net, loke.chetan@gmail.com

On Sat, Sep 03, 2011 at 03:34:30PM +0200, Jiri Pirko wrote:

>  arch/mips/txx9/generic/setup_tx4939.c |    2 +-

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Feel free to merge this through the net tree.

  Ralf
