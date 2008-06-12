From: Luis Carlos Cobo <luisca@cozybit.com>
In-Reply-To: <20080612053323.GC4919@jm.kir.nu>
References: <1213232760.6645.24.camel@localhost>
	<20080612053323.GC4919@jm.kir.nu>
Content-Type: text/plain
Date: Thu, 12 Jun 2008 11:10:50 -0700
Message-Id: <1213294251.6615.5.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC] Do not activate promiscuous mode on wlan
	interfaces for	bridging.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jouni Malinen <j@w1.fi>
Cc: johannes@sipsolutions.net, linux-wireless@vger.kernel.org, bridge@linux-foundation.org, Linux Netdev List <netdev@vger.kernel.org>

Thank you very much for your comments Jouni.

On Thu, 2008-06-12 at 08:33 +0300, Jouni Malinen wrote:
> Whether the "promiscuous mode" is really a suitable name for this mode
> is another question, though, since there are more ways to be
> promiscuous in wireless networks than wired.. ;-)

Indeed, but the bridge sets promiscuous mode, not monitor. This means
that the device will receive every frame within its configured BSS
whether it is addressed to it or not. For an AP actually this mode
should make no difference, since every frame not coming from the AP is
addressed to the AP.


> This is not strictly speaking correct. 4-address frame format (WDS) can
> be used in other (non-AP) modes, too. Anyway, they do not require the
> interface to be in promiscuous mode since addr1 of the frames is the
> unicast address of the receiving device regardless of the original
> destination address.

Agreed, will reword that.

-- 
Luis Carlos Cobo Rus       GnuPG ID: 44019B60
cozybit Inc.


