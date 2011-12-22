Return-Path: <equinox@diac24.net>
Date: Thu, 22 Dec 2011 15:35:55 +0100
From: David Lamparter <equinox@diac24.net>
Message-ID: <20111222143555.GB1054159@jupiter.n2.diac24.net>
References: <b8003b95089e177b00bc7db44700757a@pl1.haspere.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8003b95089e177b00bc7db44700757a@pl1.haspere.com>
Subject: Re: [Bridge] Invalid Argument when adding a bond to a bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Dyweni - NetDev <xmCM8KtKk25K@dyweni.com>
Cc: NetDev <netdev@vger.kernel.org>, Bridge <bridge@lists.linux-foundation.org>, Bonding Devel <bonding-devel@lists.sourceforge.net>

Add an interface to the bond, then add the bond to the bridge.

bond without interface = 00:00:00:00:00:00 MAC = invalid.

On Thu, Dec 22, 2011 at 08:25:54AM -0600, Dyweni - NetDev wrote:
>  I created the bond with: echo "+x" > /sys/class/net/bonding_masters
> 
>  I created the bridge with: brctl addbr b
> 
>  I try to add the bond to the bridge with: brctl addif b x

